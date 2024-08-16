//
//  SoundManager.m
//  TEORBattleTest
//
//  Created by Zach Babb on 5/21/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "SoundManager.h"
#import "SynthesizeSingleton.h"
#import "MyOpenALSupport.h"


@interface SoundManager (Private)

- (BOOL)initOpenAL;

- (NSUInteger)nextAvailableSource;

- (void)setActivated:(BOOL)aState;

- (BOOL)isExternalAudioPlaying;

- (void)checkForErrors;

@end

@implementation SoundManager 

SYNTHESIZE_SINGLETON_FOR_CLASS(SoundManager);

@synthesize currentMusicVolume;
@synthesize fxVolume;
@synthesize isExternalAudioPlaying;
@synthesize isMusicPlaying;
@synthesize usePlaylist;
@synthesize loopLastPlaylistTrack;
@synthesize musicVolume;

- (void)dealloc {
	
	for (NSNumber *sourceIDVal in soundSources) {
		NSUInteger sourceID = [sourceIDVal unsignedIntValue];
		alDeleteSources(1, &sourceID);
	}
	
	NSEnumerator *enumerator = [soundLibrary keyEnumerator];
	id key;
	while ((key = [enumerator nextObject])) {
		NSNumber *bufferIDVal = [soundLibrary objectForKey:key];
		NSUInteger bufferID = [bufferIDVal unsignedIntValue];
		alDeleteBuffers(1, &bufferID);
	}
	
	[soundLibrary release];
	[soundSources release];
	[musicLibrary release];
	[musicPlaylists release];
	if (currentPlaylistTracks) {
		[currentPlaylistTracks release];
	}
	
	if (musicPlayer) {
		[musicPlayer release];
	}
	
	alcMakeContextCurrent(NULL);
	alcDestroyContext(context);
	
	alcCloseDevice(device);
	
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
		soundSources = [[NSMutableArray alloc] init];
		soundLibrary = [[NSMutableDictionary alloc] init];
		musicLibrary = [[NSMutableDictionary alloc] init];
		musicPlaylists = [[NSMutableDictionary alloc] init];
		
		audioSession = [AVAudioSession sharedInstance];
		
		isExternalAudioPlaying = [self isExternalAudioPlaying];
		
		if (!isExternalAudioPlaying) {
			soundCategory = AVAudioSessionCategorySoloAmbient;
			audioSessionError = nil;
			[audioSession setCategory:soundCategory error:&audioSessionError];
			if (audioSessionError) {
				//NSLog(@"WARNING - SoundManager: Error setting the sound category.");
			}
		}
		
		BOOL success = [self initOpenAL];
		if (!success) {
			//NSLog(@"ERROR - could not initialize OpenAL");
			return nil;
		}
		
		currentMusicVolume = 0.5f;
		musicVolume = 0.5f;
		fxVolume = 0.5f;
		playlistIndex = 0;
		
		isFading = NO;
		isMusicPlaying = NO;
		stopMusicAfterFade = YES;
		usePlaylist = NO;
		loopLastPlaylistTrack = NO;
	}
	
	return self;
}

- (void)shutdownSoundManager {
	@synchronized(self) {
		if (sharedSoundManager != nil) {
			[self dealloc];
		}
	}
}

- (void)loadSoundWithKey:(NSString *)aSoundKey soundFile:(NSString *)aMusicFile {
	
	NSNumber *numVal = [soundLibrary objectForKey:aSoundKey];
	
	if (numVal != nil) {
		//NSLog(!"WARNING - sound key '%@' already exists.", aSoundKey);
		return;
	}
	
	NSUInteger bufferID;
	
	alError = AL_NO_ERROR;
	
	alGenBuffers(1, &bufferID);
	
	ALenum format;
	ALsizei size;
	ALsizei frequency;
	ALvoid *data;
	
	NSBundle *bundle = [NSBundle mainBundle];
	
	NSString *fileName = [[aMusicFile lastPathComponent] stringByDeletingPathExtension];
	NSString *fileType = [aMusicFile pathExtension];
	CFURLRef fileURL = (CFURLRef)[[NSURL fileURLWithPath:[bundle pathForResource:fileName ofType:fileType]] retain];
	
	if (fileURL) {
		data = MyGetOpenALAudioData(fileURL, &size, &format, &frequency);
		CFRelease(fileURL);
		
		alBufferData(bufferID, format, data, size, frequency);
		
		free(data);
	} else {
		if (data) {
			free(data);
		}
		data = NULL;
	}
	
	[soundLibrary setObject:[NSNumber numberWithUnsignedInt:bufferID] forKey:aSoundKey];
}

- (void)removeSoundWithKey:(NSString *)aSoundKey {
	
	alError = alGetError();
	alError = AL_NO_ERROR;
	
	NSNumber *numVal = [soundLibrary objectForKey:aSoundKey];
	
	if (numVal == nil) {
		//NSLog(@"No sound for key '%@'", aSoundKey);
		return;
	}
	
	NSUInteger bufferID = [numVal unsignedIntValue];
	NSInteger bufferForSource;
	NSInteger sourceState;
	for (NSNumber *sourceID in soundSources) {
		NSUInteger currentSourceID = [sourceID unsignedIntValue];
		
		alGetSourcei(currentSourceID, AL_SOURCE_STATE, &sourceState);
		alGetSourcei(currentSourceID, AL_BUFFER, &bufferForSource);
		
		if (sourceState != AL_PLAYING || (sourceState == AL_PLAYING && bufferForSource == bufferID)) {
			alSourceStop(currentSourceID);
			alSourcei(currentSourceID, AL_BUFFER, 0);
		}
	}
	
	alDeleteBuffers(1, &bufferID);
	
	[soundLibrary removeObjectForKey:aSoundKey];
	
}

- (void)loadMusicWithKey:(NSString *)aMusicKey musicFile:(NSString *)aMusicFile {
	
	NSString *fileName = [[aMusicFile lastPathComponent] stringByDeletingPathExtension];
	NSString *fileType = [aMusicFile pathExtension];
	
	NSString *path = [musicLibrary objectForKey:aMusicKey];
	
	path = [[NSBundle mainBundle] pathForResource:fileName ofType:fileType];
	
	[musicLibrary setObject:path forKey:aMusicKey];
}

- (void)removeMusicWithKey:(NSString *)aMusicKey {
	
	NSString *path = [musicLibrary objectForKey:aMusicKey];
	
	if (path == NULL) {
		return;
	}
	
	[musicLibrary removeObjectForKey:aMusicKey];
	
}

- (void)addToPlaylistNamed:(NSString *)aPlaylistName track:(NSString *)aTrackName {
	
	NSString *path = [musicLibrary objectForKey:aTrackName];
	if (!path) {
		return;
	}
	
	NSMutableArray *playlistTracks = [musicPlaylists objectForKey:aPlaylistName];
	
	BOOL newPlayList = NO;
	
	if (!playlistTracks) {
		newPlayList = YES;
		playlistTracks = [[NSMutableArray alloc] init];
	}
	
	[playlistTracks addObject:aTrackName];
	
	[musicPlaylists setObject:playlistTracks forKey:aPlaylistName];
	
	if (newPlayList) {
		[playlistTracks release];
	}
}

- (void)startPlaylistNamed:(NSString *)aPlaylistName {
	
	NSMutableArray *playlistTracks = [musicPlaylists objectForKey:aPlaylistName];
	
	if (!playlistTracks) {
		return;
	}
	
	currentPlaylistName = aPlaylistName;
	currentPlaylistTracks = playlistTracks;
	usePlaylist = YES;
	playlistIndex = 0;
	
	[self playMusicWithKey:[playlistTracks objectAtIndex:playlistIndex] timesToRepeat:0];
}

- (void)removeFromPlaylistNamed:(NSString *)aPlaylistName track:(NSString *)aTrackName {
	
	NSMutableArray *playlistTracks = [musicPlaylists objectForKey:aPlaylistName];
	
	if (playlistTracks) {
		int indexToRemove;
		
		for (int index = 0; index < [playlistTracks count]; index++) {
			if ([[playlistTracks objectAtIndex:index] isEqualToString:aTrackName]) {
				indexToRemove = index;
				break;
			}
		}
		
		[playlistTracks removeObjectAtIndex:indexToRemove];
	}
}

- (void)removePlaylistNamed:(NSString *)aPlaylistName {
	[musicPlaylists removeObjectForKey:aPlaylistName];
}

- (void)clearPlaylistNamed:(NSString *)aPlaylistName {
	NSMutableArray *playlistTracks = [musicPlaylists objectForKey:aPlaylistName];
	
	if (playlistTracks) {
		[playlistTracks removeAllObjects];
	}
}

- (NSUInteger)playSoundWithKey:(NSString *)aSoundKey {
	return [self playSoundWithKey:aSoundKey gain:1.0f pitch:1.0f location:CGPointMake(0, 0) shouldLoop:NO];
}

- (NSUInteger)playSoundWithKey:(NSString *)aSoundKey location:(CGPoint)aLocation {
	return [self playSoundWithKey:aSoundKey gain:1.0f pitch:1.0f location:aLocation shouldLoop:NO];
}

- (NSUInteger)playSoundWithKey:(NSString *)aSoundKey gain:(float)aGain pitch:(float)aPitch location:(CGPoint)aLocation shouldLoop:(BOOL)aLoop {
	
	alError = alGetError();
	
	NSNumber *numVal = [soundLibrary objectForKey:aSoundKey];
	if (numVal == nil) {
		return 0;
	}
	
	NSUInteger bufferID = [numVal unsignedIntValue];
	
	NSUInteger sourceID;
	sourceID = [self nextAvailableSource];
	
	if (sourceID == 0) {
		return 0;
	}
	
	alSourcei(sourceID, AL_BUFFER, 0);
	
	alSourcei(sourceID, AL_BUFFER, bufferID);
	
	alSourcef(sourceID, AL_PITCH, aPitch);
	alSourcef(sourceID, AL_GAIN, aGain * fxVolume);
	
	if (aLoop) {
		alSourcei(sourceID, AL_LOOPING, AL_TRUE);
	} else {
		alSourcei(sourceID, AL_LOOPING, AL_FALSE);
	}
	
	alSource3f(sourceID, AL_POSITION, aLocation.x, aLocation.y, 0.0f);
	
	alSourcePlay(sourceID);
	
	alError = alGetError();
	if (alError != 0) {
		return 0;
	}
	
	return sourceID;
}

- (void)stopSoundWithKey:(NSString *)aSoundKey {
	
	alError = alGetError();
	alError = AL_NO_ERROR;
	
	NSNumber *numVal = [soundLibrary objectForKey:aSoundKey];
	
	if (numVal == nil) {
		return;
	}
	
	NSUInteger bufferID = [numVal unsignedIntValue];
	NSInteger bufferForSource;
	for (NSNumber *sourceID in soundSources) {
		NSUInteger currentSourceID = [sourceID unsignedIntValue];
		
		alGetSourcei(currentSourceID, AL_BUFFER, &bufferForSource);
		
		if (bufferForSource == bufferID) {
			alSourceStop(currentSourceID);
			alSourcei(currentSourceID, AL_BUFFER, 0);
		}
	}
}

- (void)playMusicWithKey:(NSString *)aMusicKey timesToRepeat:(NSUInteger)aRepeatCount {
	
	NSError *error;
	
	NSString *path = [musicLibrary objectForKey:aMusicKey];
	
	if (!path) {
		return;
	}
	
	if (musicPlayer) {
		[musicPlayer release];
	}
	
	musicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:&error];
	
	musicPlayer.delegate = self;
	
	[musicPlayer setNumberOfLoops:aRepeatCount];
	
	[musicPlayer setVolume:currentMusicVolume];
	
	[musicPlayer play];
	
	isMusicPlaying = YES;
}

- (void)playNextTrack {
	if (playlistIndex + 1 == [currentPlaylistTracks count] - 1 && loopLastPlaylistTrack) {
		playlistIndex += 1;
		[self playMusicWithKey:[currentPlaylistTracks objectAtIndex:playlistIndex] timesToRepeat:-1];
	} else if (playlistIndex + 1 < [currentPlaylistTracks count]) {
		playlistIndex += 1;
		[self playMusicWithKey:[currentPlaylistTracks objectAtIndex:playlistIndex] timesToRepeat:0];
	} else if (loopPlaylist) {
		playlistIndex = 0;
		[self playMusicWithKey:[currentPlaylistTracks objectAtIndex:playlistIndex] timesToRepeat:0];
	}
}

- (void)stopMusic {
	[musicPlayer stop];
	isMusicPlaying = NO;
	usePlaylist = NO;
}

- (void)pauseMusic {
	[musicPlayer pause];
	isMusicPlaying = NO;
}

- (void)resumeMusic {
	[musicPlayer play];
	isMusicPlaying = YES;
}

- (void)setMusicVolume:(float)aVolume {
	
	if (aVolume > 1) {
		aVolume = 1.0f;
	}
	
	currentMusicVolume = aVolume;
	musicVolume = aVolume;
	
	if (musicPlayer) {
		[musicPlayer setVolume:currentMusicVolume];
	}
}

- (void)setFxVolume:(float)aVolume {
	fxVolume = aVolume;
}

- (void)setListenerPosition:(CGPoint)aPosition {
	listenerPosition = aPosition;
	alListener3f(AL_POSITION, aPosition.x, aPosition.y, 0.0f);
}

- (void)setOrientation:(CGPoint)aOrientation {
	float orientation[] = {aOrientation.x, aOrientation.y, 0.0f, 0.0f, 0.0f, 1.0f};
	alListenerfv(AL_ORIENTATION, orientation);
}

- (void)fadeMusicVolumeFrom:(float)aFromVolume toVolume:(float)aToVolume duration:(float)aSeconds stop:(BOOL)aStop {
	
	if (timer) {
		[timer invalidate];
		timer = NULL;
	}
	
	fadeAmount = (aToVolume - aFromVolume) / (aSeconds / kFadeInterval);
	currentMusicVolume = aFromVolume;
	
	fadeDuration = 0;
	targetFadeDuration = aSeconds;
	isFading = YES;
	stopMusicAfterFade = aStop;
	
	timer = [NSTimer scheduledTimerWithTimeInterval:kFadeInterval target:self selector:@selector(fadeVolume:) userInfo:nil repeats:TRUE];
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
	
	if (!flag) {
		//NSLog(@"Music finished due to error");
		return;
	}
	
	isMusicPlaying = NO;
	
	if (usePlaylist) {
		[self playNextTrack];
	}
}

- (void)beginInterruption {
	[self setActivated:NO];
}

- (void)endInterruption {
	[self setActivated:YES];
}

@end

@implementation SoundManager (Private)

- (BOOL)initOpenAL {
	
	uint maxOpenALSources = 16;
	
	device = alcOpenDevice(NULL);
	
	if (device) {
		context = alcCreateContext(device, NULL);
		
		alcMakeContextCurrent(context);
		
		alDistanceModel(AL_LINEAR_DISTANCE_CLAMPED);
		
		NSUInteger sourceID;
		for (int index = 0; index < maxOpenALSources; index++) {
			alGenSources(1, &sourceID);
			
			alSourcef(sourceID, AL_REFERENCE_DISTANCE, 25.0f);
			alSourcef(sourceID, AL_MAX_DISTANCE, 150.0f);
			alSourcef(sourceID, AL_ROLLOFF_FACTOR, 6.0f);
			
			[soundSources addObject:[NSNumber numberWithUnsignedInt:sourceID]];
		}
		
		float listener_pos[] = {0, 0, 0};
		float listener_ori[] = {0.0, 1.0, 0.0, 0.0, 0.0, 1.0};
		float listener_vel[] = {0, 0, 0};
		alListenerfv(AL_POSITION, listener_pos);
		alListenerfv(AL_ORIENTATION, listener_ori);
		alListenerfv(AL_VELOCITY, listener_vel);
		
		return YES;
	}
	
	//NSLog(@"ERROR - SoundManager: Unable to allocate device for sound");
	return NO;
}

- (NSUInteger)nextAvailableSource {
	
	NSInteger sourceState;
	
	for (NSNumber *sourceNumber in soundSources) {
		alGetSourcei([sourceNumber unsignedIntValue], AL_SOURCE_STATE, &sourceState);
		
		if (sourceState != AL_PLAYING) {
			return [sourceNumber unsignedIntValue];
		}
	}
	
	return 0;
}

- (void)setActivated:(BOOL)aState {
	
	OSStatus result;
	
	if (aState) {
		[audioSession setCategory:soundCategory error:&audioSessionError];
		
		if (audioSessionError) {
			//NSLog(@"ERROR - SoundManager: Unable to set the audio session category");
			return;
		}
		
		[audioSession setActive:YES error:&audioSessionError];
		if (audioSessionError) {
			//NSLog(@"ERROR - SoundManager: unable to make active with error %d.", result);
			return;
		}
		
		if (musicPlayer) {
			[musicPlayer play];
		}
		
		alcMakeContextCurrent(context);
	} else {
		alcMakeContextCurrent(NULL);
	}
}

- (BOOL)isExternalAudioPlaying {
	UInt32 audioPlaying = 0;
	UInt32 audioPlayingSize = sizeof(audioPlaying);
	AudioSessionGetProperty(kAudioSessionProperty_OtherAudioIsPlaying, &audioPlayingSize, &audioPlaying);
	return (BOOL)audioPlaying;
}

- (void)fadeVolume:(NSTimer *)aTimer {
	fadeDuration += kFadeInterval;
	if (fadeDuration >= targetFadeDuration) {
		if (timer) {
			[timer invalidate];
			timer = NULL;
		}
		
		isFading = NO;
		if (stopMusicAfterFade) {
			[musicPlayer stop];
			isMusicPlaying = NO;
		}
	} else {
		currentMusicVolume += fadeAmount;
	}
	
	if (isMusicPlaying) {
		[musicPlayer setVolume:currentMusicVolume];
	}
}

- (void)checkForErrors {
	alError = alGetError();
	if (alError != AL_NO_ERROR) {
		//NSLog(@"ERROR - SoundManager: OpenAL reported error '%d'", alError);
	}
}


@end


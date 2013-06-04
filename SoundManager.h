//
//  SoundManager.h
//  TEORBattleTest
//
//  Created by Zach Babb on 5/21/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <OpenAL/al.h>
#import <OpenAL/alc.h>
#import <AVFoundation/AVFoundation.h>

#define kFadeInterval (1.0f / 60.0)

@interface SoundManager : NSObject <AVAudioPlayerDelegate, AVAudioSessionDelegate> {
	
	ALCcontext *context;
	ALCdevice *device;
	ALenum alError;
	CGPoint listenerPosition;
	NSString *soundCategory;
	NSMutableArray *soundSources;
	AVAudioSession *audioSession;
	NSError *audioSessionError;
	
	NSMutableDictionary *soundLibrary;
	NSMutableDictionary *musicLibrary;
	NSMutableDictionary *musicPlaylists;
	NSMutableArray *currentPlaylistTracks;
	
	AVAudioPlayer *musicPlayer;
	
	float currentMusicVolume;
	float fxVolume;
	float musicVolume;
	
	NSTimer *timer;
	float fadeAmount;
	float fadeDuration;
	float targetFadeDuration;
	
	BOOL isExternalAudioPlaying;
	BOOL isFading;
	BOOL isMusicPlaying;
	BOOL stopMusicAfterFade;
	BOOL usePlaylist;
	BOOL loopPlaylist;
	BOOL loopLastPlaylistTrack;
	
	int playlistIndex;
	NSString *currentPlaylistName;
	
}

@property (nonatomic, assign) float currentMusicVolume;
@property (nonatomic, assign) float fxVolume;
@property (nonatomic, assign) BOOL isExternalAudioPlaying;
@property (nonatomic, assign) BOOL isMusicPlaying;
@property (nonatomic, assign) BOOL usePlaylist;
@property (nonatomic, assign) BOOL loopLastPlaylistTrack;
@property (nonatomic, assign) float musicVolume;

+ (SoundManager *)sharedSoundManager;

- (NSUInteger)playSoundWithKey:(NSString *)aSoundKey;

- (NSUInteger)playSoundWithKey:(NSString *)aSoundKey location:(CGPoint)aLocation;

- (NSUInteger)playSoundWithKey:(NSString *)aSoundKey gain:(float)aGain pitch:(float)aPitch
					  location:(CGPoint)aLocation shouldLoop:(BOOL)aLoop;

- (void)stopSoundWithKey:(NSString *)aSoundKey;

- (void)loadSoundWithKey:(NSString *)aSoundKey soundFile:(NSString *)aMusicFile;

- (void)removeSoundWithKey:(NSString *)aSoundKey;

- (void)playMusicWithKey:(NSString *)aMusicKey timesToRepeat:(NSUInteger)aRepeatCount;

- (void)playNextTrack;

- (void)loadMusicWithKey:(NSString *)aMusicKey musicFile:(NSString *)aMusicFile;

- (void)removeMusicWithKey:(NSString *)aMusicKey;

- (void)addToPlaylistNamed:(NSString *)aPlaylistName track:(NSString *)aTrackName;

- (void)startPlaylistNamed:(NSString *)aPlaylistName;

- (void)removeFromPlaylistNamed:(NSString *)aPlaylistName track:(NSString *)aTrackName;

- (void)removePlaylistNamed:(NSString *)aPlaylistName;

- (void)clearPlaylistNamed:(NSString *)aPlaylistName;

- (void)stopMusic;

- (void)pauseMusic;

- (void)resumeMusic;

- (void)fadeMusicVolumeFrom:(float)aFromVolume toVolume:(float)aToVolume duration:(float)aSeconds stop:(BOOL)aStop;

- (void)shutdownSoundManager;

- (void)setMusicVolume:(float)aVolume;

- (void)setListenerPosition:(CGPoint)aPosition;

- (void)setOrientation:(CGPoint)aOrientation;

- (void)setFxVolume:(float)aVolume;

@end

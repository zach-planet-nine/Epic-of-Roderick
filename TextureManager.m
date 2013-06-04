//
//  TextureManager.m
//  TEORBattleTest
//
//  Created by Zach Babb on 5/21/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "TextureManager.h"
#import "SynthesizeSingleton.h"
#import "Texture2D.h"


@implementation TextureManager

SYNTHESIZE_SINGLETON_FOR_CLASS(TextureManager);

- (void)dealloc {
	
	[cachedTextures release];
	[super dealloc];
}

- (id)init {
	if (self = [super init]) {
		cachedTextures = [[NSMutableDictionary alloc] init];
	}
	return self;
}

- (Texture2D *)textureWithFileName:(NSString *)aName filter:(GLenum)aFilter {
	
	Texture2D *cachedTexture;
    cachedTexture = [cachedTextures objectForKey:aName];
	
	if (cachedTexture) {
		return cachedTexture;
	}
	
	
	NSString *filename = [aName stringByDeletingPathExtension];
	NSString *filetype = [aName pathExtension];
	NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:filetype];
	cachedTexture = [[Texture2D alloc] initWithImage:[UIImage imageWithContentsOfFile:path] filter:aFilter];
	[cachedTextures setObject:cachedTexture forKey:aName];
	
	return [cachedTexture autorelease];
}


- (BOOL)releaseTextureWithName:(NSString *)aName {
	
	if ([cachedTextures objectForKey:aName]) {
		[cachedTextures removeObjectForKey:aName];
		return YES;
	}
	return NO;
}


- (void)releaseAllTextures {
	[cachedTextures removeAllObjects];
}

@end

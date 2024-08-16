//
//  TextureManager.h
//  TEORBattleTest
//
//  Created by Zach Babb on 5/21/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Structures.h"

@class Texture2D;


@interface TextureManager : NSObject {
	NSMutableDictionary *cachedTextures;
}

+ (TextureManager *)sharedTextureManager;

- (Texture2D *)textureWithFileName:(NSString *)aName filter:(GLenum)aFilter;

- (BOOL)releaseTextureWithName:(NSString *)aName;

- (void)releaseAllTextures;

@end

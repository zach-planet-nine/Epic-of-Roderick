//
//  PackedSpriteSheet.h
//  TEORBattleTest
//
//  Created by Zach Babb on 5/21/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Global.h"

@class Image;

@interface PackedSpriteSheet : NSObject {
	
	Image *image;
	NSMutableDictionary *sprites;
	NSDictionary *controlFile;
}

+ (PackedSpriteSheet *)packedSpriteSheetForImageNamed:(NSString *)aImageName controlFile:(NSString *)aControlFile imageFilter:(GLenum)aFilter;

+ (BOOL)removeCachedPackedSpriteSheetWithKey:(NSString *)aKey;

- (id)initWithImageNamed:(NSString *)aImageFileName controlFile:(NSString *)aControlFile filter:(GLenum)aFilter;

- (Image *)imageForKey:(NSString *)aKey;

@end

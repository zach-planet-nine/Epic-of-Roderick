//
//  SpriteSheet.h
//  TEORBattleTest
//
//  Created by Zach Babb on 5/21/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Global.h"
#import "Image.h"

@class TextureManager;
@class Image;


@interface SpriteSheet : NSObject {
	
	Image *image;
	CGSize spriteSize;
	NSUInteger spacing;
	NSUInteger margin;
	NSUInteger horizSpriteCount;
	NSUInteger vertSpriteCount;
	NSMutableArray *cachedSprites;
	
}

@property (nonatomic, assign, readonly) CGSize spriteSize;
@property (nonatomic, assign, readonly) NSUInteger spacing;
@property (nonatomic, assign, readonly) NSUInteger margin;
@property (nonatomic, assign, readonly) NSUInteger horizSpriteCount;
@property (nonatomic, assign, readonly) NSUInteger vertSpriteCount;
@property (nonatomic, retain) Image *image;

+ (SpriteSheet *)spriteSheetForImageNamed:(NSString *)aImageName spriteSize:(CGSize)aSpriteSize spacing:(NSUInteger)aSpacing
								   margin:(NSUInteger)aMargin imageFilter:(GLenum)aFilter;

+ (SpriteSheet *)spriteSheetForImage:(Image *)aImage sheetKey:(NSString *)aSheetKey spriteSize:(CGSize)aSpriteSize
							 spacing:(NSUInteger)aSpacing margin:(NSUInteger)aMargin;

+ (BOOL)removeCachedSpriteSheetWithKey:(NSString *)aKey;

- (id)initWithImageNamed:(NSString *)aImageFileName spriteSize:(CGSize)aSpriteSize spacing:(NSUInteger)aSpacing margin:(NSUInteger)aMargin imageFilter:(GLenum)aFilter;

- (id)initWithImage:(Image *)aImage spriteSize:(CGSize)aSpriteSize spacing:(NSUInteger)aSpacing margin:(NSUInteger)aMargin;

- (Image *)spriteImageAtCoords:(CGPoint)aPoint;

@end

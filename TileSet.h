//
//  TileSet.h
//  TEORBattleTest
//
//  Created by Zach Babb on 5/21/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SpriteSheet;
@class TextureManager;


@interface TileSet : NSObject {
	
	TextureManager *sharedTextureManager;
	
	int tileSetID;
	NSString *name;
	int firstGID;
	int lastGID;
	int tileWidth;
	int tileHeight;
	int spacing;
	int margin;
	SpriteSheet *tiles;
	int horizontalTiles;
	int verticalTiles;
	
}

@property (nonatomic, readonly) int tileSetID;
@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) int firstGID;
@property (nonatomic, readonly) int lastGID;
@property (nonatomic, readonly) int tileWidth;
@property (nonatomic, readonly) int tileHeight;
@property (nonatomic, readonly) int spacing;
@property (nonatomic, readonly) int margin;
@property (nonatomic, readonly) SpriteSheet *tiles;

- (id)initWithImageNamed:(NSString *)aImageFileName name:(NSString *)aTileSetName tileSetID:(int)aTileSetID
				firstGID:(int)aFirstGlobalID tileSize:(CGSize)aTileSize spacing:(int)aSpacing margin:(int)aMargin;

- (BOOL)containsGlobalID:(int)aGlobalID;

- (int)getTileY:(int)aTileID;

- (int)getTileX:(int)aTileID;

@end

//
//  TileSet.m
//  TEORBattleTest
//
//  Created by Zach Babb on 5/21/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "TileSet.h"
#import "SpriteSheet.h"
#import "TextureManager.h"


@implementation TileSet

@synthesize tileSetID;
@synthesize name;
@synthesize firstGID;
@synthesize lastGID;
@synthesize tileWidth;
@synthesize tileHeight;
@synthesize spacing;
@synthesize margin;
@synthesize tiles;

- (void)dealloc {
	if (tiles) {
		[tiles release];
	}
	[super dealloc];
}

- (id)initWithImageNamed:(NSString *)aImageFileName name:(NSString *)aTileSetName tileSetID:(int)aTileSetID
				firstGID:(int)aFirstGlobalID tileSize:(CGSize)aTileSize spacing:(int)aSpacing margin:(int)aMargin {
	
	self = [super init];
	if (self != nil) {
		
		sharedTextureManager = [TextureManager sharedTextureManager];
		
		tiles = [[SpriteSheet spriteSheetForImageNamed:aImageFileName spriteSize:aTileSize spacing:aSpacing margin:aMargin imageFilter:GL_NEAREST] retain];
		
		tileSetID = aTileSetID;
		name = aTileSetName;
		firstGID = aFirstGlobalID;
		tileWidth = aTileSize.width;
		tileHeight = aTileSize.height;
		spacing = aSpacing;
		margin = aMargin;
		
		horizontalTiles = tiles.horizSpriteCount;
		verticalTiles = tiles.vertSpriteCount;
		
		lastGID = horizontalTiles * verticalTiles + firstGID - 1;
	}
	
	return self;
}

- (BOOL)containsGlobalID:(int)aGlobalID {
	
	return (aGlobalID >= firstGID) && (aGlobalID <= lastGID);
}

- (int)getTileX:(int)aTileID {
	return aTileID % horizontalTiles;
}

- (int)getTileY:(int)aTileID {
	return aTileID / horizontalTiles;
}

@end

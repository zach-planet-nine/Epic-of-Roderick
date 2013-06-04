//
//  TiledMap.h
//  TEORBattleTest
//
//  Created by Zach Babb on 5/21/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Global.h"
#import "Layer.h"

@class SpriteSheet;
@class TileSet;
@class GameController;
@class ImageRenderManager;

#define kMax_Map_Layers 5


@interface TiledMap : NSObject {
	
	GameController *sharedGameController;
	ImageRenderManager *sharedImageRenderManager;
	
	uint mapWidth;
	uint mapHeight;
	uint tileWidth;
	uint tileHeight;
	uint currentTileSetID;
	TileSet *currentTileSet;
	uint currentLayerID;
	Layer *currentLayer;
	Color4f colorFilter;
	NSMutableArray *tileSets;
	NSMutableArray *layers;
	NSMutableDictionary *mapProperties;
	NSMutableDictionary *tileSetProperties;
	NSMutableDictionary *objectGroups;
	
	TexturedColoredQuad nullTCQ;
	
	NSString *tileSetName;
	int tileSetID;
	int tileSetWidth;
	int tileSetHeight;
	int tileSetFirstGID;
	int tileSetSpacing;
	int tileSetMargin;
	
	NSString *layerName;
	int layerID;
	int layerWidth;
	int layerHeight;
	int tile_x;
	int tile_y;
	
}

@property (nonatomic, readonly) NSMutableArray *tileSets;
@property (nonatomic, readonly) NSMutableArray *layers;
@property (nonatomic, readonly) NSMutableDictionary *objectGroups;
@property (nonatomic, readonly) GLuint mapWidth;
@property (nonatomic, readonly) GLuint mapHeight;
@property (nonatomic, readonly) GLuint tileWidth;
@property (nonatomic, readonly) GLuint tileHeight;
@property (nonatomic, assign) Color4f colorFilter;

- (id)initWithFileName:(NSString *)aTiledFile fileExtension:(NSString *)aFileExtension;

- (void)renderLayer:(int)aLayerIndex mapx:(int)aMapx mapy:(int)aMapy width:(int)aWidth
			 height:(int)aHeight useBlending:(BOOL)aUseBlending;

- (TileSet *)tileSetWithGlobalID:(int)aGlobalID;

- (int)layerIndexWithName:(NSString *)aLayerName;

- (NSString *)mapPropertyForKey:(NSString *)aKey defaultValue:(NSString *)aDefaultValue;

- (NSString *)layerPropertyForKey:(NSString *)aKey layerID:(int)aLayerID defaultValue:(NSString *)aDefaultValue;

- (NSString *)tilePropertyForGlobalTileID:(int)aGlobalTileID key:(NSString *)aKey defaultValue:(NSString *)aDefaultValue;

@end

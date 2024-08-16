//
//  Layer.h
//  TEORBattleTest
//
//  Created by Zach Babb on 5/21/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Global.h"

#define MAX_MAP_WIDTH 200
#define MAX_MAP_HEIGHT 200

@class Image;


@interface Layer : NSObject {
	
	int layerID;
	NSString *layerName;
	int layerData[MAX_MAP_WIDTH][MAX_MAP_HEIGHT][4];
	int layerWidth;
	int layerHeight;
	NSMutableDictionary *layerProperties;
	TexturedColoredQuad *tileImages;
}

@property (nonatomic, readonly) int layerID;
@property (nonatomic, readonly) NSString *layerName;
@property (nonatomic, readonly) int layerWidth;
@property (nonatomic, readonly) int layerHeight;
@property (nonatomic, retain) NSMutableDictionary *layerProperties;

- (id)initWithName:(NSString *)aName layerID:(int)aLayerID layerWidth:(int)aLayerWidth layerHeight:(int)aLayerHeight;

- (void)addTileAt:(CGPoint)aTileCoord tileSetID:(int)aTileSetID tileID:(int)aTileID globalID:(int)aGlobalID value:(int)aValue;

- (int)tileSetIDAtTile:(CGPoint)aTileCoord;

- (int)globalTileIDAtTile:(CGPoint)aTileCoord;

- (int)tileIDAtTile:(CGPoint)aTileCoord;

- (void)setValueAtTile:(CGPoint)aTileCoord value:(int)aValue;

- (int)valueAtTile:(CGPoint)aTileCoord;

- (void)addTileImageAt:(CGPoint)aPoint imageDetails:(ImageDetails *)aImageDetails;

- (TexturedColoredQuad *)getTileImageAt:(CGPoint)aPoint;

@end

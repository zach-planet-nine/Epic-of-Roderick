//
//  TiledMap.m
//  TEORBattleTest
//
//  Created by Zach Babb on 5/21/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "TiledMap.h"
#import "Transform2D.h"
#import "TBXML.h"
#import "TileSet.h"
#import "SpriteSheet.h"
#import "GameController.h"
#import "ImageRenderManager.h"
#import "AbstractScene.h"
#import "NSDataAdditions.h"
#import "Texture2D.h"

@interface TiledMap (Private)

- (void)parseMapFileTBXML:(TBXML *)aTBXML;

- (void)createLayerTileImages;

- (void)parseMapObjects:(TBXML *)aTmxXML;

@end


@implementation TiledMap

@synthesize tileSets;
@synthesize layers;
@synthesize objectGroups;
@synthesize mapWidth;
@synthesize mapHeight;
@synthesize tileWidth;
@synthesize tileHeight;
@synthesize colorFilter;

- (void)dealloc {
	[objectGroups release];
	[mapProperties release];
	if (tileSetProperties) {
		[tileSetProperties release];
	}
	[tileSets release];
	[layers release];
	[super dealloc];
}

- (id)initWithFileName:(NSString *)aTiledFile fileExtension:(NSString *)aFileExtension {
	
	self = [super init];
	if (self != nil) {
		
		sharedGameController = [GameController sharedGameController];
		sharedImageRenderManager = [ImageRenderManager sharedImageRenderManager];
		
		tileSets = [[NSMutableArray alloc] init];
		layers = [[NSMutableArray alloc] init];
		mapProperties = [[NSMutableDictionary alloc] init];
		objectGroups = [[NSMutableDictionary alloc] init];
		
		TBXML *tmxXML = [[TBXML alloc] initWithXMLFile:aTiledFile fileExtension:aFileExtension];
		
		[self parseMapFileTBXML:tmxXML];
		[self parseMapObjects:tmxXML];
		
		[tmxXML release];
	}
	
	memset(&nullTCQ, 0, sizeof(TexturedColoredQuad));
	
	[self createLayerTileImages];
	
	colorFilter = Color4fOnes;
	
	return self;
}

- (void)renderLayer:(int)aLayerIndex mapx:(int)aMapx mapy:(int)aMapy
			  width:(int)aWidth height:(int)aHeight useBlending:(BOOL)aUseBlending {
	
	if (aMapx < 0) {
		aMapx = 0;
	}
	if (aMapx > mapWidth) {
		aMapx = mapWidth;
	}
	if (aMapy < 0) {
		aMapy = 0;
	}
	if (aMapy > mapHeight) {
		aMapy = mapHeight;
	}
    if (aMapx + aWidth > mapWidth) {
        aWidth = mapWidth - aMapx;
    }
    if (aMapy + aHeight > mapHeight) {
        aHeight = mapHeight - aMapy;
    }
	
	int maxWidth = aMapx + aWidth;
	int maxHeight = aMapy + aHeight;
	if (aLayerIndex >= [layers count]) {
        return;
    }
	Layer *layer = [layers objectAtIndex:aLayerIndex];
	
	TileSet *tileSet = [tileSets objectAtIndex:0];
	uint textureName = [tileSet tiles].image.texture.name;
	
	for (int y = aMapy; y < maxHeight; y++) {
		for (int x = aMapx; x < maxWidth; x++) {
            
			TexturedColoredQuad *tcq = [layer getTileImageAt:CGPointMake(x, y)];
			if (memcmp(tcq, &nullTCQ, sizeof(TexturedColoredQuad)) != 0) {
                [sharedImageRenderManager addTexturedColoredQuadToRenderQueue:tcq texture:textureName];
            }
                			
		}
	}
	if (!aUseBlending) {
		glDisable(GL_BLEND);
	}
	[sharedImageRenderManager renderImages];
	if (!aUseBlending) {
		glEnable(GL_BLEND);
	}
}

- (TileSet *)tileSetWithGlobalID:(int)aGlobalID {
	for (TileSet *tileSet in tileSets) {
		if ([tileSet containsGlobalID:aGlobalID]) {
			return tileSet;
		}
	}
	return nil;
}

- (int)layerIndexWithName:(NSString *)aLayerName {
	
	for (Layer *layer in layers) {
		if ([[layer layerName] isEqualToString:aLayerName]) {
			return [layer layerID];
		}
	}
	
	return -1;
}

- (NSString *)mapPropertyForKey:(NSString *)aKey defaultValue:(NSString *)aDefaultValue {
	NSString *value = [mapProperties valueForKey:aKey];
	if (!value) {
		return aDefaultValue;
	}
	return value;
}

- (NSString *)layerPropertyForKey:(NSString *)aKey layerID:(int)aLayerID defaultValue:(NSString *)aDefaultValue {
	if (aLayerID < 0 || aLayerID > [layers count] - 1) {
		return nil;
	}
	NSString *value = [[[layers objectAtIndex:aLayerID] layerProperties] valueForKey:aKey];
	if (!value) {
		return aDefaultValue;
	}
	return value;
}

- (NSString *)tilePropertyForGlobalTileID:(int)aGlobalTileID key:(NSString *)aKey defaultValue:(NSString *)aDefaultValue {
	NSString *value = [[tileSetProperties valueForKey:[NSString stringWithFormat:@"%d", aGlobalTileID]] valueForKey:aKey];
	if (!value) {
		return aDefaultValue;
	}
	return value;
}

@end

@implementation TiledMap (Private)

- (void)createLayerTileImages {
	
	int x = 0;
	int y = 0;
	
	TileSet *tileSet = [tileSets objectAtIndex:0];
	
	for (int layerIndex = 0; layerIndex < [layers count]; layerIndex++) {
		
		Layer *layer = [layers objectAtIndex:layerIndex];
		
		if ([self layerPropertyForKey:@"visible" layerID:layerIndex defaultValue:@"0"]) {
			for (int mapTileY = 0; mapTileY < mapHeight; mapTileY++) {
				for (int mapTileX = 0; mapTileX < mapWidth; mapTileX++) {
					
					int tileID = [layer tileIDAtTile:CGPointMake(mapTileX, mapTileY)];
					
					if (tileID > -1) {
						SpriteSheet *tileSprites = [tileSet tiles];
						Image *tileImage = [tileSprites spriteImageAtCoords:CGPointMake([tileSet getTileX:tileID], [tileSet getTileY:tileID])];
						
						[layer addTileImageAt:CGPointMake(mapTileX, mapTileY) imageDetails:tileImage.imageDetails];
					}
					x += tileWidth;
				}
				y += tileHeight;
				x = 0;
			}
			y = 0;
		}
	}
}

- (void)parseMapFileTBXML:(TBXML *)aTBXML {
	
	currentLayerID = 0;
	currentTileSetID = 0;
	tile_x = 0;
	tile_y = 0;
	
	TBXMLElement * rootXMLElement = aTBXML.rootXMLElement;
	
	if (rootXMLElement) {
		
		mapWidth = [[TBXML valueOfAttributeNamed:@"width" forElement:rootXMLElement] intValue];
		mapHeight = [[TBXML valueOfAttributeNamed:@"height" forElement:rootXMLElement] intValue];
		tileWidth = [[TBXML valueOfAttributeNamed:@"tilewidth" forElement:rootXMLElement] intValue];
		tileHeight = [[TBXML valueOfAttributeNamed:@"tileheight" forElement:rootXMLElement] intValue];
		
		TBXMLElement * properties = [TBXML childElementNamed:@"properties" parentElement:rootXMLElement];
		if (properties) {
			TBXMLElement * property = [TBXML childElementNamed:@"property" parentElement:properties];
			
			while (property) {
				NSString *name = [TBXML valueOfAttributeNamed:@"name" forElement:property];
				NSString *value = [TBXML valueOfAttributeNamed:@"value" forElement:property];
				[mapProperties setObject:value forKey:name];
				
				property = property->nextSibling;
			}
		}
		
		tileSetProperties = [[NSMutableDictionary alloc] init];
		
		TBXMLElement * tileset = [TBXML childElementNamed:@"tileset" parentElement:rootXMLElement];
		while (tileset) {
			tileSetName =[TBXML valueOfAttributeNamed:@"name" forElement:tileset];
			tileSetWidth = [[TBXML valueOfAttributeNamed:@"tilewidth" forElement:tileset] intValue];
			tileSetHeight = [[TBXML valueOfAttributeNamed:@"tileheight" forElement:tileset] intValue];
			tileSetFirstGID = [[TBXML valueOfAttributeNamed:@"firstgid" forElement:tileset] intValue];
			tileSetSpacing = [[TBXML valueOfAttributeNamed:@"spacing" forElement:tileset] intValue];
			tileSetMargin = [[TBXML valueOfAttributeNamed:@"margin" forElement:tileset] intValue];
			
			//NSLog(@"INFO - Tiled: --> TILESET found named: %@, width=%d, height=%d, firstgid=%d, spacing=%d, id=%d", 
				  //tileSetName, tileSetWidth, tileSetHeight, tileSetFirstGID, tileSetSpacing, currentTileSetID);
			
			TBXMLElement * image = [TBXML childElementNamed:@"image" parentElement:tileset];
			NSString *source = [TBXML valueOfAttributeNamed:@"source" forElement:image];
			//NSLog(@"INFO - Tiled: ----> Found source for tileset called '%@'.", source);
			
			TBXMLElement * tile = [TBXML childElementNamed:@"tile" parentElement:tileset];
			while (tile) {
				int tileID = [[TBXML valueOfAttributeNamed:@"id" forElement:tile] intValue];
				
				NSMutableDictionary *tileProperties = [[NSMutableDictionary alloc] init];
				
				TBXMLElement * tstp = [TBXML childElementNamed:@"properties" parentElement:tile];
				TBXMLElement * tstp_property = [TBXML childElementNamed:@"property" parentElement:tstp];
				while (tstp_property) {
					[tileProperties setObject:[TBXML valueOfAttributeNamed:@"value" forElement:tstp_property]
									   forKey:[TBXML valueOfAttributeNamed:@"name" forElement:tstp_property]];
					
					tstp_property = [TBXML nextSiblingNamed:@"property" searchFromElement:tstp_property];
				}
				
				[tileSetProperties setObject:tileProperties forKey:[NSString stringWithFormat:@"%d", tileID]];
				
				[tileProperties release];
				tileProperties = nil;
				
				tile = [TBXML nextSiblingNamed:@"tile" searchFromElement:tile];
			}
			
			currentTileSet = [[TileSet alloc] initWithImageNamed:source
															name:tileSetName
													   tileSetID:currentTileSetID
														firstGID:tileSetFirstGID
														tileSize:CGSizeMake(tileWidth, tileHeight)
														 spacing:tileSetSpacing
														  margin:tileSetMargin];
			
			[tileSets addObject:currentTileSet];
			
			[currentTileSet release];
			
			currentTileSetID++;
			
			tileset = [TBXML nextSiblingNamed:@"tileset" searchFromElement:tileset];
		}
		
		TBXMLElement * layer = [TBXML childElementNamed:@"layer" parentElement:rootXMLElement];
		while (layer) {
			layerName = [TBXML valueOfAttributeNamed:@"name" forElement:layer];
			layerWidth = [[TBXML valueOfAttributeNamed:@"width" forElement:layer] intValue];
			layerHeight = [[TBXML valueOfAttributeNamed:@"height" forElement:layer] intValue];
			
			currentLayer = [[Layer alloc] initWithName:layerName layerID:currentLayerID layerWidth:layerWidth layerHeight:layerHeight];
			
			TBXMLElement * layerProperties = [TBXML childElementNamed:@"properties" parentElement:layer];
			if (layerProperties) {
				TBXMLElement *layerProperty = [TBXML childElementNamed:@"property" parentElement:layerProperties];
				NSMutableDictionary *layerProps = [[NSMutableDictionary alloc] init];
				
				while (layerProperty) {
					NSString *name = [TBXML valueOfAttributeNamed:@"name" forElement:layerProperty];
					NSString *value = [TBXML valueOfAttributeNamed:@"value" forElement:layerProperty];
					[layerProps setObject:value forKey:name];
					layerProperty = layerProperty->nextSibling;
				}
				[currentLayer setLayerProperties:layerProps];
				[layerProps release];
			}
			
			TBXMLElement * dataElement = [TBXML childElementNamed:@"data" parentElement:layer];
			
			if (dataElement) {
				if ([[TBXML valueOfAttributeNamed:@"encoding" forElement:dataElement] isEqualToString:@"base64"]) {
					
					NSData *deflatedData = [NSData dataWithBase64EncodedString:[TBXML textForElement:dataElement]];
					if ([[TBXML valueOfAttributeNamed:@"compression" forElement:dataElement] isEqualToString:@"gzip"]) {
						deflatedData = [deflatedData gzipInflate];
					}
					long size = sizeof(int) * (layerWidth * layerHeight);
					int *bytes = malloc(size);
					[deflatedData getBytes:bytes length:size];
					
					long y;
					for (tile_y = 0, y = 0; y < layerHeight * layerWidth; y += layerWidth, tile_y++) {
						for (tile_x = 0; tile_x < layerWidth; tile_x++) {
							int globalID = bytes[y + tile_x];
							if (globalID == 0) {
								[currentLayer addTileAt:CGPointMake(tile_x, (layerHeight - 1) - tile_y) 
											  tileSetID:-1 tileID:-1 globalID:-1 value:-1];
							} else {
								TileSet *tileSet = [self tileSetWithGlobalID:globalID];
								[currentLayer addTileAt:CGPointMake(tile_x, (layerHeight - 1) - tile_y) 
											  tileSetID:[tileSet tileSetID] 
												 tileID:globalID - [tileSet firstGID] 
											   globalID:globalID 
												  value:-1];
							}
						}
					}
				} else {
					tile_x = 0;
					tile_y = 0;
					
					TBXMLElement * tileElements = [TBXML childElementNamed:@"tile" parentElement:dataElement];
					
					while (tileElements) {
						int globalID = [[TBXML valueOfAttributeNamed:@"gid" forElement:tileElements] intValue];
						
						if (globalID == 0) {
							[currentLayer addTileAt:CGPointMake(tile_x, (layerHeight - 1) - tile_y) 
										  tileSetID:-1 tileID:-1 globalID:-1 value:-1];
						} else {
							TileSet *tileSet = [self tileSetWithGlobalID:globalID];
							[currentLayer addTileAt:CGPointMake(tile_x, (layerHeight - 1) - tile_y) 
										  tileSetID:[tileSet tileSetID] 
											 tileID:globalID - [tileSet firstGID] 
										   globalID:globalID 
											  value:-1];
						}
						
						tile_x++;
						if (tile_x > layerWidth - 1) {
							tile_x = 0;
							tile_y++;
						}
						
						tileElements = tileElements->nextSibling;
					}
				}
			}
			
			[layers addObject:currentLayer];
			[currentLayer release];
			currentLayerID++;
			
			layer = [TBXML nextSiblingNamed:@"layer" searchFromElement:layer];
		}
	}
}

- (void)parseMapObjects:(TBXML *)aTmxXML {
	
	TBXMLElement * rootXMLElement = aTmxXML.rootXMLElement;
	
	TBXMLElement * objectGroup = [TBXML childElementNamed:@"objectgroup" parentElement:rootXMLElement];
	
	while (objectGroup) {
		NSMutableDictionary *objectGroupDetails = [[NSMutableDictionary alloc] init];
		NSMutableDictionary *objectGroupAttribs = [[NSMutableDictionary alloc] init];
		NSMutableDictionary *objectGroupObjects = [[NSMutableDictionary alloc] init];
		
		NSString *objectGroupName = [TBXML valueOfAttributeNamed:@"name" forElement:objectGroup];
		NSString *objectGroupWidth = [TBXML valueOfAttributeNamed:@"width" forElement:objectGroup];
		NSString *objectGroupHeight = [TBXML valueOfAttributeNamed:@"height" forElement:objectGroup];
		[objectGroupAttribs setObject:objectGroupName forKey:@"name"];
		[objectGroupAttribs setObject:objectGroupWidth forKey:@"width"];
		[objectGroupAttribs setObject:objectGroupHeight forKey:@"height"];
		[objectGroupDetails setObject:objectGroupAttribs forKey:@"Attributes"];
		
		TBXMLElement * object = [TBXML childElementNamed:@"object" parentElement:objectGroup];
		
		while (object) {
			NSMutableDictionary *objectDetails = [[NSMutableDictionary alloc] init];
			NSMutableDictionary *objectAttribs = [[NSMutableDictionary alloc] init];
			NSMutableDictionary *objectProperties = [[NSMutableDictionary alloc] init];
			
			NSString *objectName = [TBXML valueOfAttributeNamed:@"name" forElement:object];
			NSString *objectType = [TBXML valueOfAttributeNamed:@"type" forElement:object];
			NSString *objectX = [TBXML valueOfAttributeNamed:@"x" forElement:object];
			NSString *objectY = [TBXML valueOfAttributeNamed:@"y" forElement:object];
			NSString *objectWidth = [TBXML valueOfAttributeNamed:@"width" forElement:object];
			NSString *objectHeight = [TBXML valueOfAttributeNamed:@"height" forElement:object];
			[objectAttribs setObject:objectName forKey:@"name"];
			if (objectType) {
				[objectAttribs setObject:objectType forKey:@"type"];
			}
			[objectAttribs setObject:objectX forKey:@"x"];
			[objectAttribs setObject:objectY forKey:@"y"];
			if (objectWidth) {
				[objectAttribs setObject:objectWidth forKey:@"width"];
			}
			if (objectHeight) {
				[objectAttribs setObject:objectHeight forKey:@"height"];
			}
			[objectDetails setObject:objectAttribs forKey:@"Attributes"];
			[objectAttribs release];
			
			TBXMLElement * properties = [TBXML childElementNamed:@"properties"
												   parentElement:object];
			
			if (properties) {
				TBXMLElement * property = [TBXML childElementNamed:@"property" parentElement:properties];
				
				while (property) {
					NSString *objectPropertyName = [TBXML valueOfAttributeNamed:@"name" forElement:property];
					NSString *objectPropertyValue = [TBXML valueOfAttributeNamed:@"value" forElement:property];
					[objectProperties setObject:objectPropertyValue forKey:objectPropertyName];
					
					property = [TBXML nextSiblingNamed:@"property" searchFromElement:property];
				}
				[objectDetails setObject:objectProperties forKey:@"Properties"];
			}
			
			[objectGroupObjects setObject:objectDetails forKey:objectName];
			[objectProperties release];
			[objectDetails release];
			
			object = object->nextSibling;
		}
		
		[objectGroupDetails setObject:objectGroupObjects forKey:@"Objects"];
		
		[objectGroups setObject:objectGroupDetails forKey:objectGroupName];
		[objectGroupAttribs release];
		[objectGroupDetails release];
		[objectGroupObjects release];
		
		objectGroup = [TBXML nextSiblingNamed:@"objectgroup" searchFromElement:objectGroup];
	}
}

@end


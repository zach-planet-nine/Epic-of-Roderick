//
//  Teleportal.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/26/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "AbstractGameObject.h"

@interface Teleportal : AbstractGameObject {
    
    CGPoint tile;
}

+ (void)teleportalToTile:(CGPoint)aTile;

- (id)initTeleportalToTile:(CGPoint)aTile;

@end

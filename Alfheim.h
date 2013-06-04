//
//  Alfheim.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/25/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "AbstractScene.h"

@interface Alfheim : AbstractScene {
    
    BOOL blocked[100][100];
    CGPoint portals[100][100];
    CGPoint portalDestination[7];
}

- (void)initSwampBoss;

- (void)initMountainBoss;

- (void)initCaveBoss;

- (void)initGiantCaveBoss;

@end

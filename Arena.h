//
//  Arena.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/17/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractScene.h"

@interface Arena : AbstractScene {
    int level;
    int realm;
}

- (void)initCaveBoss;

- (void)initTrainingDummyBattle;

@end

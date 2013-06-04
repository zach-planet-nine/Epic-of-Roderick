//
//  HolgethAllEnemies.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/27/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"

@class ParticleEmitter;

@interface HolgethAllEnemies : AbstractBattleAnimation {
    
    int cutIndex;
    int maxBleeders;
    int bleeders[30];
    NSMutableArray *enemies;
    ParticleEmitter *bladeEmitter;
}

@end

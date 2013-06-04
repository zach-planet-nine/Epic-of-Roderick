//
//  HagalazAllEnemies.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/24/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"

@class ParticleEmitter;
@class FadeInOrOut;

@interface HagalazAllEnemies : AbstractBattleAnimation {
    
    ParticleEmitter *hailEmitter;
    NSMutableArray *statEmitters;
    FadeInOrOut *dimWorld;
    float hagalazDurations[4];
    CGPoint mods[4];
}

@end

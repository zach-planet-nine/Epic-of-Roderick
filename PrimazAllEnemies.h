//
//  PrimazAllEnemies.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/26/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"

@class ParticleEmitter;
@class FadeInOrOut;

@interface PrimazAllEnemies : AbstractBattleAnimation {
    
    ParticleEmitter *rageExplosion;
    FadeInOrOut *dimWorld;
    int damages[4];
    int affinities[4];
    int enemyIndex;
    
}

@end

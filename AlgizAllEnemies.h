//
//  AlgizAllEnemies.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/7/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "AbstractBattleAnimation.h"
#import "Global.h"

@class ParticleEmitter;

@interface AlgizAllEnemies : AbstractBattleAnimation {
    
    ParticleEmitter *essenceEmitter;
    Vector2f emitterPoints[4];
    float algizDurations[4];
}

@end

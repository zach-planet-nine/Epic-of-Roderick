//
//  AlgizSingleEnemy.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/7/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"

@class ParticleEmitter;

@interface AlgizSingleEnemy : AbstractBattleAnimation {
    
    ParticleEmitter *essenceEmitter;
    float algizDuration;
}

@end

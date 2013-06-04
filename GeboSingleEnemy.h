//
//  GeboSingleEnemy.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/8/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "AbstractBattleAnimation.h"

@class ParticleEmitter;

@interface GeboSingleEnemy : AbstractBattleAnimation {
    
    ParticleEmitter *bloodEmitter;
    ParticleEmitter *essenceEmitter;
    float geboDuration;
}

@end

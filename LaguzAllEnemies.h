//
//  LaguzAllEnemies.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/7/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "AbstractBattleAnimation.h"

@class ParticleEmitter;

@interface LaguzAllEnemies : AbstractBattleAnimation {
    
    ParticleEmitter *snakeEmitter;
    int damages[4];
}

@end

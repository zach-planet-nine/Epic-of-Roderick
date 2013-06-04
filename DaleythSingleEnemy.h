//
//  DaleythSingleEnemy.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/29/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"

@class ParticleEmitter;

@interface DaleythSingleEnemy : AbstractBattleAnimation {
    
    ParticleEmitter *appearingEmitter;
    int damage;
    int emitterDirection;
}

@end

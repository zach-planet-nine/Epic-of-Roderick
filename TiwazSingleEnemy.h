//
//  TiwazSingleEnemy.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/28/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"
#import "Global.h"

@class ParticleEmitter;

@interface TiwazSingleEnemy : AbstractBattleAnimation {
    
    ParticleEmitter *comet;
    ParticleEmitter *explosion;
    int damage;
    Vector2f velocity;
}

@end

//
//  OthalaSingleEnemy.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/21/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"

@class ParticleEmitter;
@class FadeInOrOut;

@interface OthalaSingleEnemy : AbstractBattleAnimation {
    
    ParticleEmitter *othalaEmitter;
    FadeInOrOut *dimWorld;
    int damage;
}

@end

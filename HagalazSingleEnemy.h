//
//  HagalazSingleEnemy.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/24/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"

@class ParticleEmitter;
@class FadeInOrOut;

@interface HagalazSingleEnemy : AbstractBattleAnimation {
    
    ParticleEmitter *hailEmitter;
    ParticleEmitter *statEmitter;
    float hagalazDuration;
    int mod;
    FadeInOrOut *dimWorld;
}

@end

//
//  HoppatAllEnemies.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/7/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "AbstractBattleAnimation.h"

@class FadeInOrOut;
@class ParticleEmitter;

@interface HoppatAllEnemies : AbstractBattleAnimation {
    
    FadeInOrOut *dimWorld;
    ParticleEmitter *frogEmitter;
    int damages[4];
}

@end

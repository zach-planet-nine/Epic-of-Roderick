//
//  AustrinSingleCharacter.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/23/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"

@class ParticleEmitter;

@interface AustrinSingleCharacter : AbstractBattleAnimation {
    
    ParticleEmitter *raiseStatsEmitter;
    int powerMod;
    int affinityMod;
    float austrinDuration;
}

@end

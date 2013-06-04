//
//  TiwazAllCharacters.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/28/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"

@class ParticleEmitter;

@interface TiwazAllCharacters : AbstractBattleAnimation {
    
    ParticleEmitter *comet;
    float tiwazDuration;
    float yMod;
    int cometDirection;
}

@end

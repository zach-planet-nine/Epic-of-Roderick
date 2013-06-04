//
//  TiwazSingleCharacter.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/28/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"

@class ParticleEmitter;

@interface TiwazSingleCharacter : AbstractBattleAnimation {
    
    ParticleEmitter *comet;
    float tiwazDuration;
    int cometDirection;
}

@end

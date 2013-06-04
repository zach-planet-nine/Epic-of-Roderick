//
//  HagalazSingleCharacter.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/24/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"

@class ParticleEmitter;

@interface HagalazSingleCharacter : AbstractBattleAnimation {
    
    ParticleEmitter *statRaisedEmitter;
    ParticleEmitter *rageEmitter;
    int mod;
    float hagalazDuration;
}

@end

//
//  UruzSingleCharacter.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/6/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"

@class ParticleEmitter;

@interface UruzSingleCharacter : AbstractBattleAnimation {
    
    ParticleEmitter *statRaisedEmitter;
    float modDuration;
    int mod;
}

@end

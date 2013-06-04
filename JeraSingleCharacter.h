//
//  JeraSingleCharacter.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/24/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h> 
#import "AbstractBattleAnimation.h"

@class ParticleEmitter;

@interface JeraSingleCharacter : AbstractBattleAnimation {
    
    ParticleEmitter *statRaisedEmitter;
    float jeraDuration;
    int mod;
}

@end

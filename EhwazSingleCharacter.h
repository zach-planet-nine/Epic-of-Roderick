//
//  EhwazSingleCharacter.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/8/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "AbstractBattleAnimation.h"

@class ParticleEmitter;

@interface EhwazSingleCharacter : AbstractBattleAnimation {
    
    ParticleEmitter *statRaisedEmitter;
    float ehwazDuration;
    int mod;
}

@end

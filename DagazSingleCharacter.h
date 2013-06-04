//
//  DagazSingleCharacter.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/9/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "AbstractBattleAnimation.h"

@class ParticleEmitter;

@interface DagazSingleCharacter : AbstractBattleAnimation {
    
    ParticleEmitter *auraEmitter;
    int auraRoll;
}

@end

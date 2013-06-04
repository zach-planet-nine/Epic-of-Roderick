//
//  SudrinSingleEnemy.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/22/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"

@class ParticleEmitter;

@interface SudrinSingleEnemy : AbstractBattleAnimation {
    
    int fatigueDuration;
    ParticleEmitter *essenceEmitter;

}

@end

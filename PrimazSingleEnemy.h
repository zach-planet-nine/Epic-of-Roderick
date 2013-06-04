//
//  PrimazSingleEnemy.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/26/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"

@class ParticleEmitter;

@interface PrimazSingleEnemy : AbstractBattleAnimation {
    
    NSMutableArray *valkyries;
    NSMutableArray *spears;
    float primazDuration;
    ParticleEmitter *bloodBurst;
    
}

@end

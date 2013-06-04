//
//  IsaAllEnemies.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/19/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"

@class ParticleEmitter;

@interface IsaAllEnemies : AbstractBattleAnimation {
    
    NSMutableArray *iceEmitters;
    float baseDamage;
}

@end

//
//  NordrinAllEnemies.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/22/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"

@class ParticleEmitter;

@interface NordrinAllEnemies : AbstractBattleAnimation {
    
    ParticleEmitter *nordrinEmitter;
    int damage[4];
}

@end

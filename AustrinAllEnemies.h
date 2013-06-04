//
//  AustrinAllEnemies.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/23/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"

@class ParticleEmitter;
@class FadeInOrOut;

@interface AustrinAllEnemies : AbstractBattleAnimation {
    
    ParticleEmitter *rainEmitter;
    FadeInOrOut *dimWorld;
    int damage[4];
}

@end

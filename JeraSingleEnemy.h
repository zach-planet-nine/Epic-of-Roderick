//
//  JeraSingleEnemy.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/24/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"

@class Image;
@class ParticleEmitter;

@interface JeraSingleEnemy : AbstractBattleAnimation {
    
    Image *norn;
    ParticleEmitter *rageExplosion;
    int damage;
}

@end

//
//  LaguzSingleEnemy.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/7/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "AbstractBattleAnimation.h"

@class Image;
@class ParticleEmitter;

@interface LaguzSingleEnemy : AbstractBattleAnimation {
    
    ParticleEmitter *groundBreaking;
	Image *mole;
    int enduranceDamage;
}

@end

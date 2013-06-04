//
//  SowiloSingleEnemy.h
//  TEORBattleTest
//
//  Created by Zach Babb on 5/31/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"

@class ParticleEmitter;
@class Image;
@class BattleValkyrie;


@interface SowiloSingleEnemy : AbstractBattleAnimation {

	ParticleEmitter *sun;
	Image *rayOfLight;
	BattleValkyrie *valkyrie;
	int direction;
	float startAngle;
    float disorientRoll;
    int staminaDown;
}

@end

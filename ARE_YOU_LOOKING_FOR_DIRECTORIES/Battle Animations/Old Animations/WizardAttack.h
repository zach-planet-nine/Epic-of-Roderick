//
//  WizardAttack.h
//  TEORBattleTest
//
//  Created by Zach Babb on 5/24/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"

@class Projectile;


@interface WizardAttack : AbstractBattleAnimation {

	float power;
	//float duration;
	Projectile *wizardBall;
	CGPoint fontRenderPoint;
}

- (id)initWithCharacter:(int)aCharacter toEnemy:(int)aEnemy withPower:(float)aPower;

@end

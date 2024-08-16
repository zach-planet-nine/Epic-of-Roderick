//
//  FirstWizardBallAttack.h
//  TEORBattleTest
//
//  Created by Zach Babb on 5/29/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"

@class Projectile;
@class ParticleEmitter;

@interface FirstWizardBallAttack : AbstractBattleAnimation {

	Projectile *wizardBall;
	ParticleEmitter *wizardBallExplosion;
	CGPoint fontRenderPoint;
	int damage;
	float power;
}

- (id)initToEnemy:(AbstractBattleEnemy *)aEnemy waiting:(float)aWaitTime;

@end

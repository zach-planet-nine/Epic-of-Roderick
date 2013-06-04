//
//  FirstSpearPoke.h
//  TEORBattleTest
//
//  Created by Zach Babb on 5/29/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"

@class Projectile;
@class ParticleEmitter;

@interface FirstSpearPoke : AbstractBattleAnimation {

	Projectile *spear;
	ParticleEmitter *bloodBurst;
	CGPoint fontRenderPoint;
	int damage;
	
}

- (id)initToEnemy:(AbstractBattleEnemy *)aEnemy waiting:(float)aWaitTime;

@end

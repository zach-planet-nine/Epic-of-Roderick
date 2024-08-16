//
//  FirstPriestAttack.h
//  TEORBattleTest
//
//  Created by Zach Babb on 5/29/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"

@class ParticleEmitter;
@class BattlePriest;


@interface FirstPriestAttack : AbstractBattleAnimation {
	
	ParticleEmitter *priestExplosion;
	BattlePriest *priest;
	int explosions;
	BOOL renderDamage;
	int damage;
	CGPoint fontRenderPoint;
	BOOL hasAttacked;

}

- (void)updatePriestExplosion;

- (id)initToEnemy:(AbstractBattleEnemy *)aEnemy waiting:(float)aWaitTime;

@end

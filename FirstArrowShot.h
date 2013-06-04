//
//  FirstArrowShot.h
//  TEORBattleTest
//
//  Created by Zach Babb on 5/29/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"

@class Projectile;
@class ParticleEmitter;
@class BattleRanger;

@interface FirstArrowShot : AbstractBattleAnimation {

	Projectile *arrow;
	ParticleEmitter *bleeder;
	CGPoint destination;
	BattleRanger *ranger;
	int bleeds;
    int damage;
}

- (id)initToEnemy:(AbstractBattleEnemy *)aEnemy waiting:(float)aWaitTime;

- (id)initFromEnemy:(AbstractBattleEnemy *)aEnemy toCharacter:(AbstractBattleCharacter *)aCharacter;

@end

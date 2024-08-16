//
//  PondSingleEnemyAttack.h
//  TEORBattleTest
//
//  Created by Zach Babb on 5/30/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"

@class ParticleEmitter;
@class Pond;

@interface PondSingleEnemyAttack : AbstractBattleAnimation {

	ParticleEmitter *waterSpout;
	ParticleEmitter *splash;
}

- (id)initToEnemy:(AbstractBattleEnemy *)aEnemy from:(Pond *)aPond;

@end

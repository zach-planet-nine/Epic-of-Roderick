//
//  KenazSingleEnemy.h
//  TEORBattleTest
//
//  Created by Zach Babb on 5/31/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"

@class ParticleEmitter;
@class BattleWizard;

@interface KenazSingleEnemy : AbstractBattleAnimation {

	ParticleEmitter *fire;
	BattleWizard *wizard;
    int damage;
}

@end

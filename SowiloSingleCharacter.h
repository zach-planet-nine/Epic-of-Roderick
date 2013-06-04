//
//  SowiloSingleCharacter.h
//  TEORBattleTest
//
//  Created by Zach Babb on 5/31/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"

@class ParticleEmitter;
@class BattleValkyrie;


@interface SowiloSingleCharacter : AbstractBattleAnimation {

	ParticleEmitter *sun;
	ParticleEmitter *sunsRays;
	BattleValkyrie *valkyrie;
}

@end

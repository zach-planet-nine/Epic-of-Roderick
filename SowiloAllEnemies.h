//
//  SowiloAllEnemies.h
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

@interface SowiloAllEnemies : AbstractBattleAnimation {

	ParticleEmitter *sun;
	Image *yellowPixel;
	BattleValkyrie *valkyrie;
    float sowiloRolls[4];
	
}

@end

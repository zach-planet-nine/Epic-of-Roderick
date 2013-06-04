//
//  WunjoAllEnemies.h
//  TEORBattleTest
//
//  Created by Zach Babb on 6/2/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"

@class ParticleEmitter;


@interface WunjoAllEnemies : AbstractBattleAnimation {

	ParticleEmitter *groundBreaker;
	ParticleEmitter *skeletonEmitter;
	
}

- (void)calculateEffect;


@end

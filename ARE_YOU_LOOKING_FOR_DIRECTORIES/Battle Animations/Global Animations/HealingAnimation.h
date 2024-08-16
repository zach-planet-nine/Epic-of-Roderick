//
//  HealingAnimation.h
//  TEORBattleTest
//
//  Created by Zach Babb on 5/30/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"

@class ParticleEmitter;


@interface HealingAnimation : AbstractBattleAnimation {

	ParticleEmitter *healingAnimationEmitter;
}

- (id)initAtPosition:(CGPoint)aPosition;

@end

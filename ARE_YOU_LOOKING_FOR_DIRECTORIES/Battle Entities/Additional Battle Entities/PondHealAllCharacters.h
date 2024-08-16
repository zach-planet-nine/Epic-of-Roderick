//
//  PondHealAllCharacters.h
//  TEORBattleTest
//
//  Created by Zach Babb on 5/30/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"

@class ParticleEmitter;
@class Pond;

@interface PondHealAllCharacters : AbstractBattleAnimation {

	ParticleEmitter *bubbleEmitter;

}

- (id)initFrom:(Pond *)aPond;

- (void)calculateEffectFrom:(Pond *)aOriginator;

@end

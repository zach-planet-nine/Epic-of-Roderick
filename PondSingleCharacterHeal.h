//
//  PondSingleCharacterHeal.h
//  TEORBattleTest
//
//  Created by Zach Babb on 5/30/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"

@class ParticleEmitter;
@class Pond;


@interface PondSingleCharacterHeal : AbstractBattleAnimation {

	ParticleEmitter *bubbleEmitter;
}

- (id)initToCharacter:(AbstractBattleCharacter *)aCharacter from:(Pond *)aPond;

@end

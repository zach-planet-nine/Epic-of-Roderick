//
//  FrogSingleCharacter.h
//  TEORBattleTest
//
//  Created by Zach Babb on 6/1/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"

@class ParticleEmitter;
@class Frog;

@interface FrogSingleCharacter : AbstractBattleAnimation {
	
	ParticleEmitter *essenceEmitter;

}

- (id)initToCharacter:(AbstractBattleCharacter *)aCharacter from:(Frog *)aFrog;

@end

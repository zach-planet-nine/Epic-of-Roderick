//
//  WeaponElement.h
//  TEORBattleTest
//
//  Created by Zach Babb on 6/1/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"

@class ParticleEmitter;
@class AbstractBattleCharacter;

@interface WeaponElement : AbstractBattleAnimation {

	ParticleEmitter *elementEmitter;
}

- (id)initFromCharacter:(AbstractBattleCharacter *)aCharacter withElement:(int)aElement;

@end

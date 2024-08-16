//
//  ElementalShield.h
//  TEORBattleTest
//
//  Created by Zach Babb on 6/1/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"

@class ParticleEmitter;


@interface ElementalShield : AbstractBattleAnimation {
	
	ParticleEmitter *elementalShield;

}

- (id)initFromCharacter:(AbstractBattleCharacter *)aCharacter withElement:(int)aElement;

@end

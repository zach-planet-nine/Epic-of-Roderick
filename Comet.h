//
//  Comet.h
//  TEORBattleTest
//
//  Created by Zach Babb on 5/27/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Global.h"
#import "AbstractBattleAnimation.h"

@class ParticleEmitter;


@interface Comet : AbstractBattleAnimation {
	
	int damage;
	Vector2f velocity;
	ParticleEmitter *comet;
	ParticleEmitter *explosion;
	CGPoint fontRenderPoint; //Since some animations will not have damage/healing associated
							 //We keep this out of the AbstractBattleAnimation class

}

//- (id)initWithCharacter:(int)aCharacter toEnemy:(int)aEnemy;

@end

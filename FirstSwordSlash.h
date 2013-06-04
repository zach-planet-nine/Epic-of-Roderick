//
//  FirstSwordSlash.h
//  TEORBattleTest
//
//  Created by Zach Babb on 5/29/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"

@class Animation;
@class ParticleEmitter;

@interface FirstSwordSlash : AbstractBattleAnimation {

	Animation *slashAnimation;
	ParticleEmitter *bloodSplatter;
	CGPoint renderPoint;
	float rotation;
	CGPoint fontRenderPoint;
	int damage;
	
	
}

- (id)initToEnemy:(AbstractBattleEnemy *)aEnemy waiting:(float)aWaitTime;

@end

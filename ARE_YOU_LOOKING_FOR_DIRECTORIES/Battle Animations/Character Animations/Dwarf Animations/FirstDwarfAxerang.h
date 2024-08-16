//
//  FirstDwarfAxerang.h
//  TEORBattleTest
//
//  Created by Zach Babb on 5/29/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"

@class Projectile;
@class Animation;

@interface FirstDwarfAxerang : AbstractBattleAnimation {
	
	Projectile *axerang;
	Animation *slashAnimation;
	CGPoint fontRenderPoint;
	int damage;
	float rotation;
	CGPoint renderPoint;

}

- (id)initToEnemy:(AbstractBattleEnemy *)aEnemy waiting:(float)aWaitTime;

@end

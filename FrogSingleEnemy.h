//
//  FrogSingleEnemy.h
//  TEORBattleTest
//
//  Created by Zach Babb on 6/1/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"
#import "Global.h"

@class Image;
@class Frog;

@interface FrogSingleEnemy : AbstractBattleAnimation {

	Vector2f velocity;
	Image *tongueAttack;
	Frog *frog;
	float gravity;
}

- (id)initToEnemy:(AbstractBattleEnemy *)aEnemy from:(Frog *)aFrog;

@end

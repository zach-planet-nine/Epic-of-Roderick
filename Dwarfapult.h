//
//  Dwarfapult.h
//  TEORBattleTest
//
//  Created by Zach Babb on 6/2/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"
#import "Global.h"

@class Animation;
@class Image;
@class AbstractBattleEnemy;
@class BattleDwarf;

@interface Dwarfapult : AbstractBattleAnimation {

	Image *catapultFrame;
	Animation *catapult;
	Vector2f velocity;
	float gravity;
	CGPoint originalPoint;
}

- (id)initToEnemy:(AbstractBattleEnemy *)aEnemy from:(BattleDwarf *)aDwarf;


@end

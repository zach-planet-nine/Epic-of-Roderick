//
//  FrogAllEnemies.m
//  TEORBattleTest
//
//  Created by Zach Babb on 6/1/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "FrogAllEnemies.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleEnemy.h"
#import "Frog.h"
#import "Global.h"


@implementation FrogAllEnemies

- (void)dealloc {
	
	[super dealloc];
}

- (id)initFrom:(Frog *)aFrog {
	
	if (self = [super init]) {
		frog = aFrog;
		[frog hopToPoint:CGPointMake(300, 80)];
		stage = 0;
		active = YES;
		duration = 0.35;
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	duration -= aDelta;
	if (duration < 0) {
		switch (stage) {
			case 0:
				[frog hopToPoint:CGPointMake(100 + (RANDOM_0_TO_1() * 380), 0 + (RANDOM_0_TO_1() * 320))];
				duration = 0.35;
				stage = 1;
				break;
			case 1:
				[frog hopToPoint:CGPointMake(100 + (RANDOM_0_TO_1() * 380), 0 + (RANDOM_0_TO_1() * 320))];
				stage = 2;
				duration = 0.35;
				break;
			case 2:
				[frog hopToPoint:CGPointMake(100 + (RANDOM_0_TO_1() * 380), 0 + (RANDOM_0_TO_1() * 320))];
				stage = 3;
				duration = 0.35;
				break;
			case 3:
				[frog hopToPoint:CGPointMake(100 + (RANDOM_0_TO_1() * 380), 0 + (RANDOM_0_TO_1() * 320))];
				stage = 4;
				duration = 0.35;
				break;
			case 4:
				[frog hopBackToRanger];
				[self calculateEffect];
				stage = 5;
				duration = 0.35;
				break;
			case 5:
				stage = 6;
				active = NO;
				break;


			default:
				break;
		}
	}
}

- (void)calculateEffect {
	
	for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
		if ([enemy isKindOfClass:[AbstractBattleEnemy class]]) {
			[enemy flashColor:Color4fMake(1, 0, 0, 1)];
			[enemy youTookDamage:24];
		}
	}
}

@end

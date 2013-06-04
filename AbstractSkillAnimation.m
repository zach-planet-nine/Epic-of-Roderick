//
//  AbstractSkillAnimation.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/6/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "AbstractSkillAnimation.h"
#import "GameController.h"
#import "InputManager.h"
#import "MenuSystem.h"
#import "BattleExampleEnemyForMenus.h"


@implementation AbstractSkillAnimation

@synthesize skillExplanation;

- (void)dealloc {
	
	if (exampleEnemy) {
		[exampleEnemy release];
	}
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
		exampleEnemy = [[BattleExampleEnemyForMenus alloc] init];
		skillTimer = 5;
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	skillTimer -= aDelta;
}

- (void)render {
}

- (void)resetAnimation {}

@end

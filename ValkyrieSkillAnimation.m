//
//  ValkyrieSkillAnimation.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/7/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "ValkyrieSkillAnimation.h"
#import "GameController.h"
#import "BattleValkyrie.h"
#import "SpearShower.h"
#import "ImageRenderManager.h"


@implementation ValkyrieSkillAnimation

- (void)dealloc {
	
	if (ss) {
		[ss release];
	}
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
		
		valkyrie = [[BattleValkyrie alloc] initWithBattleLocation:2];
		valkyrie.rageMeter = 100;
		ss = [[SpearShower alloc] initToEnemy:exampleEnemy from:valkyrie];
		ss.active = NO;
		skillExplanation = @"The Valkyrie exacts vengeance on enemies. Time and being attacked will fill her rage meter. When the meter is full she launches a vicious attack against the enemy she is linked to. Guide her rage by drawing a line from the Valkyrie to an enemy.";
		
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	
	[super updateWithDelta:aDelta];
	if (ss.active) {
		[ss updateWithDelta:aDelta];
	}
	if (skillTimer < 0) {
		[ss resetAnimation];	
		skillTimer = 5;
	}
}

- (void)render {

	[valkyrie render];
	[exampleEnemy render];
	if (ss.active) {
		[[ImageRenderManager sharedImageRenderManager] renderImages];
		[ss render];
	}
}

- (void)resetAnimation {
	[ss resetAnimation];	
	skillTimer = 5;
}
	

@end

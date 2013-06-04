//
//  RoderickSkillAnimation.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/6/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "RoderickSkillAnimation.h"
#import "Pond.h"
#import "PondSingleEnemyAttack.h"
#import "ImageRenderManager.h"
#import "BattleRoderick.h"
#import "GameController.h"


@implementation RoderickSkillAnimation

- (void)dealloc {
	
	if (pond) {
		[pond release];
	}
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
        skillExplanation = @"Roderick has no special abilities.";
        BattleRoderick *roderick = [[GameController sharedGameController].battleCharacters objectForKey:@"BattleRoderick"];
        if (roderick.hasLearnedElemental) {
            pond = [[Pond alloc] init];
            pond.renderPoint = CGPointMake(100, 90);
            skillExplanation = @"Roderick has the ability to control the elements of the environment around him. Just draw a line from the environmental element to one of the four battle zones to have the environment attack enemies or help your allies.";
            psea = [[PondSingleEnemyAttack alloc] initToEnemy:exampleEnemy from:pond];
            psea.active = NO;
        } 
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	[super updateWithDelta:aDelta];
	if (psea.active) {
		[psea updateWithDelta:aDelta];
	}
	if (skillTimer < 0) {
		[psea resetAnimation];	
		skillTimer = 5;
	}
}

- (void)render {
	
    if (pond) {
        [pond render];
        [exampleEnemy render];
        if (psea.active) {
            [[ImageRenderManager sharedImageRenderManager] renderImages];
            [psea render];
        }
    }
}

- (void)resetAnimation {
	[psea resetAnimation];	
	skillTimer = 5;
}
	

@end

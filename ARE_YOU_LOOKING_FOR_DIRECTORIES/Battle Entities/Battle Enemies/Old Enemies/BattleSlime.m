//
//  BattleSlime.m
//  TEORBattleTest
//
//  Created by Zach Babb on 5/25/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "BattleSlime.h"
#import "Image.h"
#import "EnemyBite.h"
#import "GameController.h"
#import "PackedSpriteSheet.h"


@implementation BattleSlime

- (void)dealloc {
	
	[super dealloc];
}

- (id)initWithBattleLocation:(int)aLocation {
	
	if (self = [super initWithBattleLocation:aLocation]) {
		
		defaultImage = [[[sharedGameController.teorPSS imageForKey:@"Slime120x120.png"] imageDuplicate] retain];
		whichEnemy = kSlime;
		battleLocation = aLocation;
		state = kEntityState_Alive;
		level = 3;
		hp = 30;
		maxHP = 30;
		essence = 0;
		maxEssence = 0;
		strength = 2;
		agility = 7;
		stamina = 4;
		dexterity = 6;
		power = 0;
		luck = 0;
		battleTimer = 0.0;
		experience = 40;
	}
	selectorImage.renderPoint = CGPointMake(renderPoint.x, renderPoint.y - 40);
	selectorImage.color = Color4fMake(1.0, 0.0, 0.0, 1.0);
	isAlive = YES;
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	[super updateWithDelta:aDelta];
	if (battleTimer == 1.0) {
		int character = (int)(RANDOM_0_TO_1() * 3 + 1);
		EnemyBite *bite = [[EnemyBite alloc] initWithEnemy:battleLocation toCharacter:character];
		[[sharedGameController currentScene] addObjectToActiveObjects:bite];
		[bite release];
		battleTimer = 0.0;
	}
}

- (void)render {
	
	[super render];
}

@end

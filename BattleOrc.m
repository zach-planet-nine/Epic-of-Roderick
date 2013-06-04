//
//  BattleOrc.m
//  TEORBattleTest
//
//  Created by Zach Babb on 5/25/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "BattleOrc.h"
#import "Image.h"
#import "AbstractBattleCharacter.h"
#import "GameController.h"
#import "PackedSpriteSheet.h"
#import "AbstractScene.h"
#import "EnemyBite.h"


@implementation BattleOrc

- (void)dealloc {
	
	[super dealloc];
}

- (id)initWithBattleLocation:(int)aLocation {
	
	if (self = [super initWithBattleLocation:aLocation]) {
		
		defaultImage = [[[sharedGameController.teorPSS imageForKey:@"Orc120x120.png"] imageDuplicate] retain];
		whichEnemy = kOrc;
		battleLocation = aLocation;
		state = kEntityState_Alive;
		level = 6;
		hp = 120;
		maxHP = 120;
		essence = 0;
		maxEssence = 0;
		strength = 6;
		agility = 3;
		stamina = 9;
		dexterity = 6;
		power = 0;
		luck = 0;
		battleTimer = 0.0;
		isAlive = YES;
        experience = 100;
		
	}
	selectorImage.renderPoint = CGPointMake(renderPoint.x, renderPoint.y - 40);
	selectorImage.color = Color4fMake(1.0, 0.0, 0.0, 1.0);

	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	[super updateWithDelta:aDelta];
	if (battleTimer == 1.0) {
		for (AbstractBattleCharacter *character in [sharedGameController currentScene].activeEntities) {
			if (character.hp == character.maxHP) {
				//EnemySmash *smash = [[EnemySmash alloc] initWithEnemy:battleTimer toCharacter:character.whichCharacter];
				//[[sharedGameController currentScene] addObjectToActiveObjects:smash];
				//battleTimer = 0.0;
				break;
			}
		}
		
		if (battleTimer == 1.0) {
			int character = (int)(RANDOM_0_TO_1() * 3 + 1);
			EnemyBite *bite = [[EnemyBite alloc] initWithEnemy:battleLocation toCharacter:character];
			[[sharedGameController currentScene] addObjectToActiveObjects:bite];
			[bite release];
			battleTimer = 0.0;
		}
	}
}

- (void)render {
	
	[super render];
}


@end

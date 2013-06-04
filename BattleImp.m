//
//  BattleImp.m
//  TEORBattleTest
//
//  Created by Zach Babb on 5/25/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "BattleImp.h"
#import "Image.h"
#import "AbstractBattleCharacter.h"
#import "GameController.h"
#import "PackedSpriteSheet.h"
#import "AbstractScene.h"
#import "EnemyBite.h"



@implementation BattleImp

- (void)dealloc {
	
	[super dealloc];
}

- (id)initWithBattleLocation:(int)aLocation {
	
	if (self = [super initWithBattleLocation:aLocation]) {
		
		defaultImage = [[[sharedGameController.teorPSS imageForKey:@"Imp120x120.png"] imageDuplicate] retain];
		
		
		//NSLog(@"Deafult Image was successfully created. %f", defaultImage.color.red);
		whichEnemy = kImp;
		battleLocation = aLocation;
		state = kEntityState_Alive;
		level = 5;
		hp = 80;
		maxHP = 80;
		essence = 0;
		maxEssence = 0;
		strength = 4;
		agility = 3;
		stamina = 6;
		dexterity = 6;
		power = 0;
		luck = 0;
		battleTimer = 0.0;
		isAlive = YES;
        experience = 80;
		
	}
	selectorImage.renderPoint = CGPointMake(renderPoint.x, renderPoint.y - 40);
	selectorImage.color = Color4fMake(1.0, 0.0, 0.0, 1.0);
	return self;
}

- (void)updateWithDelta:(float)aDelta {
    
	[super updateWithDelta:aDelta];
	if (isFlashing) {
		flashTimer -= aDelta;
		if (flashTimer < 0) {
			//NSLog(@"Color alpha is: %f.", defaultImage.color.alpha);
			if (defaultImage.color.alpha < 1) {
				defaultImage.color = Color4fOnes;
				flashes--;
				flashTimer = 0.04;
				if (flashes == 0) {
					isFlashing = NO;
				}
			} else {
				defaultImage.color = flashColor;
				flashTimer = 0.04;
			}
			
		}
	}	
	if (battleTimer == 1.0) {
		for (AbstractBattleEnemy *enemy in [sharedGameController currentScene].activeEntities) {
			if (enemy.hp < enemy.maxHP / 10) {
				/*EnemyCure *cure = [[EnemyCure alloc] initWithEnemy:battleLocation toEnemy:enemy.battleLocation];
				[[sharedGameController currentScene] addObjectToActiveObjects:cure];
				[cure release];
				battleTimer = 0.0;
				break;*/
			}
		}
		if (battleTimer == 1.0) {
			int character = (int)(RANDOM_0_TO_1() * 3 + 1);
			EnemyBite *bite = [[EnemyBite alloc] initWithEnemy:battleLocation toCharacter:character];
			[[sharedGameController currentScene] addObjectToActiveObjects:bite];
			[bite release];
			battleTimer = 0.0;		}
	}
}

@end

//
//  BattleExampleEnemyForMenus.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/6/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "BattleExampleEnemyForMenus.h"
#import "GameController.h"
#import "PackedSpriteSheet.h"
#import "Image.h"


@implementation BattleExampleEnemyForMenus

- (void)dealloc {
	
	[super dealloc];
}

- (id)init {
	
	if (self = [super initWithBattleLocation:3]) {
		defaultImage = [[[sharedGameController.teorPSS imageForKey:@"Slime120x120.png"] imageDuplicate] retain];
		whichEnemy = kSlime;
		battleLocation = 3;
		state = kEntityState_Alive;
		level = 100;
		hp = 100000000;
		maxHP = 10000000;
		essence = 0;
		maxEssence = 0;
		strength = 100;
		agility = 100;
		stamina = 100;
		dexterity = 100;
		power = 100;
		luck = 100;
		battleTimer = 0.0;
	}
	return self;
}

@end

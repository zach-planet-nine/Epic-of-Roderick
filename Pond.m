//
//  Pond.m
//  TEORBattleTest
//
//  Created by Zach Babb on 5/29/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "Pond.h"
#import "AbstractBattleElementalEntity.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "PackedSpriteSheet.h"
#import "Image.h"
#import "PondSingleEnemyAttack.h"
#import "PondSingleCharacterHeal.h"
#import "PondInsectAttack.h"
#import "PondHealAllCharacters.h"

@implementation Pond

- (id)init {
	
	if (self = [super init]) {
		pond = [sharedGameController.teorPSS imageForKey:@"Pond40x40.png"];
		renderPoint = CGPointMake(100, 260);
		power = 30;
		essence = 50;
		maxEssence = 50;
	}
	return self;
}

- (void)render {
	
	[pond renderCenteredAtPoint:renderPoint];
}

- (void)youAttackedEnemy:(AbstractBattleEnemy *)aEnemy {
	
	PondSingleEnemyAttack *psea = [[PondSingleEnemyAttack alloc] initToEnemy:aEnemy from:self];
	[sharedGameController.currentScene addObjectToActiveObjects:psea];
	[psea release];
}

- (void)youAffectedCharacter:(AbstractBattleCharacter *)aCharacter {
	
	PondSingleCharacterHeal *psch = [[PondSingleCharacterHeal alloc] initToCharacter:aCharacter from:self];
	[sharedGameController.currentScene addObjectToActiveObjects:psch];
	[psch release];
}

- (void)youAffectedAllEnemies {
	
	PondInsectAttack *pia = [[PondInsectAttack alloc] initFromPond:self];
	[sharedGameController.currentScene addObjectToActiveObjects:pia];
	[pia release];
}

- (void)youAffectedAllCharacters {
	
	PondHealAllCharacters *phac = [[PondHealAllCharacters alloc] initFrom:self];
	[sharedGameController.currentScene addObjectToActiveObjects:phac];
	[phac release];
}

@end

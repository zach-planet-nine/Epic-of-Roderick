//
//  BattleDwarf.h
//  TEORBattleTest
//
//  Created by Zach Babb on 5/25/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleCharacter.h"

@class Animation;
@class OverMind;

@interface BattleDwarf : AbstractBattleCharacter {

	Animation *currentTurnAnimation;

	//Have different timers for the different drinks. Have each time they go off
	//be a chance for the dwarf to "sober up."
	int totalDrinks; //When this gets too high the dwarf is less effective.
	float decisionTimer;
    float healProb;
    EnemyAI ai[8];
    OverMind *sharedOverMind;
}

- (void)youOrderedADrink:(int)aDrink;

- (void)decideWhatToDo;

- (BOOL)canIDoThis:(int)aDecisionIndex;

- (void)doThis:(EnemyAI)aDecision;

- (int)calculateHealingTo:(AbstractBattleCharacter *)aCharacter;

- (int)calculateTrapDamageTo:(AbstractBattleEnemy *)aEnemy;

- (int)calculateDwarfapultDamageTo:(AbstractBattleEnemy *)aEnemy;

- (int)calculateSuperAxerangDamageTo:(AbstractBattleEnemy *)aEnemy;

- (int)calculateMotivationDurationTo:(AbstractBattleCharacter *)aCharacter;

- (int)calculateBombulusDamageTo:(AbstractBattleEnemy *)aEnemy;

@end

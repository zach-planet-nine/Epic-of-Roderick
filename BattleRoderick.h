//
//  BattleRoderick.h
//  TEORBattleTest
//
//  Created by Zach Babb on 5/25/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleCharacter.h"

@class Animation;
@class AbstractBattleEnemy;

@interface BattleRoderick : AbstractBattleCharacter {
	
	Animation *currentTurnAnimation;
	Animation *waitingAnimation;
    int battles;
    BOOL hasLearnedElemental;
	
}

@property (nonatomic, assign) int battles;
@property (nonatomic, assign) BOOL hasLearnedElemental;

- (int)calculateIsaDamageTo:(AbstractBattleEnemy *)aEnemy;

- (int)calculateOthalaDamageTo:(AbstractBattleEnemy *)aEnemy;

- (int)calculateGromanthDurationTo:(AbstractBattleEnemy *)aEnemy;

- (float)calculateGromanthAffinityTimeTo:(AbstractBattleEnemy *)aEnemy;

- (float)calculateGromanthAffinityTimeToCharacter:(AbstractBattleCharacter *)aCharacter;

- (int)calculateNordrinDamageTo:(AbstractBattleEnemy *)aEnemy;

- (int)calculateSudrinDurationTo:(AbstractBattleEnemy *)aEnemy;

- (float)calculateAustrinDurationTo:(AbstractBattleEnemy *)aEnemy;

- (int)calculateAustrinDamageTo:(AbstractBattleEnemy *)aEnemy;

- (float)calculateAustrinCharacterDurationTo:(AbstractBattleCharacter *)aCharacter;

- (float)calculateVestrinDurationTo:(AbstractBattleEnemy *)aEnemy;

- (int)calculateVestrinDamageTo:(AbstractBattleEnemy *)aEnemy;

- (float)calculateVestrinRollTo:(AbstractBattleEnemy *)aEnemy;

@end

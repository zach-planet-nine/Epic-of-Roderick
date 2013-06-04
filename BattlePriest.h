//
//  BattlePriest.h
//  TEORBattleTest
//
//  Created by Zach Babb on 5/25/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleCharacter.h"

@class Animation;
@class AbstractBattleEnemy;

@interface BattlePriest : AbstractBattleCharacter {

	Animation *currentTurnAnimation;
    Animation *selected;
	BOOL sacraficeSetUp;
	BOOL isAttacking;
	AbstractBattleEnemy *victim;
	float attackTimer;
    float favor;
    float godTimer;
    float odinFavor;
    float thorFavor;
    float tyrFavor;
    float freyaFavor;
    float friggFavor;

}

@property (nonatomic, assign) BOOL isAttacking;
@property (nonatomic, assign) float favor;
@property (nonatomic, assign) float godTimer;
@property (nonatomic, assign) float odinFavor, thorFavor, tyrFavor, freyaFavor, friggFavor;

- (void)startAttackingEnemy:(AbstractBattleEnemy *)aEnemy;

- (void)stopAttacking;

- (void)loseEndurance;

- (float)calculateGeboDurationTo:(AbstractBattleEnemy *)aEnemy;

- (int)calculateGeboDamageTo:(AbstractBattleEnemy *)aEnemy;

- (int)calculateEhwazDamageTo:(AbstractBattleEnemy *)aEnemy;

- (float)calculateEhwazDurationTo:(AbstractBattleCharacter *)aCharacter;

- (int)calculateDagazHexRollTo:(AbstractBattleEnemy *)aEnemy;

- (int)calculateDagazAuraRollTo:(AbstractBattleCharacter *)aCharacter;

- (int)calculateIngrethDamageTo:(AbstractBattleEnemy *)aEnemy;

- (int)calculateHelazDamageTo:(AbstractBattleEnemy *)aEnemy;

- (int)calculateEpelthDamageTo:(AbstractBattleEnemy *)aEnemy;

- (int)calculateEpelthEnduranceAdded;

- (int)calculateSmeazDamageTo:(AbstractBattleEnemy *)aEnemy;

- (float)calculateSmeazDuration;

@end

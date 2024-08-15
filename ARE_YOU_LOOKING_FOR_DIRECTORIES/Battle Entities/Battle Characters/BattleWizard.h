//
//  BattleWizard.h
//  TEORBattleTest
//
//  Created by Zach Babb on 5/25/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleCharacter.h"

@class Animation;
@class AbstractBattleAnimation;

@interface BattleWizard : AbstractBattleCharacter {

	Animation *currentTurnAnimation;
	BOOL wizardBallTimerOn;
	Image *wizardBall;
	AbstractBattleAnimation *queuedDivination;
	float divinationTimer;

}

@property (nonatomic, assign) float divinationTimer;

- (void)startWizardAttack;

- (void)stopWizardAttack;

- (void)makeWizardBallPower:(float)aPower;

- (float)findWizardBallPower;

- (void)rollBones;

- (void)youRolledA:(int)aRoll;

- (int)calculateKenazDamageTo:(AbstractBattleEnemy *)aEnemy;

- (int)calculateRaidhoSlothRollTo:(AbstractBattleEnemy *)aEnemy;

- (int)calculateMannazSoldierCountTo:(AbstractBattleEnemy *)aEnemy;

- (int)calculateTiwazDamageTo:(AbstractBattleEnemy *)aEnemy;

- (float)calculateTiwazDurationTo:(AbstractBattleCharacter *)aCharacter;

- (int)calculateIngwazDamageTo:(AbstractBattleEnemy *)aEnemy;

- (int)calculateFyrazDamageTo:(AbstractBattleEnemy *)aEnemy;

- (float)calculateFyrazEssenceGiven;

- (int)calculateDaleythDamageTo:(AbstractBattleEnemy *)aEnemy;

- (int)calculateDaleythHealingTo:(AbstractBattleCharacter *)aCharacter;

- (void)accelerateTime;

- (int)calculateEkwazDamageTo:(AbstractBattleEnemy *)aEnemy;

- (float)calculateEkwazTotalDamage;

- (float)calculateEkwazDurationTo:(AbstractBattleCharacter *)aCharacter;

@end

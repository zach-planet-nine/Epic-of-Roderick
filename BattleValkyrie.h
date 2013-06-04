//
//  BattleValkyrie.h
//  TEORBattleTest
//
//  Created by Zach Babb on 5/25/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleCharacter.h"

@class Animation;
@class Image;
@class AbstractBattleEnemy;

@interface BattleValkyrie : AbstractBattleCharacter {

	Animation *currentTurnAnimation;
    Animation *selected;
	BOOL targetOn;
	Image *target;
	float rageMeter;
	AbstractBattleEnemy *rageTarget;
    float damageDealt;

}

@property (nonatomic, assign) float rageMeter;
@property (nonatomic, assign) float damageDealt;

- (CGPoint)getTargetPoint;

- (void)rageWasLinkedToEnemy:(AbstractBattleEnemy *)aEnemy;

- (void)rageTriggered;

- (void)updateTargetLocationWithAcceleration:(UIAcceleration *)aAcceleration;

- (float)calculateSowiloRollTo:(AbstractBattleEnemy *)aEnemy;

- (int)calculateSowiloStaminaDownTo:(AbstractBattleEnemy *)aEnemy;

- (float)calculateHagalazDurationTo:(AbstractBattleEnemy *)aEnemy;

- (float)calculateHagalazDurationToCharacter:(AbstractBattleCharacter *)aCharacter;

- (float)calculateJeraDurationTo:(AbstractBattleCharacter *)aCharacter;

- (int)calculateNauthizDamageTo:(AbstractBattleEnemy *)aEnemy;

- (float)calculateNauthizDuration;

- (int)calculateBerkanoHealingTo:(AbstractBattleCharacter *)aCharacter;

- (float)calculateBerkanoDuration;

- (float)calculatePrimazDurationTo:(AbstractBattleEnemy *)aEnemy;

- (int)calculatePrimazDamageTo:(AbstractBattleEnemy *)aEnemy;

- (int)calculatePrimazRageAdderFrom:(AbstractBattleCharacter *)aCharacter;

- (float)calculateAkathAdderTo:(AbstractBattleEnemy *)aEnemy;

- (int)calculateHolgethBirds;

- (int)calculateHolgethBleeders;

- (int)calculateHolgethHealers;

- (int)calculateSpearShowerDamageTo:(AbstractBattleEnemy *)aEnemy;

@end

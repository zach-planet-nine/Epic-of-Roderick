//
//  AbstractBattleEnemy.h
//  TEORBattleTest
//
//  Created by Zach Babb on 5/25/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleEntity.h"

@class Image;
@class OverMind;
@class AbstractBattleCharacter;

@interface AbstractBattleEnemy : AbstractBattleEntity {

	int battleLocation;
    int damageDealt;
    int partyLevel;
	int whichEnemy;
	Image *defaultImage;
    int experience;
    OverMind *sharedOverMind;
    float decisionChance;
    float decisionTimer;
    BOOL boobytrapped;
    
}

@property (nonatomic, assign) int whichEnemy;
@property (nonatomic, assign) int experience;
@property (nonatomic, retain) Image *defaultImage;
@property (nonatomic, readonly) int damageDealt;
@property (nonatomic, assign) BOOL boobytrapped;


- (id)initWithBattleLocation:(int)aLocation;

- (void)gainPriority;

- (BOOL)canIDoThis:(EnemyAI)aDecision;

- (void)decideWhatToDo;

- (void)doThis:(EnemyAI)aDecision decider:(AbstractBattleEnemy *)aEnemy;

- (BOOL)checkTarget:(EnemyAI)aDecision;

- (int)calculateBiteDamageToCharacter:(AbstractBattleCharacter *)aCharacter;

- (int)calculateSmashDamageToCharacter:(AbstractBattleCharacter *)aCharacter;

- (int)calculateEnergyBallDamageToCharacter:(AbstractBattleCharacter *)aCharacter;

- (int)calculateHealAmountTo:(AbstractBattleEnemy *)aEnemy;

- (int)calculateFireDamageToCharacter:(AbstractBattleCharacter *)aCharacter;

- (int)calculateFireDamageToASingleCharacter:(AbstractBattleCharacter *)aCharacter;

- (int)calculateArrowDamageToCharacter:(AbstractBattleCharacter *)aCharacter;

- (int)calculateSlashDamageToCharacter:(AbstractBattleCharacter *)aCharacter;

- (int)calculatePoisonDamageToCharacter:(AbstractBattleCharacter *)aCharacter;

- (int)calculatePoisonDamageToASingleCharacter:(AbstractBattleCharacter *)aCharacter;

- (int)calculateWaterDamageToCharacter:(AbstractBattleCharacter *)aCharacter;

- (int)calculateWaterDamageToASingleCharacter:(AbstractBattleCharacter *)aCharacter;

- (int)calculateRageDamageToCharacter:(AbstractBattleCharacter *)aCharacter;

- (int)calculateRageDamageToASingleCharacter:(AbstractBattleCharacter *)aCharacter;

- (void)levelUp;

@end

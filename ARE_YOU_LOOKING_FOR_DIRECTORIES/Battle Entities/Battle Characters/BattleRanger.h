//
//  BattleRanger.h
//  TEORBattleTest
//
//  Created by Zach Babb on 5/25/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleCharacter.h"

@class Animation;
@class Image;
@class AbstractBattleAnimalEntity;
@class AbstractBattleCharacter;
@class AbstractBattleEnemy;

@interface BattleRanger : AbstractBattleCharacter {

	Animation *currentTurnAnimation;
	BOOL targetOn;
	Image *target;
	AbstractBattleAnimalEntity *currentAnimal;

}

@property (nonatomic, retain) AbstractBattleAnimalEntity *currentAnimal;

- (CGRect)getAnimalRect;

- (void)setTargetPoint:(CGPoint)aPoint;

- (CGPoint)getTargetPoint;

- (void)updateTargetLocationWithAcceleration:(UIAcceleration *)aAcceleration;

- (void)updateTargetLocationWithX:(float)aX Y:(float)aY Z:(float)aZ;

- (void)animalWasLinkedToEnemy:(AbstractBattleEnemy *)aEnemy;

- (void)animalWasLinkedToCharacter:(AbstractBattleCharacter *)aCharacter;

- (void)animalWasLinkedToAllEnemies;

- (void)animalWasLinkedToAllCharacters;

- (BOOL)isHawkInDefenseMode;

- (float)calculateFehuDurationTo:(AbstractBattleEnemy *)aEnemy;

- (float)calculateFehuStatTimeTo:(AbstractBattleEnemy *)aEnemy;

- (int)calculateUruzDamageTo:(AbstractBattleEnemy *)aEnemy;

- (float)calculateUruzDurationTo:(AbstractBattleCharacter *)aCharacter;

- (int)calculateThurisazDamageTo:(AbstractBattleEnemy *)aEnemy;

- (int)calculateThurisazDamage;

- (float)calculateAlgizDurationTo:(AbstractBattleEnemy *)aEnemy;

- (int)calculateLaguzEnduranceDamageTo:(AbstractBattleEnemy *)aEnemy;

- (int)calculateLaguzDamageTo:(AbstractBattleEnemy *)aEnemy;

- (float)calculateLaguzDuration;

- (int)calculateHoppatDurationTo:(AbstractBattleEnemy *)aEnemy;

- (int)calculateHoppatDamageTo:(AbstractBattleEnemy *)aEnemy;

- (int)calculateSwopazDamageTo:(AbstractBattleEnemy *)aEnemy;

- (float)calculateSwopazDurationTo:(AbstractBattleCharacter *)aCharacter;

@end

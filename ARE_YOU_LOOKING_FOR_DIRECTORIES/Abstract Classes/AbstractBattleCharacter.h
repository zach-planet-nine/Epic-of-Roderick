//
//  AbstractBattleCharacter.h
//  TEORBattleTest
//
//  Created by Zach Babb on 5/25/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleEntity.h"

@class Animation;
@class Image;
@class RuneObject;
@class AbstractBattleEnemy;

@interface AbstractBattleCharacter : AbstractBattleEntity {

	int battleLocation;
	Animation *currentAnimation;
	NSMutableDictionary *knownRunes;
	RuneObject *queuedRune;
	int queuedRuneNumber;
	BOOL currentTurn;
	float currentTurnFlashTimer;
	NSMutableArray *weaponRuneStones;
	NSMutableArray *armorRuneStones;
    Image *currentTurnImage;
    Image *enduranceMeterImage;
    Image *essenceMeterImage;
    Image *hpMeterImage;
    Image *essenceMeter;
    Image *enduranceMeter;
    Image *hpMeter;
}

@property (nonatomic, retain) NSMutableDictionary *knownRunes;
@property (nonatomic, assign) BOOL currentTurn;
@property (nonatomic, assign) int queuedRuneNumber;

- (id)initWithBattleLocation:(int)aLocation;

- (void)initBattleAttributes;

- (void)endBattleWithExperience:(int)aExperience;

- (void)battleLocationIs:(int)aLocation;

- (void)relinquishPriority;

- (void)gainPriority;

- (void)updateRuneLocationTo:(CGPoint)aLocation;

- (void)queueRune:(int)aRune;

- (void)youAttackedEnemy:(AbstractBattleEnemy *)aEnemy;

- (void)runeWasPlacedOnEnemy:(AbstractBattleEnemy *)aEnemy;

- (void)runeWasPlacedOnCharacter:(AbstractBattleCharacter *)aCharacter;

- (void)runeAffectedAllCharacters;

- (void)runeAffectedAllEnemies;

- (void)youReceivedWeaponElement:(int)aElement;

- (void)youReceivedShield:(int)aElement;

- (int)calculateAttackDamageTo:(AbstractBattleEnemy *)aEnemy;

- (void)youHaveBeenRevived;

- (void)gainDoubleAttack:(int)aNumber;

@end

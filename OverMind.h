//
//  OverMind.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/12/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SynthesizeSingleton.h"

@class AbstractBattleEnemy;
@class AbstractBattleCharacter;
@class GameController;

@interface OverMind : NSObject {
    
    NSMutableArray *battleCharacters;
    NSMutableArray *battleEnemies;
    GameController *sharedGameController;
}

+ (OverMind *)sharedOverMind;

- (void)setUpArrays;

- (AbstractBattleEnemy *)anyEnemy;

- (AbstractBattleEnemy *)enemyWithLowestHP;

- (AbstractBattleEnemy *)enemyWithHighestHP;

- (AbstractBattleEnemy *)enemyWithLowestEssence;

- (AbstractBattleEnemy *)enemyWithHighestEssence;

- (AbstractBattleEnemy *)enemyWithLowestEndurance;

- (AbstractBattleEnemy *)enemyWithHighestEndurance;

- (AbstractBattleEnemy *)enemyWithLowestDefense;

- (AbstractBattleEnemy *)enemyWithLowestAffinity;

- (AbstractBattleEnemy *)enemyWithHPBelowPercent:(float)aPercent;

- (AbstractBattleEnemy *)enemyWithEssenceBelowPercent:(float)aPercent;

- (AbstractBattleEnemy *)enemyWithEnduranceBelowPercent:(float)aPercent;

- (AbstractBattleEnemy *)fatiguedEnemy;

- (AbstractBattleEnemy *)drauraedEnemy;

- (AbstractBattleEnemy *)slothedEnemy;

- (AbstractBattleEnemy *)hexedEnemy;

- (AbstractBattleEnemy *)disorientedEnemy;

- (AbstractBattleEnemy *)enemyHasNegativeStatus;

- (AbstractBattleEnemy *)enemyHasBleeders;

- (AbstractBattleEnemy *)needsElementalGuard:(int)aElement;

- (AbstractBattleEnemy *)needsElementalAttack:(int)aElement;

- (AbstractBattleEnemy *)notMotivated;

- (AbstractBattleEnemy *)notAuraed;

- (AbstractBattleCharacter *)anyCharacter;

- (AbstractBattleCharacter *)characterWithLowestHP;

- (AbstractBattleCharacter *)characterWithHighestHP;

- (AbstractBattleCharacter *)characterWithLowestStat:(int)aStat;

- (AbstractBattleCharacter *)characterWithHighestStat:(int)aStat;

- (AbstractBattleCharacter *)characterWithHighestEssence;

- (AbstractBattleCharacter *)characterWithLowestEssence;

- (AbstractBattleCharacter *)characterWithLowestEndurance;

- (AbstractBattleCharacter *)characterWithHighestEndurance;

- (AbstractBattleCharacter *)characterWithHPAbovePercent:(float)aPercent;

- (AbstractBattleCharacter *)characterWithEssenceAbovePercent:(float)aPercent;

- (AbstractBattleCharacter *)characterWithEnduranceAbovePercent:(float)aPercent;

- (AbstractBattleCharacter *)characterWithHPBelowPercent:(float)aPercent;

- (AbstractBattleCharacter *)characterWithEssenceBelowPercent:(float)aPercent;

- (AbstractBattleCharacter *)characterWithEnduranceBelowPercent:(float)aPercent;

- (AbstractBattleCharacter *)auraedCharacter;

- (AbstractBattleCharacter *)motivatedCharacter;

- (AbstractBattleCharacter *)fatiguedCharacter;

- (AbstractBattleCharacter *)drauraedCharacter;

- (AbstractBattleCharacter *)slothedCharacter;

- (AbstractBattleCharacter *)hexedCharacter;

- (AbstractBattleCharacter *)disorientedCharacter;

- (AbstractBattleCharacter *)characterWithLowestElementalAffinity:(int)aElement;

- (AbstractBattleCharacter *)characterWithHighestElementalAffinity:(int)aElement;

// Enemy physical attacks

- (void)enemy:(AbstractBattleEnemy *)aEnemy smashes:(AbstractBattleCharacter *)aCharacter;

- (void)enemy:(AbstractBattleEnemy *)aEnemy bites:(AbstractBattleCharacter *)aCharacter;

- (void)enemy:(AbstractBattleEnemy *)aEnemy arrows:(AbstractBattleCharacter *)aCharacter;

- (void)enemy:(AbstractBattleEnemy *)aEnemy slashes:(AbstractBattleCharacter *)aCharacter;

// Enemy magical attacks

- (void)enemy:(AbstractBattleEnemy *)aEnemy fires:(AbstractBattleCharacter *)aCharacter;

- (void)enemyFiresAllCharacters:(AbstractBattleEnemy *)aEnemy;

- (void)enemy:(AbstractBattleEnemy *)aEnemy energyBalls:(AbstractBattleCharacter *)aCharacter;

- (void)enemyPoisonsAllCharacters:(AbstractBattleEnemy *)aEnemy;

- (void)enemy:(AbstractBattleEnemy *)aEnemy poisons:(AbstractBattleCharacter *)aCharacter;

- (void)enemyWatersAllCharacters:(AbstractBattleEnemy *)aEnemy;

- (void)enemy:(AbstractBattleEnemy *)aEnemy waters:(AbstractBattleCharacter *)aCharacter;

- (void)enemy:(AbstractBattleEnemy *)aEnemy rages:(AbstractBattleCharacter *)aCharacter;

- (void)enemyRagesAllCharacters:(AbstractBattleEnemy *)aEnemy;

// Enemy effects on enemies

- (void)enemy:(AbstractBattleEnemy *)aEnemy heals:(AbstractBattleEnemy *)aTarget;

- (void)enemyCuresFatigue:(AbstractBattleEnemy *)aEnemy;

- (void)enemy:(AbstractBattleEnemy *)aEnemy healsNegativeStatusEffectOn:(AbstractBattleEnemy *)aTarget;

- (void)enemy:(AbstractBattleEnemy *)aEnemy healsBleedersOn:(AbstractBattleEnemy *)aTarget;


- (void)removeCharacter:(AbstractBattleCharacter *)aCharacter;

- (void)removeEnemy:(AbstractBattleEnemy *)aEnemy;

@end

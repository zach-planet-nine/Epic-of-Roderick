//
//  OverMind.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/12/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "OverMind.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleEnemy.h"
#import "AbstractBattleCharacter.h"
#import "EnemyBite.h"
#import "EnemySmash.h"
#import "EnemyEnergyBall.h"
#import "EnemyFire.h"
#import "EnemyHeal.h"
#import "EnemyFatigueCure.h"
#import "EnemyHealNegativeStatus.h"
#import "EnemyArrow.h"
#import "EnemySlash.h"
#import "EnemyPoison.h"
#import "EnemyPoisonAllCharacters.h"
#import "EnemyWater.h"
#import "EnemyWaterAllCharacters.h"
#import "EnemyHealBleeders.h"
#import "EnemyFireAllCharacters.h"
#import "EnemyRage.h"
#import "EnemyRageAllCharacters.h"

@implementation OverMind

SYNTHESIZE_SINGLETON_FOR_CLASS(OverMind);

- (void)dealloc {
    
    if (battleEnemies) {
        [battleEnemies release];
    }
    if (battleCharacters) {
        [battleCharacters release];
    }
    [super dealloc];
}

- (id)init {
    
    self = [super init];
    if (self) {
        battleCharacters = [[NSMutableArray alloc] init];
        battleEnemies = [[NSMutableArray alloc] init];
        sharedGameController = [GameController sharedGameController];
    }
    return self;
}

- (void)setUpArrays {
    
    [battleEnemies removeAllObjects];
    [battleCharacters removeAllObjects];
    for (AbstractBattleEntity *entity in [GameController sharedGameController].currentScene.activeEntities) {
        if ([entity isKindOfClass:[AbstractBattleCharacter class]]) {
            [battleCharacters addObject:entity];
        }
        else if ([entity isKindOfClass:[AbstractBattleEnemy class]]) {
            [battleEnemies addObject:entity];
        }
    }
}

- (AbstractBattleEnemy *)anyEnemy {
    
    return [battleEnemies objectAtIndex:(NSUInteger)arc4random() % [battleEnemies count]];
}

- (AbstractBattleEnemy *)enemyWithLowestHP {
    
    AbstractBattleEnemy *target = [battleEnemies objectAtIndex:0];
    for (AbstractBattleEnemy *enemy in battleEnemies) {
        if (enemy.hp < target.hp && enemy.isAlive) {
            target = enemy;
        }
    }
    return target;
}

- (AbstractBattleEnemy *)enemyWithHighestHP {
    
    AbstractBattleEnemy *target = [battleEnemies objectAtIndex:0];
    for (AbstractBattleEnemy *enemy in battleEnemies) {
        if (enemy.hp > target.hp) {
            target = enemy;
        }
    }
    return target;
}

- (AbstractBattleEnemy *)enemyWithLowestEssence {
    
    AbstractBattleEnemy *target = [battleEnemies objectAtIndex:0];
    for (AbstractBattleEnemy *enemy in battleEnemies) {
        if (enemy.essence < target.essence) {
            target = enemy;
        }
    }
    return target;
}

- (AbstractBattleEnemy *)enemyWithHighestEssence {
    
    AbstractBattleEnemy *target = [battleEnemies objectAtIndex:0];
    for (AbstractBattleEnemy *enemy in battleEnemies) {
        if (enemy.essence > target.essence) {
            target = enemy;
        }
    }
    return target;
}

- (AbstractBattleEnemy *)enemyWithLowestEndurance {
    
    AbstractBattleEnemy *target = [battleEnemies objectAtIndex:0];
    for (AbstractBattleEnemy *enemy in battleEnemies) {
        if (enemy.endurance < target.endurance) {
            target = enemy;
        }
    }
    return target;
}

- (AbstractBattleEnemy *)enemyWithHighestEndurance {
    
    AbstractBattleEnemy *target = [battleEnemies objectAtIndex:0];
    for (AbstractBattleEnemy *enemy in battleEnemies) {
        if (enemy.endurance > target.endurance) {
            target = enemy;
        }
    }
    return target;
}

- (AbstractBattleEnemy *)enemyWithLowestDefense {
    
    AbstractBattleEnemy *target = [battleEnemies objectAtIndex:0];
    for (AbstractBattleEnemy *enemy in battleEnemies) {
        if (enemy.dexterity + enemy.dexterityModifier + enemy.agility + enemy.agilityModifier < target.agility + target.agilityModifier + target.dexterity + target.dexterityModifier) {
            target = enemy;
        }
    }
    return target;
}

- (AbstractBattleEnemy *)enemyWithLowestAffinity {
    
    AbstractBattleEnemy *target = [battleEnemies objectAtIndex:0];
    for (AbstractBattleEnemy *enemy in battleEnemies) {
        if (enemy.affinity + enemy.affinityModifier < target.affinity + target.affinityModifier) {
            target = enemy;
        }
    }
    return target;
}

- (AbstractBattleEnemy *)enemyWithHPBelowPercent:(float)aPercent {
    
    AbstractBattleEnemy *target = [self enemyWithLowestHP];
    if (target.hp / target.maxHP * 100 < aPercent) {
        return target;
    }
    return nil;
}

- (AbstractBattleEnemy *)enemyWithEssenceBelowPercent:(float)aPercent {
    AbstractBattleEnemy *target = [self enemyWithLowestEssence];
    if (target.essence / target.maxEssence * 100 < aPercent) {
        return target;
    }
    return nil;
}

- (AbstractBattleEnemy *)enemyWithEnduranceBelowPercent:(float)aPercent {
    AbstractBattleEnemy *target = [self enemyWithLowestEndurance];
    if (target.endurance / target.maxEndurance * 100 < aPercent) {
        return target;
    }
    return nil;
}

- (AbstractBattleEnemy *)fatiguedEnemy {
    
    AbstractBattleEnemy *target = [battleEnemies objectAtIndex:0];
    if (target.isFatigued) {
        return target;
    } else {
        for (AbstractBattleEnemy *enemy in battleEnemies) {
            if (enemy.isFatigued) {
                return enemy;
            }
        }
    }
    return nil;
}

- (AbstractBattleEnemy *)drauraedEnemy {
    
    AbstractBattleEnemy *target = [battleEnemies objectAtIndex:0];
    if (target.isDrauraed) {
        return target;
    } else {
        for (AbstractBattleEnemy *enemy in battleEnemies) {
            if (enemy.isDrauraed) {
                return enemy;
            }
        }
    }
    return nil;
}

- (AbstractBattleEnemy *)slothedEnemy {
    
    AbstractBattleEnemy *target = [battleEnemies objectAtIndex:0];
    if (target.isSlothed) {
        return target;
    } else {
        for (AbstractBattleEnemy *enemy in battleEnemies) {
            if (enemy.isSlothed) {
                return enemy;
            }
        }
    }
    return nil;
}

- (AbstractBattleEnemy *)hexedEnemy {
    
    AbstractBattleEnemy *target = [battleEnemies objectAtIndex:0];
    if (target.isHexed) {
        return target;
    } else {
        for (AbstractBattleEnemy *enemy in battleEnemies) {
            if (enemy.isHexed) {
                return enemy;
            }
        }
    }
    return nil;
}

- (AbstractBattleEnemy *)disorientedEnemy {
    
    AbstractBattleEnemy *target = [self anyEnemy];
    if (target.isDisoriented) {
        return target;
    } else {
        for (AbstractBattleEnemy *enemy in battleEnemies) {
            if (enemy.isDisoriented) {
                return enemy;
            }
        }
    }
    return nil;
}

- (AbstractBattleEnemy *)enemyHasNegativeStatus {
    
    for (AbstractBattleEnemy *enemy in battleEnemies) {
        if (enemy.isFatigued || enemy.isDrauraed || enemy.isSlothed || enemy.isDisoriented || enemy.isHexed) {
            return enemy;
        }
    }
    return nil;
}

- (AbstractBattleEnemy *)enemyHasBleeders {
    
    AbstractBattleEnemy *target = [self anyEnemy];
    if ([target hasBleeders]) {
        return target;
    } else {
        for (AbstractBattleEnemy *enemy in battleEnemies) {
            if ([enemy hasBleeders]) {
                return enemy;
            }
        }
    }
    return nil;
}

- (AbstractBattleEnemy *)needsElementalGuard:(int)aElement {
    
    AbstractBattleEnemy *target = [self anyEnemy];
    switch (aElement) {
        case kWater:
            for (AbstractBattleEnemy *enemy in battleEnemies) {
                if (enemy.waterAffinity < target.waterAffinity) {
                    target = enemy;
                }
            }
            return target;
            break;
        case kSky:
            for (AbstractBattleEnemy *enemy in battleEnemies) {
                if (enemy.skyAffinity < target.skyAffinity) {
                    target = enemy;
                }
            }
            return target;
            break;
        case kRage:
            for (AbstractBattleEnemy *enemy in battleEnemies) {
                if (enemy.rageAffinity < target.rageAffinity) {
                    target = enemy;
                }
            }
            return target;
            break;
        case kLife:
            for (AbstractBattleEnemy *enemy in battleEnemies) {
                if (enemy.lifeAffinity < target.lifeAffinity) {
                    target = enemy;
                }
            }
            return target;
            break;
        case kFire:
            for (AbstractBattleEnemy *enemy in battleEnemies) {
                if (enemy.fireAffinity < target.fireAffinity) {
                    target = enemy;
                }
            }
            return target;
            break;
        case kStone:
            for (AbstractBattleEnemy *enemy in battleEnemies) {
                if (enemy.stoneAffinity < target.stoneAffinity) {
                    target = enemy;
                }
            }
            return target;
            break;
        case kWood:
            for (AbstractBattleEnemy *enemy in battleEnemies) {
                if (enemy.woodAffinity < target.woodAffinity) {
                    target = enemy;
                }
            }
            return target;
            break;
        case kPoison:
            for (AbstractBattleEnemy *enemy in battleEnemies) {
                if (enemy.poisonAffinity < target.poisonAffinity) {
                    target = enemy;
                }
            }
            return target;
            break;
        case kDivine:
            for (AbstractBattleEnemy *enemy in battleEnemies) {
                if (enemy.divineAffinity < target.divineAffinity) {
                    target = enemy;
                }
            }
            return target;
            break;
        case kDeath:
            for (AbstractBattleEnemy *enemy in battleEnemies) {
                if (enemy.deathAffinity < target.deathAffinity) {
                    target = enemy;
                }
            }
            return target;
            break;
        default:
            break;
    }
    return nil;
}

- (AbstractBattleEnemy *)needsElementalAttack:(int)aElement {
    
    AbstractBattleEnemy *target = [battleEnemies objectAtIndex:0];
    switch (aElement) {
        case kWater:
            for (AbstractBattleEnemy *enemy in battleEnemies) {
                if (enemy.waterAffinity < target.waterAffinity) {
                    target = enemy;
                }
            }
            return target;
            break;
        case kSky:
            for (AbstractBattleEnemy *enemy in battleEnemies) {
                if (enemy.skyAffinity < target.skyAffinity) {
                    target = enemy;
                }
            }
            return target;
            break;
        case kRage:
            for (AbstractBattleEnemy *enemy in battleEnemies) {
                if (enemy.rageAffinity < target.rageAffinity) {
                    target = enemy;
                }
            }
            return target;
            break;
        case kLife:
            for (AbstractBattleEnemy *enemy in battleEnemies) {
                if (enemy.lifeAffinity < target.lifeAffinity) {
                    target = enemy;
                }
            }
            return target;
            break;
        case kFire:
            for (AbstractBattleEnemy *enemy in battleEnemies) {
                if (enemy.fireAffinity < target.fireAffinity) {
                    target = enemy;
                }
            }
            return target;
            break;
        case kStone:
            for (AbstractBattleEnemy *enemy in battleEnemies) {
                if (enemy.stoneAffinity < target.stoneAffinity) {
                    target = enemy;
                }
            }
            return target;
            break;
        case kWood:
            for (AbstractBattleEnemy *enemy in battleEnemies) {
                if (enemy.woodAffinity < target.woodAffinity) {
                    target = enemy;
                }
            }
            return target;
            break;
        case kPoison:
            for (AbstractBattleEnemy *enemy in battleEnemies) {
                if (enemy.poisonAffinity < target.poisonAffinity) {
                    target = enemy;
                }
            }
            return target;
            break;
        case kDivine:
            for (AbstractBattleEnemy *enemy in battleEnemies) {
                if (enemy.divineAffinity < target.divineAffinity) {
                    target = enemy;
                }
            }
            return target;
            break;
        case kDeath:
            for (AbstractBattleEnemy *enemy in battleEnemies) {
                if (enemy.deathAffinity < target.deathAffinity) {
                    target = enemy;
                }
            }
            return target;
            break;
        default:
            break;
    }
    return nil;
}

- (AbstractBattleEnemy *)notMotivated {
    
    AbstractBattleEnemy *target = [battleEnemies objectAtIndex:0];
    if (!target.isMotivated) {
        return target;
    } else {
        for (AbstractBattleEnemy *enemy in battleEnemies) {
            if (!enemy.isMotivated) {
                return enemy;
            }
        }
    }
    return nil;
}

- (AbstractBattleEnemy *)notAuraed {
    
    AbstractBattleEnemy *target = [battleEnemies objectAtIndex:0];
    if (!target.isAuraed) {
        return target;
    } else {
        for (AbstractBattleEnemy *enemy in battleEnemies) {
            if (!enemy.isAuraed) {
                return enemy;
            }
        }
    }
    return nil;
}

- (AbstractBattleCharacter *)anyCharacter {
    int x = arc4random() % [battleCharacters count];
    //NSLog(@"%d", x);
    return [battleCharacters objectAtIndex:arc4random() % [battleCharacters count]];
}

- (AbstractBattleCharacter *)characterWithLowestHP {
    
    AbstractBattleCharacter *target = [battleCharacters objectAtIndex:0];
    for (AbstractBattleCharacter *character in battleCharacters) {
        if (character.hp < target.hp) {
            target = character;
        }
    }
    //NSLog(@"Character with lowest hp is: %d", target.whichCharacter);
    return target;
}

- (AbstractBattleCharacter *)characterWithHighestHP {
    
    AbstractBattleCharacter *target = [battleCharacters objectAtIndex:0];
    for (AbstractBattleCharacter *character in battleCharacters) {
        if (character.hp > target.hp) {
            target = character;
        }
    }
    return target;
}

- (AbstractBattleCharacter *)characterWithLowestStat:(int)aStat {
    
    AbstractBattleCharacter *target = [battleCharacters objectAtIndex:0];
    switch (aStat) {
        case kLevel:
            for (AbstractBattleCharacter *character in battleCharacters) {
                if (character.level + character.levelModifier < target.level + target.levelModifier) {
                    target = character;
                }
            }
            return target;
            break;
        case kStrength:
            for (AbstractBattleCharacter *character in battleCharacters) {
                if (character.strength + character.strengthModifier < target.strength + target.strengthModifier) {
                    target = character;
                }
            }
            return target;
            break;
        case kStamina:
            for (AbstractBattleCharacter *character in battleCharacters) {
                if (character.stamina + character.staminaModifier < target.stamina + target.staminaModifier) {
                    target = character;
                }
            }
            return target;
            break;
        case kAgility:
            for (AbstractBattleCharacter *character in battleCharacters) {
                if (character.agility + character.agilityModifier < target.agility + target.agilityModifier) {
                    target = character;
                }
            }
            return target;
            break;
        case kDexterity:
            for (AbstractBattleCharacter *character in battleCharacters) {
                if (character.dexterity + character.dexterityModifier < target.dexterity + target.dexterityModifier) {
                    target = character;
                }
            }
            return target;
            break;
        case kPower:
            for (AbstractBattleCharacter *character in battleCharacters) {
                if (character.power + character.powerModifier < target.power + target.powerModifier) {
                    target = character;
                }
            }
            return target;
            break;
        case kAffinity:
            for (AbstractBattleCharacter *character in battleCharacters) {
                if (character.affinity + character.affinityModifier < target.affinity + target.affinityModifier) {
                    target = character;
                }
            }
            return target;
            break;
        case kLuck:
            for (AbstractBattleCharacter *character in battleCharacters) {
                if (character.luck + character.luckModifier < target.luck + target.luckModifier) {
                    target = character;
                }
            }
            return target;
            break;
        default:
            break;
    }
    return nil;
}

- (AbstractBattleCharacter *)characterWithHighestStat:(int)aStat {
    
    AbstractBattleCharacter *target = [battleCharacters objectAtIndex:0];
    switch (aStat) {
        case kLevel:
            for (AbstractBattleCharacter *character in battleCharacters) {
                if (character.level + character.levelModifier < target.level + target.levelModifier) {
                    target = character;
                }
            }
            return target;
            break;
        case kStrength:
            for (AbstractBattleCharacter *character in battleCharacters) {
                if (character.strength + character.strengthModifier < target.strength + target.strengthModifier) {
                    target = character;
                }
            }
            return target;
            break;
        case kStamina:
            for (AbstractBattleCharacter *character in battleCharacters) {
                if (character.stamina + character.staminaModifier < target.stamina + target.staminaModifier) {
                    target = character;
                }
            }
            return target;
            break;
        case kAgility:
            for (AbstractBattleCharacter *character in battleCharacters) {
                if (character.agility + character.agilityModifier < target.agility + target.agilityModifier) {
                    target = character;
                }
            }
            return target;
            break;
        case kDexterity:
            for (AbstractBattleCharacter *character in battleCharacters) {
                if (character.dexterity + character.dexterityModifier < target.dexterity + target.dexterityModifier) {
                    target = character;
                }
            }
            return target;
            break;
        case kPower:
            for (AbstractBattleCharacter *character in battleCharacters) {
                if (character.power + character.powerModifier < target.power + target.powerModifier) {
                    target = character;
                }
            }
            return target;
            break;
        case kAffinity:
            for (AbstractBattleCharacter *character in battleCharacters) {
                if (character.affinity + character.affinityModifier < target.affinity + target.affinityModifier) {
                    target = character;
                }
            }
            return target;
            break;
        case kLuck:
            for (AbstractBattleCharacter *character in battleCharacters) {
                if (character.luck + character.luckModifier < target.luck + target.luckModifier) {
                    target = character;
                }
            }
            return target;
            break;
        default:
            break;
    }
    return nil;
}

- (AbstractBattleCharacter *)characterWithHighestEssence {
    
    AbstractBattleCharacter *target = [battleCharacters objectAtIndex:0];
    for (AbstractBattleCharacter *character in battleCharacters) {
        if (character.essence > target.essence) {
            target = character;
        }
    }
    return target;
}

- (AbstractBattleCharacter *)characterWithLowestEssence {
    
    AbstractBattleCharacter *target = [battleCharacters objectAtIndex:0];
    for (AbstractBattleCharacter *character in battleCharacters) {
        if (character.essence < target.essence) {
            target = character;
        }
    }
    return target;
}

- (AbstractBattleCharacter *)characterWithLowestEndurance {
    
    AbstractBattleCharacter *target = [battleCharacters objectAtIndex:0];
    for (AbstractBattleCharacter *character in battleCharacters) {
        if (character.endurance < target.endurance) {
            target = character;
        }
    }
    return target;
}

- (AbstractBattleCharacter *)characterWithHighestEndurance {
    
    AbstractBattleCharacter *target = [battleCharacters objectAtIndex:0];
    for (AbstractBattleCharacter *character in battleCharacters) {
        if (character.endurance > target.endurance) {
            target = character;
        }
    }
    return target;
}

- (AbstractBattleCharacter *)characterWithHPAbovePercent:(float)aPercent {
    
    AbstractBattleCharacter *target = [self characterWithHighestHP];
    if (target.hp / target.maxHP * 100 > aPercent) {
        return target;
    }
    return nil;
    
}

- (AbstractBattleCharacter *)characterWithEssenceAbovePercent:(float)aPercent {
    
    AbstractBattleCharacter *target = [self characterWithHighestEssence];
    if (target.essence / target.maxEssence * 100 > aPercent) {
        return target;
    }
    return nil;
}

- (AbstractBattleCharacter *)characterWithEnduranceAbovePercent:(float)aPercent {
    
    AbstractBattleCharacter *target = [self characterWithHighestEndurance];
    if (target.essence / target.maxEssence * 100 > aPercent) {
        return target;
    }
    return nil;
}

- (AbstractBattleCharacter *)characterWithHPBelowPercent:(float)aPercent {
    
    AbstractBattleCharacter *target = [self characterWithLowestHP];
    if (target.hp / target.maxHP * 100 < aPercent) {
        //NSLog(@"Character has hp below 50 percent, and character is %d.", target.whichCharacter);
        return target;
    }
    return nil;
}

- (AbstractBattleCharacter *)characterWithEssenceBelowPercent:(float)aPercent {
    
    AbstractBattleCharacter *target = [self characterWithLowestEssence];
    if (target.essence / target.maxEssence * 100 < aPercent) {
        return target;
    }
    return nil;
}

- (AbstractBattleCharacter *)characterWithEnduranceBelowPercent:(float)aPercent {
    
    AbstractBattleCharacter *target = [self characterWithLowestEndurance];
    if (target.endurance / target.maxEndurance * 100 < aPercent) {
        return target;
    }
    return nil;
}

- (AbstractBattleCharacter *)auraedCharacter {
    
    AbstractBattleCharacter *target = [self characterWithHighestEssence];
    if (target.isAuraed) {
        return target;
    } else {
        for (AbstractBattleCharacter *character in battleCharacters) {
            if (character.isAuraed) {
                return character;
            }
        }
    }
    return nil;
}

- (AbstractBattleCharacter *)motivatedCharacter {
    
    AbstractBattleCharacter *target = [self characterWithHighestEndurance];
    if (target.isMotivated) {
        return target;
    } else {
        for (AbstractBattleCharacter *character in battleCharacters) {
            if (character.isMotivated) {
                return character;
            }
        }
    }
    return nil;
}

- (AbstractBattleCharacter *)fatiguedCharacter {
    
    AbstractBattleCharacter *target = [self characterWithLowestEndurance];
    if (target.isFatigued) {
        return target;
    } else {
        for (AbstractBattleCharacter *character in battleCharacters) {
            if (character.isFatigued) {
                return character;
            }
        }
    }
    return nil;
}

- (AbstractBattleCharacter *)drauraedCharacter {
    
    AbstractBattleCharacter *target = [self characterWithLowestEssence];
    if (target.isDrauraed) {
        return target;
    } else {
        for (AbstractBattleCharacter *character in battleCharacters) {
            if (character.isDrauraed) {
                return character;
            }
        }
    }
    return nil;
}

- (AbstractBattleCharacter *)slothedCharacter {
    
    AbstractBattleCharacter *target = [self characterWithLowestEndurance];
    if (target.isSlothed) {
        return target;
    } else {
        for (AbstractBattleCharacter *character in battleCharacters) {
            if (character.isSlothed) {
                return character;
            }
        }
    }
    return nil;
}

- (AbstractBattleCharacter *)hexedCharacter {
    
    AbstractBattleCharacter *target = [self characterWithLowestEssence];
    if (target.isHexed) {
        return target;
    } else {
        for (AbstractBattleCharacter *character in battleCharacters) {
            if (character.isHexed) {
                return character;
            }
        }
    }
    return nil;
}

- (AbstractBattleCharacter *)disorientedCharacter {
    
    AbstractBattleCharacter *target = [self characterWithLowestStat:kAgility];
    if (target.isDisoriented) {
        return target;
    } else {
        for (AbstractBattleCharacter *character in battleCharacters) {
            if (character.isDisoriented) {
                return character;
            }
        }
    }
    return nil;
}

- (AbstractBattleCharacter *)characterWithLowestElementalAffinity:(int)aElement {
    
    AbstractBattleCharacter *target = [battleCharacters objectAtIndex:0];
    switch (aElement) {
        case kWater:
            for (AbstractBattleCharacter *character in battleCharacters) {
                if (character.waterAffinity < target.waterAffinity) {
                    target = character;
                }
            }
            return target;
            break;
        case kSky:
            for (AbstractBattleCharacter *character in battleCharacters) {
                if (character.skyAffinity < target.skyAffinity) {
                    target = character;
                }
            }
            return target;
            break;
        case kRage:
            for (AbstractBattleCharacter *character in battleCharacters) {
                if (character.rageAffinity < target.rageAffinity) {
                    target = character;
                }
            }
            return target;
            break;
        case kLife:
            for (AbstractBattleCharacter *character in battleCharacters) {
                if (character.lifeAffinity < target.lifeAffinity) {
                    target = character;
                }
            }
            return target;
            break;
        case kFire:
            for (AbstractBattleCharacter *character in battleCharacters) {
                if (character.fireAffinity < target.fireAffinity) {
                    target = character;
                }
            }
            return target;
            break;
        case kStone:
            for (AbstractBattleCharacter *character in battleCharacters) {
                if (character.stoneAffinity < target.stoneAffinity) {
                    target = character;
                }
            }
            return target;
            break;
        case kWood:
            for (AbstractBattleCharacter *character in battleCharacters) {
                if (character.woodAffinity < target.woodAffinity) {
                    target = character;
                }
            }
            return target;
            break;
        case kPoison:
            for (AbstractBattleCharacter *character in battleCharacters) {
                if (character.poisonAffinity < target.poisonAffinity) {
                    target = character;
                }
            }
            return target;
            break;
        case kDivine:
            for (AbstractBattleCharacter *character in battleCharacters) {
                if (character.divineAffinity < target.divineAffinity) {
                    target = character;
                }
            }
            return target;
            break;
        case kDeath:
            for (AbstractBattleCharacter *character in battleCharacters) {
                if (character.deathAffinity < target.deathAffinity) {
                    target = character;
                }
            }
            return target;
            break;
        default:
            break;
    }
    return nil;
}

- (AbstractBattleCharacter *)characterWithHighestElementalAffinity:(int)aElement {
    
    AbstractBattleCharacter *target = [battleCharacters objectAtIndex:0];
    switch (aElement) {
        case kWater:
            for (AbstractBattleCharacter *character in battleCharacters) {
                if (character.waterAffinity > target.waterAffinity) {
                    target = character;
                }
            }
            return target;
            break;
        case kSky:
            for (AbstractBattleCharacter *character in battleCharacters) {
                if (character.skyAffinity > target.skyAffinity) {
                    target = character;
                }
            }
            return target;
            break;
        case kRage:
            for (AbstractBattleCharacter *character in battleCharacters) {
                if (character.rageAffinity > target.rageAffinity) {
                    target = character;
                }
            }
            return target;
            break;
        case kLife:
            for (AbstractBattleCharacter *character in battleCharacters) {
                if (character.lifeAffinity > target.lifeAffinity) {
                    target = character;
                }
            }
            return target;
            break;
        case kFire:
            for (AbstractBattleCharacter *character in battleCharacters) {
                if (character.fireAffinity > target.fireAffinity) {
                    target = character;
                }
            }
            return target;
            break;
        case kStone:
            for (AbstractBattleCharacter *character in battleCharacters) {
                if (character.stoneAffinity > target.stoneAffinity) {
                    target = character;
                }
            }
            return target;
            break;
        case kWood:
            for (AbstractBattleCharacter *character in battleCharacters) {
                if (character.woodAffinity > target.woodAffinity) {
                    target = character;
                }
            }
            return target;
            break;
        case kPoison:
            for (AbstractBattleCharacter *character in battleCharacters) {
                if (character.poisonAffinity > target.poisonAffinity) {
                    target = character;
                }
            }
            return target;
            break;
        case kDivine:
            for (AbstractBattleCharacter *character in battleCharacters) {
                if (character.divineAffinity > target.divineAffinity) {
                    target = character;
                }
            }
            return target;
            break;
        case kDeath:
            for (AbstractBattleCharacter *character in battleCharacters) {
                if (character.deathAffinity > target.deathAffinity) {
                    target = character;
                }
            }
            return target;
            break;
        default:
            break;
    }
    return nil;
}

// Enemy Physical attacks

- (void)enemy:(AbstractBattleEnemy *)aEnemy smashes:(AbstractBattleCharacter *)aCharacter {
    
    EnemySmash *smash = [[EnemySmash alloc] initFromEnemy:aEnemy toCharacter:aCharacter];
    [sharedGameController.currentScene addObjectToActiveObjects:smash];
    [smash release];
}

- (void)enemy:(AbstractBattleEnemy *)aEnemy bites:(AbstractBattleCharacter *)aCharacter {
    
    EnemyBite *bite = [[EnemyBite alloc] initFromEnemy:aEnemy toCharacter:aCharacter];
    [sharedGameController.currentScene addObjectToActiveObjects:bite];
    [bite release];
}

- (void)enemy:(AbstractBattleEnemy *)aEnemy arrows:(AbstractBattleCharacter *)aCharacter {
    
    [EnemyArrow enemy:aEnemy arrows:aCharacter];
}

- (void)enemy:(AbstractBattleEnemy *)aEnemy slashes:(AbstractBattleCharacter *)aCharacter {
    
    EnemySlash *slash = [[EnemySlash alloc] initFromEnemy:aEnemy toCharacter:aCharacter];
    [sharedGameController.currentScene addObjectToActiveObjects:slash];
    [slash release];
}

// Enemy magical attacks

- (void)enemy:(AbstractBattleEnemy *)aEnemy energyBalls:(AbstractBattleCharacter *)aCharacter {
    
    EnemyEnergyBall *energyBall = [[EnemyEnergyBall alloc] initFromEnemy:aEnemy toCharacter:aCharacter];
    [sharedGameController.currentScene addObjectToActiveObjects:energyBall];
    [energyBall release];
}

- (void)enemy:(AbstractBattleEnemy *)aEnemy fires:(AbstractBattleCharacter *)aCharacter {
    
    EnemyFire *fire = [[EnemyFire alloc] initFromEnemy:aEnemy toCharacter:aCharacter];
    [sharedGameController.currentScene addObjectToActiveObjects:fire];
    [fire release];
}

- (void)enemyFiresAllCharacters:(AbstractBattleEnemy *)aEnemy {
    
    EnemyFireAllCharacters *efac = [[EnemyFireAllCharacters alloc] initFromEnemy:aEnemy];
    [sharedGameController.currentScene addObjectToActiveObjects:efac];
    [efac release];
}

- (void)enemy:(AbstractBattleEnemy *)aEnemy poisons:(AbstractBattleCharacter *)aCharacter {
    
    EnemyPoison *poison = [[EnemyPoison alloc] initFromEnemy:aEnemy toCharacter:aCharacter];
    [sharedGameController.currentScene addObjectToActiveObjects:poison];
    [poison release];
}

- (void)enemyPoisonsAllCharacters:(AbstractBattleEnemy *)aEnemy {
    
    EnemyPoisonAllCharacters *epac = [[EnemyPoisonAllCharacters alloc] initFromEnemy:aEnemy];
    [sharedGameController.currentScene addObjectToActiveObjects:epac];
    [epac release];
}

- (void)enemyWatersAllCharacters:(AbstractBattleEnemy *)aEnemy {
    
    EnemyWaterAllCharacters *ewac = [[EnemyWaterAllCharacters alloc] initFromEnemy:aEnemy];
    [sharedGameController.currentScene addObjectToActiveObjects:ewac];
    [ewac release];
}

- (void)enemy:(AbstractBattleEnemy *)aEnemy waters:(AbstractBattleCharacter *)aCharacter {
    
    EnemyWater *water = [[EnemyWater alloc] initFromEnemy:aEnemy toCharacter:aCharacter];
    [sharedGameController.currentScene addObjectToActiveObjects:water];
    [water release];
}

- (void)enemy:(AbstractBattleEnemy *)aEnemy rages:(AbstractBattleCharacter *)aCharacter {
    
    EnemyRage *rage = [[EnemyRage alloc] initFromEnemy:aEnemy toCharacter:aCharacter];
    [sharedGameController.currentScene addObjectToActiveObjects:rage];
    [rage release];
}

- (void)enemyRagesAllCharacters:(AbstractBattleEnemy *)aEnemy {
    
    EnemyRageAllCharacters *rac = [[EnemyRageAllCharacters alloc] initFromEnemy:aEnemy];
    [sharedGameController.currentScene addObjectToActiveObjects:rac];
    [rac release];
}

// Enemy effects on enemies

- (void)enemy:(AbstractBattleEnemy *)aEnemy heals:(AbstractBattleEnemy *)aTarget {
    
    if (aEnemy) {
        NSLog(@"Enemy.");
    }
    if (aTarget) {
        NSLog(@"Target.");
    }
    [aTarget youWereHealed:[aEnemy calculateHealAmountTo:aTarget]];
}

- (void)enemyCuresFatigue:(AbstractBattleEnemy *)aEnemy {
    
    EnemyFatigueCure *fatigueCure = [[EnemyFatigueCure alloc] initToEnemy:aEnemy];
    [sharedGameController.currentScene addObjectToActiveObjects:fatigueCure];
    [fatigueCure release];
}

- (void)enemy:(AbstractBattleEnemy *)aEnemy healsNegativeStatusEffectOn:(AbstractBattleEnemy *)aTarget {
    
    EnemyHealNegativeStatus *statusCure = [[EnemyHealNegativeStatus alloc] initToEnemy:aTarget];
    [sharedGameController.currentScene addObjectToActiveObjects:statusCure];
    [statusCure release];
}

- (void)enemy:(AbstractBattleEnemy *)aEnemy healsBleedersOn:(AbstractBattleEnemy *)aTarget {
    
    EnemyHealBleeders *healBleeders = [[EnemyHealBleeders alloc] initToEnemy:aEnemy];
    [sharedGameController.currentScene addObjectToActiveObjects:healBleeders];
    [healBleeders release];
}

- (void)removeCharacter:(AbstractBattleCharacter *)aCharacter {
    
    [battleCharacters removeObject:aCharacter];
    if ([battleCharacters count] == 0) {
        [[GameController sharedGameController].currentScene partyHasBeenDefeated];
    }
}

- (void)removeEnemy:(AbstractBattleEnemy *)aEnemy {
    
    [battleEnemies removeObject:aEnemy];
}

@end

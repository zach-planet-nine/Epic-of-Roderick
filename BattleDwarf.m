//
//  BattleDwarf.m
//  TEORBattleTest
//
//  Created by Zach Babb on 5/25/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "BattleDwarf.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleEnemy.h"
#import "OverMind.h"
#import "BattleValkyrie.h"
#import "BattlePriest.h"
#import "PackedSpriteSheet.h"
#import "Image.h"
#import "Bleeder.h"
#import "Animation.h"
#import "FirstDwarfAxerang.h"
#import "Global.h"
#import "Dwarfapult.h"
#import "BuyARound.h"
#import "FinishingMove.h"
#import "Boobytrap.h"
#import "SuperAxerang.h"
#import "Motivate.h"
#import "Bombulus.h"


@implementation BattleDwarf

- (id)initWithBattleLocation:(int)aLocation {
	
	if (self = [super init]) {
		
		Image *dwarf = [sharedGameController.teorPSS imageForKey:@"Dwarf50x80.png"];
		currentTurnAnimation = [[Animation alloc] init];
		[currentTurnAnimation addFrameWithImage:dwarf delay:0.3];
		currentTurnAnimation.state = kAnimationState_Stopped;
		[dwarf release];
		currentAnimation = currentTurnAnimation;
		battleLocation = aLocation;
		whichCharacter = kDwarf;
		[super initBattleAttributes];
		switch (battleLocation) {
			case 0:
				rect = CGRectMake(20, 240, 60, 120);
				renderPoint = CGPointMake(45, 300);
				break;
			case 1:
				rect = CGRectMake(20, 120, 60, 120);
				renderPoint = CGPointMake(45, 180);
				break;
			case 2:
				rect = CGRectMake(20, 0, 60, 120);
				renderPoint = CGPointMake(45, 60);
				break;
			default:
				break;
		}
        int index = 0;
        while (index < 8) {
            ai[index] = EnemyAISet(kAIEnduranceAmount, 10, kAIAnyEnemy, 0, kAIDoNothing);
            index++;
        }
		selectorImage.renderPoint = CGPointMake(renderPoint.x, renderPoint.y - 40);
		totalDrinks = 0;
		essenceColor = Color4fMake(0.6, 0.2, 0.0, 1.0);
        sharedOverMind = [OverMind sharedOverMind];
	}
	
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	[super updateWithDelta:aDelta];
    decisionTimer -= aDelta;
    if (decisionTimer < 0) {
      //  NSLog(@"Dwarf deciding.");
        [self decideWhatToDo];
        decisionTimer = 3;
    }
    //NSLog(@"Threshold for decision is: %d", ai[3].threshold);
}

- (void)decideWhatToDo {
    int index = 0;
    while (index < 8) {
        if (ai[index].ability != kAIDoNothing) {
            if ([self canIDoThis:index]) {
                [self doThis:ai[index]];
                return;
            }
        }
        index++;
    }
}

- (BOOL)canIDoThis:(int)aDecisionIndex {
    //NSLog(@"Threshold is: %d for decision: %d", ai[aDecisionIndex].threshold, ai[aDecisionIndex].ability);
    if (ai[aDecisionIndex].threshold > 0) {
        ai[aDecisionIndex] = EnemyAISet(ai[aDecisionIndex].stat, ai[aDecisionIndex].threshold - 1, ai[aDecisionIndex].decider, ai[aDecisionIndex].parameter, ai[aDecisionIndex].ability);
      //  NSLog(@"Should not do a dwarfapult.");
        return NO;
    }
    //NSLog(@"Should do a dwarfapult.");
    if (ai[aDecisionIndex].ability == kAIFinishingMove) {
        if ([sharedOverMind enemyWithHPBelowPercent:ai[aDecisionIndex].parameter] == nil) {
            if (arc4random() % 100 > 100 - luck - luckModifier) {
                NSLog(@"It's the random jobber.");
                return YES;
            }
            return NO;
        }
    }
    if (ai[aDecisionIndex].ability == kAIBoobyTrap) {
        AbstractBattleEnemy *enemy = [sharedOverMind anyEnemy];
        if (enemy.boobytrapped) {
            return NO;
        }
    }
    return YES;
}

- (void)doThis:(EnemyAI)aDecision {
    switch (aDecision.ability) {
        case kAIDwarfapult:
      //      NSLog(@"Dwarfapult executed.");
            aDecision.ability = kAIDwarfapult;
            Dwarfapult *dwarfapult = [[Dwarfapult alloc] initToEnemy:[sharedOverMind enemyWithLowestHP]];
            [sharedGameController.currentScene addObjectToActiveObjects:dwarfapult];
            [dwarfapult release];
            ai[3] = EnemyAISet(kAIEssenceAmount, 5, kAIEnemyWithLowestHP, 0, kAIDwarfapult);
        //    NSLog(@"Threshold is: %d for decision: %d", aDecision.threshold, aDecision.ability);
            break;
        case kAIBuyARound:
            aDecision.ability = kAIBuyARound;
            [BuyARound buyARound];
            ai[0] = EnemyAISet(kAIEssenceAmount, 4, kAIAllCharacters, 0, kAIBuyARound);
            break;
        case kAIFinishingMove:
            aDecision.ability = kAIFinishingMove;
            AbstractBattleEnemy *finishEnemy;
            if ([sharedOverMind enemyWithHPBelowPercent:aDecision.parameter]) {
                finishEnemy = [sharedOverMind enemyWithHPBelowPercent:aDecision.parameter];
            } else {
                finishEnemy = [sharedOverMind anyEnemy];
            }
            FinishingMove *finishingMove = [[FinishingMove alloc] initToEnemy:finishEnemy];
            [sharedGameController.currentScene addObjectToActiveObjects:finishingMove];
            [finishingMove release];
            ai[1] = EnemyAISet(kAIEssenceAmount, 8, kAIEnemyWithHPBelowPercent, 10, kAIFinishingMove);
            break;
        case kAIBoobyTrap:
            aDecision.ability = kAIBoobyTrap;
            AbstractBattleEnemy *enemy = [sharedOverMind anyEnemy];
            if (enemy.boobytrapped) {
                return;
            }
            Boobytrap *bt = [[Boobytrap alloc] initToEnemy:enemy];
            [sharedGameController.currentScene addObjectToActiveObjects:bt];
            [bt release];
            ai[2] = EnemyAISet(kAIEssenceAmount, 6, kAIAnyEnemy, 0, kAIBoobyTrap);
            break;
        case kAISuperAxerang:
            aDecision.ability = kAISuperAxerang;
            SuperAxerang *sa = [[SuperAxerang alloc] init];
            [sharedGameController.currentScene addObjectToActiveObjects:sa];
            [sa release];
            ai[4] = EnemyAISet(kAIEssenceAmount, 8, kAIAnyEnemy, 0, kAISuperAxerang);
            break;
        case kAIMotivate:
            aDecision.ability = kAIMotivate;
            Motivate *mot = [[Motivate alloc] init];
            [sharedGameController.currentScene addObjectToActiveObjects:mot];
            [mot release];
            ai[5] = EnemyAISet(kAIEssenceAmount, 12, kAIAllCharacters, 0, kAIMotivate);
            break;
        case kAIBombulus:
            aDecision.ability = kAIBombulus;
            Bombulus *bomb = [[Bombulus alloc] initToEnemy:[sharedOverMind anyEnemy]];
            [sharedGameController.currentScene addObjectToActiveObjects:bomb];
            [bomb release];
            ai[6] = EnemyAISet(kAIEssenceAmount, 7, kAIAnyEnemy, 0, kAIBombulus);
            break;
        default:
            break;
    }
}

- (void)initBattleAttributes {
    [super initBattleAttributes];
    int index = 0;
    while (index < 8) {
        ai[index] = EnemyAISet(kAIEnduranceAmount, 10, kAIAnyEnemy, 0, kAIDoNothing);
        index++;
    }
}

- (void)resetBattleTimer {
	
	battleTimer = 0.0;
	currentTurn = NO;
}

- (void)queueRune:(int)aRune {
	
	[super queueRune:aRune];
	[sharedInputManager setState:kDwarf];
}

- (void)youAttackedEnemy:(AbstractBattleEnemy *)aEnemy {

    for (int i = 0; i < numberOfAttacks; i++) {
        if (waterAttack > 0) {
            //implementation
        }
        if (skyAttack > 0) {
            //implementation
        }
        if (fireAttack > 0) {
            //implementation
        }
        if (stoneAttack > 0) {
            //implementation
        }
        if (lifeAttack > 0) {
            //implementation
        }
        if (rageAttack > 0) {
            //implementation
        }
        if (woodAttack > 0) {
            //implementation
        }
        if (poisonAttack > 0) {
            //implementation
        }
        if (deathAttack > 0) {
            //implementation
        }
        if (divineAttack > 0) {
            //implementation
        }
        if (fatigueAttack) {
            //implementation
        }
        if (drauraAttack) {
            //implementation
        }
        if (disorientedAttack) {
            //implementation
        }
        if (hexAttack) {
            //implementation
        }
        if (slothAttack) {
            //implementation
        }
        if (doubleAttack > 0) {
            FirstDwarfAxerang *fda = [[FirstDwarfAxerang alloc] initToEnemy:aEnemy];
            [sharedGameController.currentScene addObjectToActiveObjects:fda];
            [fda release];
            doubleAttack--;
        }
        if (attackAttacksAllEnemies) {
            for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
                if ([enemy isKindOfClass:[AbstractBattleEnemy class]] && enemy.isAlive && enemy != aEnemy) {
                    //Maybe make a fresh object here that's the same for everyone.
                    FirstDwarfAxerang *extraAttack = [[FirstDwarfAxerang alloc] initToEnemy:enemy waiting:0.3];
                    [sharedGameController.currentScene addObjectToActiveObjects:extraAttack];
                    [extraAttack release];
                }
            }
        }
        if (damageEssence) {
            //implementation
        }
        if (attacksCauseBleeders) {
            [Bleeder addBleederTo:aEnemy withDuration:(3 + ((level + levelModifier) / 3)) * (endurance / maxEndurance)];
        }
        if (attackEnhancesFavor) {
            float roll = RANDOM_0_TO_1() * 100;
            BattlePriest *poet = [sharedGameController.battleCharacters objectForKey:@"BattlePriest"];
            if (roll < 20) {
                poet.odinFavor += 0.05;
            }
            if (20 <= roll && roll < 40) {
                poet.thorFavor += 0.05;
            }
            if (40 <= roll && roll < 60) {
                poet.tyrFavor += 0.05;
            }
            if (60 <= roll && roll < 80) {
                poet.freyaFavor += 0.05;
            }
            if (80 <= roll) {
                poet.friggFavor += 0.05;
            }
        }
        if (attacksAddToRageMeter) {
            BattleValkyrie *valk = [sharedGameController.battleCharacters objectForKey:@"BattleValkyrie"];
            valk.rageMeter += 1;
        }
        if (attacksAddToStatusTimers) {
            [aEnemy addToStatusDurations:1];
        }
        
        FirstDwarfAxerang *fda = [[FirstDwarfAxerang alloc] initToEnemy:aEnemy];
        [sharedGameController.currentScene addObjectToActiveObjects:fda];
        [fda release];

    }
	    
    int enduranceLost = 9 + (level * 0.2);
    
    if (enduranceDoesNotDeplete) {
        enduranceLost = 0;
    }
    if (halfEnduranceExpenditure) {
        enduranceLost /= 2;
    }
    endurance -= enduranceLost;

}

- (void)youOrderedADrink:(int)aDrink {
	
    NSLog(@"Is this getting called a bunch?");
	//Play dwarf drinking animation here.
	switch (aDrink) {
		case 93:
			ai[3] = EnemyAISet(kAIEssenceAmount, 0, kAIEnemyWithHighestHP, 0, kAIDwarfapult);
			totalDrinks++;
			break;
        case 37:
            ai[0] = EnemyAISet(kAIEssenceAmount, 0, kAIAllCharacters, 0, kAIBuyARound);
            totalDrinks++;
            break;
        case 36:
            ai[1] = EnemyAISet(kAIEssenceAmount, 0, kAIEnemyWithHPBelowPercent, 10, kAIFinishingMove);
            totalDrinks++;
            break;
        case 166:
            ai[2] = EnemyAISet(kAIEssenceAmount, 0, kAIAnyEnemy, 0, kAIBoobyTrap);
            totalDrinks++;
            break;
        case 132:
            ai[4] = EnemyAISet(kAIEssenceAmount, 0, kAIAnyEnemy, 0, kAISuperAxerang);
            totalDrinks++;
            break;
        case 145:
            ai[5] = EnemyAISet(kAIEssenceAmount, 0, kAIAllCharacters, 0, kAIMotivate);
            totalDrinks++;
            break;
        case 50:
            ai[6] = EnemyAISet(kAIEssenceAmount, 0, kAIAnyEnemy, 0, kAIBombulus);
            totalDrinks++;
            break;
		default:
			break;
	}
}

- (void)battleLocationIs:(int)aLocation {
    [super battleLocationIs:aLocation];
    essenceMeter.renderPoint = CGPointMake(1000, 1000);
    essenceMeterImage.renderPoint = CGPointMake(1000, 1000);
}

- (int)calculateAttackDamageTo:(AbstractBattleEnemy *)aEnemy {
    
    float tempDamage = ((strength + strengthModifier) * 5) - (aEnemy.stamina + aEnemy.staminaModifier);
    if (waterAttackEquipped) {
        tempDamage *= waterAffinity / aEnemy.waterAffinity;
    }
    if (skyAttackEquipped) {
        tempDamage *= skyAffinity / aEnemy.skyAffinity;
    }
    if (rageAttackEquipped) {
        tempDamage *= rageAffinity / aEnemy.rageAffinity;
    }
    if (lifeAttackEquipped) {
        tempDamage *= lifeAffinity / aEnemy.lifeAffinity;
    }
    if (fireAttackEquipped) {
        tempDamage *= fireAffinity / aEnemy.fireAffinity;
    }
    if (stoneAttackEquipped) {
        tempDamage *= stoneAffinity / aEnemy.stoneAffinity;
    }
    if (woodAttackEquipped) {
        tempDamage *= woodAffinity / aEnemy.woodAffinity;
    }
    if (poisonAttackEquipped) {
        tempDamage *= poisonAffinity / aEnemy.poisonAffinity;
    }
    if (divineAttackEquipped) {
        tempDamage *= divineAffinity / aEnemy.divineAffinity;
    }
    if (deathAttackEquipped) {
        tempDamage *= deathAffinity / aEnemy.deathAffinity;
    }
    if (enduranceAttack) {
        tempDamage *= (1 + (endurance / maxEndurance));
    }
    tempDamage *= fabsf(endurance / maxEndurance);
    if(endurance < 0) {
        return 0;
    }
    tempDamage += (arc4random() % (int)((level + levelModifier) * 4));
    if (hpAttack) {
        hp -= maxHP * 0.07;
        tempDamage += maxHP * 0.7;
    }
    if (drainAttack) {
        hp += tempDamage * 0.1;
    }
    if (drainAttackEquipped && !drainAttack) {
        hp += tempDamage * 0.1;
    }
    if (damageEssence) {
        aEnemy.essence -= (int)(tempDamage / 100);
    }
    if (damageEndurance) {
        aEnemy.endurance -= (int)(tempDamage / 100);
    }
    if (attacksRefillItemTimers) {
        //implement refilling here
    }
    if (essenceDrain) {
        essence += MIN((int)((float)(tempDamage / 10)), maxEssence - essence);
    }
    return (int)tempDamage;

}

- (int)calculateHealingTo:(AbstractBattleCharacter *)aCharacter {
    float healingAmount = (affinity + affinityModifier) * 2 + stamina + staminaModifier;
    healingAmount += RANDOM_0_TO_1() * (10 + level + levelModifier + luck);
    return (int)healingAmount;
}

- (int)calculateTrapDamageTo:(AbstractBattleEnemy *)aEnemy {
    float trapDamage = (aEnemy.strength + aEnemy.agility + aEnemy.dexterity);
    trapDamage += RANDOM_0_TO_1() * (10 + level + levelModifier + luck + luckModifier);
    return (int)trapDamage;
}

- (int)calculateDwarfapultDamageTo:(AbstractBattleEnemy *)aEnemy {
    float dwarfapultDamage = (power + powerModifier) * 2.5 - aEnemy.stamina - aEnemy.staminaModifier;
    dwarfapultDamage += RANDOM_0_TO_1() * (10 + level + levelModifier + luck + luckModifier);
    return (int)dwarfapultDamage;
}

- (int)calculateSuperAxerangDamageTo:(AbstractBattleEnemy *)aEnemy {
    float axerangDamage = (strength + strengthModifier + agility + agilityModifier + dexterity + dexterityModifier) * 2 - aEnemy.dexterity - aEnemy.dexterityModifier;
    axerangDamage += RANDOM_0_TO_1() * (10 + level + levelModifier + luck + luckModifier);
    return (int)axerangDamage;
}

- (int)calculateMotivationDurationTo:(AbstractBattleCharacter *)aCharacter {
    float motivationDuration = totalDrinks * 4;
    motivationDuration += RANDOM_0_TO_1() * aCharacter.luck;
    return (int)motivationDuration;
}

- (int)calculateBombulusDamageTo:(AbstractBattleEnemy *)aEnemy {
    float bombulusDamage = (strength + strengthModifier + power + powerModifier) * 5.2 - (aEnemy.stamina + aEnemy.staminaModifier + aEnemy.affinity + aEnemy.affinityModifier);
    bombulusDamage += RANDOM_0_TO_1() * (level + levelModifier + luck + luckModifier);
    return (int)bombulusDamage;
}

- (void)unlockGeboPotential {
    
    if (geboPotential) {
        return;
    }
    [self increaseStrengthModifierBy:5];
    [self increaseLuckModifierBy:5];
    [self increasePowerModifierBy:5];
    [self increaseStaminaModifierBy:5];
    geboPotential = YES;
}

@end

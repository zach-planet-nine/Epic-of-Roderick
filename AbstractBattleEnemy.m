//
//  AbstractBattleEnemy.m
//  TEORBattleTest
//
//  Created by Zach Babb on 5/25/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "AbstractBattleEnemy.h"
#import "GameController.h"
#import "Character.h"
#import "AbstractScene.h"
#import "AbstractBattleCharacter.h"
#import "AbstractBattleEntity.h"
#import "OverMind.h"
#import "Image.h"
#import "Global.h"
#import "Animation.h"
#import "HealingAnimation.h"
#import "BattleStringAnimation.h"
#import "Boobytrap.h"


@implementation AbstractBattleEnemy

@synthesize whichEnemy;
@synthesize experience;
@synthesize defaultImage;
@synthesize damageDealt;
@synthesize boobytrapped;


- (void)dealloc {
	
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
		
		essenceColor = Color4fMake(0, 0, 0, 1);
        waterAffinity = skyAffinity = rageAffinity = lifeAffinity = stoneAffinity = fireAffinity = woodAffinity = poisonAffinity = divineAffinity = deathAffinity = 4;
        for (int i = 0; i < MIN(3, [sharedGameController.party count]); i++) {
            Character *character = [sharedGameController.party objectAtIndex:i];
            partyLevel += character.level;
        }
        partyLevel /= (MIN(3, [sharedGameController.party count]));
	}
	
	return self;
}

- (id)initWithBattleLocation:(int)aLocation {
	
    if (self = [super init]) {
		essenceColor = Color4fMake(0, 0, 0, 1);
        waterAffinity = skyAffinity = rageAffinity = lifeAffinity = stoneAffinity = fireAffinity = woodAffinity = poisonAffinity = divineAffinity = deathAffinity = 9;
        whichCharacter = 1089;
        sharedOverMind = [OverMind sharedOverMind];
        decisionTimer = RANDOM_0_TO_1() * 4;
        decisionChance = 5;
        switch (aLocation) {
			case 1:
				//rect = CGRectMake(280, 90, 100, 120);
				renderPoint = CGPointMake(340 + (RANDOM_MINUS_1_TO_1() * 7), 90 + (RANDOM_MINUS_1_TO_1() * 7));
				break;
			case 2:
				//rect = CGRectMake(280, 210, 100, 120);
				renderPoint = CGPointMake(340 + (RANDOM_MINUS_1_TO_1() * 7), 240 + (RANDOM_MINUS_1_TO_1() * 7));
				break;
			case 3:
				//rect = CGRectMake(380, 90, 100, 120);
				renderPoint = CGPointMake(420 + (RANDOM_MINUS_1_TO_1() * 7), 90 + (RANDOM_MINUS_1_TO_1() * 7));
				break;
			case 4:
				//rect = CGRectMake(380, 210, 100, 120);
				renderPoint = CGPointMake(420 + (RANDOM_MINUS_1_TO_1() * 7), 240 + (RANDOM_MINUS_1_TO_1() * 7));
				break;
			default:
				break;
                
		}
        for (int i = 0; i < MIN(3, [sharedGameController.party count]); i++) {
            Character *character = [sharedGameController.party objectAtIndex:i];
            partyLevel += character.level;
        }
        if ([sharedGameController.party count] > 0) {
            partyLevel /= (MIN(3, [sharedGameController.party count]));
        } else {
            partyLevel = 1;
        }
    }
	
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
    if (wait) {
        if (waitTimer != -1) {
            waitTimer -= aDelta;
            if (waitTimer < 0) {
                wait = NO;
            }
        }
        return;
    }
	[super updateWithDelta:aDelta];
	if (isFlashing) {
		flashTimer -= aDelta;
		if (flashTimer < 0) {
			////NSLog(@"Color alpha is: %f.", defaultImage.color.alpha);
			if (defaultImage.color.alpha < 1) {
				defaultImage.color = Color4fMake(0, 0, 0, 1);
				flashes--;
				flashTimer = 0.04;
				if (flashes == 0) {
					isFlashing = NO;
                    defaultImage.color = Color4fOnes;
				}
			} else {
				defaultImage.color = flashColor;
				flashTimer = 0.04;
			}

		}
	}
    if (isAlive == NO && defaultImage.color.alpha != 0) {
        //NSLog(@"Alpha should be going down.");
        defaultImage.color = Color4fMake(defaultImage.color.red, defaultImage.color.green, defaultImage.color.blue, defaultImage.color.alpha - aDelta);
        if (defaultImage.color.alpha < 0) {
            //NSLog(@"Battle with bats should end.");
            [sharedGameController.currentScene checkIfBattleOver];
            defaultImage.color = Color4fMake(0, 0, 0, 0);
        }
    }
    if (isAlive) {
        decisionTimer -= aDelta;
        if (decisionTimer < 0) {
            decisionChance += 5;
            decisionTimer = 2;
            if (isSlothed) {
                decisionTimer = 3.5;
            }
            if (RANDOM_0_TO_1() * 100 < decisionChance + ((level + levelModifier) / 2)) {
                decisionChance = 5;
                [self decideWhatToDo];
            }
        }
    }
    if (essence != maxEssence) {
        float essenceAdder = (MAX(1, ((power + powerModifier + affinity + affinityModifier) / 2 * 0.03))) * aDelta + (essenceHelper * aDelta);
        if (isDrauraed) {
            essenceAdder *= 0.6;
        } else if (isAuraed) {
            essenceAdder *= 1.6;
        }
        essence += essenceAdder;
        if (essence > maxEssence) {
            essence = maxEssence;
        }
    }
    if (endurance != maxEndurance) {
        float enduranceAdder = (MAX(1, ((stamina + staminaModifier) * 0.03))) * aDelta;
        if (isFatigued) {
            enduranceAdder *= 0.6;
        } else if (isMotivated) {
            enduranceAdder *= 1.6;
        }
        endurance += enduranceAdder;
        if (endurance > maxEndurance) {
            endurance = maxEndurance;
        }
    }
    
}

- (void)render {
	
	[defaultImage renderCenteredAtPoint:renderPoint];
	[super render];

}

- (void)youHaveDied {
    //NSLog(@"Bats have died.");
    [sharedOverMind removeEnemy:self];
    isAlive = NO;
    bleeders = 0;
}

- (void)gainPriority {
}

- (CGRect)getRect {
	
	return CGRectMake(renderPoint.x - 60, renderPoint.y - 60, 120, 120);
}

- (void)youTookDamage:(int)aDamage {
	/*if (isAlive) {
        renderDamage = YES;
        damageRenderPoint = CGPointMake(renderPoint.x - 50, renderPoint.y - 20);
        damage += aDamage;
        [super youTookDamage:aDamage];
    }*/
    
    if (aDamage < 0) {
        aDamage = 0;
    }
    if (isAlive) {
        if (willTakeDoubleDamage) {
            aDamage *= 2;
            willTakeDoubleDamage = NO;
        }
        BattleStringAnimation *bsa = [[BattleStringAnimation alloc] initDamageString:[NSString stringWithFormat:@"%d", aDamage] from:renderPoint];
        [sharedGameController.currentScene addObjectToActiveObjects:bsa];
        [bsa release];
        [super youTookDamage:aDamage];
    }
}

- (void)youTookCriticalDamage:(int)aDamage {
    
    //int newDamage = aDamage * 2;
    if (aDamage < 0) {
        aDamage = 0;
    }
    if (isAlive) {
        BattleStringAnimation *bsa = [[BattleStringAnimation alloc] initCriticalDamageString:[NSString stringWithFormat:@"%d", aDamage] from:renderPoint];
        [sharedGameController.currentScene addObjectToActiveObjects:bsa];
        [bsa release];
        [super youTookDamage:aDamage];
    }
   

}

- (void)youTookEssenceDamage:(int)aEssenceDamage {
    
    if (aEssenceDamage < 0) {
        aEssenceDamage = 0;
    }
    if (isAlive) {
        BattleStringAnimation *bsa = [[BattleStringAnimation alloc] initEssenceString:[NSString stringWithFormat:@"%d", aEssenceDamage] from:renderPoint withColor:Color4fMake(0.3, 0.3, 0.3, 1)];
        [sharedGameController.currentScene addObjectToActiveObjects:bsa];
        [bsa release];
        [super youTookEssenceDamage:aEssenceDamage];
    }
}

- (void)youWereHealed:(int)aHealing {
    
    if (!cannotBeHealed) {
        int hpToGain = maxHP - hp;
        hpToGain = MIN(aHealing, hpToGain);
        hp += hpToGain;
        healing = hpToGain;
        HealingAnimation *ha = [[HealingAnimation alloc] initAtPosition:CGPointMake(renderPoint.x, renderPoint.y)];
        [sharedGameController.currentScene addObjectToActiveObjects:ha];
        [ha release];
        [super youWereHealed:aHealing];
    } else {
        
        BattleStringAnimation *ineffective = [[BattleStringAnimation alloc] initIneffectiveStringFrom:renderPoint];
        [sharedGameController.currentScene addObjectToActiveObjects:ineffective];
        [ineffective release];
    }
	
}

- (void)youWereBlinded:(int)aBlindRoll {
	
	[super youWereBlinded:aBlindRoll];
	//NSLog(@"This was called.");
	if (isBlind) {
		Animation *blindAnimation = [[Animation alloc] init];
		Image *blind1 = [[Image alloc] initWithImageNamed:@"BlindEye1.png" filter:GL_LINEAR];
		Image *blind2 = [[Image alloc] initWithImageNamed:@"BlindEye2.png" filter:GL_LINEAR];
		[blindAnimation addFrameWithImage:blind1 delay:0.2];
		[blindAnimation addFrameWithImage:blind2 delay:0.2];
		[blindAnimation addFrameWithImage:blind1 delay:0.2];
		[blindAnimation addFrameWithImage:blind2 delay:0.3];
		blindAnimation.state = kAnimationState_Running;
		blindAnimation.type = kAnimationType_Once;
		blindAnimation.renderPoint = CGPointMake(renderPoint.x - 30, renderPoint.y + 40);
		[sharedGameController.currentScene addObjectToActiveObjects:blindAnimation];
		[blindAnimation release];
	}
}
// This is going to be a huge method that contains all of the AI. Hopefully it runs quickly.
- (BOOL)canIDoThis:(EnemyAI)aDecision {
    
    if (isDisoriented) {
        return YES;
    }

    switch (aDecision.stat) {
        case kAIEndurancePercent:
            if (endurance / maxEndurance * 100 < aDecision.threshold) {
                return NO;
            }
            break;
        case kAIEssencePercent:
            if (isHexed) {
                return NO;
            }
            if (essence / maxEssence * 100 < aDecision.threshold) {
                return NO;
            }
            break;
        case kAIHPPercent:
            if (hp / maxHP * 100 < aDecision.threshold) {
                return NO;
            }
            break;
        case kAIEnduranceAmount:
            if (endurance < aDecision.threshold) {
                return NO;
            }
            break;
        case kAIEssenceAmount:
            if (isHexed) {
                return NO;
            }
            if (essence < aDecision.threshold) {
                return NO;
            }
            break;
        case kAIHPAmount:
            if (hp > aDecision.threshold) {
                return NO;
            }
            break;
        default:
            break;
    }
    return [self checkTarget:aDecision];
}

- (BOOL)checkTarget:(EnemyAI)aDecision {
    
    //NSLog(@"This is called %d", aDecision.decider);
    switch (aDecision.decider) {
        case kAIEnemyWithHPBelowPercent:
            if (![sharedOverMind enemyWithHPBelowPercent:(float)aDecision.parameter]) {
                return NO;
            }
            break;
        case kAIEnemyWithEssenceBelowPercent:
            if (![sharedOverMind enemyWithEssenceBelowPercent:(float)aDecision.parameter]) {
                return NO;
            }
            break;
        case kAIEnemyWithEnduranceBelowPercent:
            if (![sharedOverMind enemyWithEnduranceBelowPercent:(float)aDecision.parameter]) {
                return NO;
            }
            break;
        case kAIFatiguedEnemy:
            if (![sharedOverMind fatiguedEnemy]) {
                return NO;
            }
            break;
        case kAIDrauraedEnemy:
            if (![sharedOverMind drauraedEnemy]) {
                return NO;
            }
            break;
        case kAISlothedEnemy:
            if (![sharedOverMind slothedEnemy]) {
                return NO;
            }
            break;
        case kAIHexedEnemy:
            if (![sharedOverMind hexedEnemy]) {
                return NO;
            }
            break;
        case kAIDisorientedEnemy:
            if (![sharedOverMind disorientedEnemy]) {
                return NO;
            }
            break;
        case kAIEnemyHasBleeders:
            if (![sharedOverMind enemyHasBleeders]) {
                return NO;
            }
            break;
        case kAIEnemyNotMotivated:
            if (![sharedOverMind notMotivated]) {
                return NO;
            }
            break;
        case kAIEnemyNotAuraed:
            if (![sharedOverMind notAuraed]) {
                return NO;
            }
            break;
        case kAICharacterWithHPAbovePercent:
            if (![sharedOverMind characterWithHPAbovePercent:(float)aDecision.parameter]) {
                return NO;
            }
            break;
        case kAICharacterWithEssenceAbovePercent:
            if (![sharedOverMind characterWithEssenceAbovePercent:(float)aDecision.parameter]) {
                return NO;
            }
            break;
        case kAICharacterWithEnduranceAbovePercent:
            if (![sharedOverMind characterWithEnduranceAbovePercent:(float)aDecision.parameter]) {
                return NO;
            }
            break;
        case kAICharacterWithHPBelowPercent:
            if (![sharedOverMind characterWithHPBelowPercent:(float)aDecision.parameter]) {
                return NO;
            }
            break;
        case kAICharacterWithEssenceBelowPercent:
            if (![sharedOverMind characterWithEssenceBelowPercent:(float)aDecision.parameter]) {
                return NO;
            }
            break;
        case kAICharacterWithEnduranceBelowPercent:
            if (![sharedOverMind characterWithEnduranceBelowPercent:(float)aDecision.parameter]) {
                return NO;
            }
            break;
        case kAIAuraedCharacter:
            if (![sharedOverMind auraedCharacter]) {
                return NO;
            }
            break;
        case kAIMotivatedCharacter:
            if (![sharedOverMind motivatedCharacter]) {
                return NO;
            }
            break;
        case kAIFatiguedCharacter:
            if (![sharedOverMind fatiguedCharacter]) {
                return NO;
            }
            break;
        case kAIDrauraedCharacter:
            if (![sharedOverMind drauraedCharacter]) {
                return NO;
            }
            break;
        case kAISlothedCharacter:
            if (![sharedOverMind slothedCharacter]) {
                return NO;
            }
            break;
        case kAIHexedCharacter:
            if (![sharedOverMind hexedCharacter]) {
                return NO;
            }
            break;
        case kAIDisorientedCharacter:
            if (![sharedOverMind disorientedCharacter]) {
                return NO;
            }
            break;
        case kAIEnemyHasNegativeStatus:
            if (![sharedOverMind enemyHasNegativeStatus]) {
                return NO;
            }
            break;
        default:
            break;
    }
    return YES;
}

- (void)decideWhatToDo {}

- (void)doThis:(EnemyAI)aDecision decider:(AbstractBattleEnemy *)aEnemy {

    [self flashColor:Color4fOnes];
    AbstractBattleCharacter *character;
    AbstractBattleEnemy *enemy;
    
    switch (aDecision.decider) {
        case kAIAnyEnemy:
            enemy = [sharedOverMind anyEnemy];
            break;
        case kAISelf:
            enemy = self;
            break;
        case kAIEnemyWithLowestHP:
            enemy = [sharedOverMind enemyWithLowestHP];
            break;
        case kAIEnemyWithHighestHP:
            enemy = [sharedOverMind enemyWithHighestHP];
            break;
        case kAIEnemyWithLowestEndurance:
            enemy = [sharedOverMind enemyWithLowestEndurance];
            break;
        case kAIEnemyWithHighestEndurance:
            enemy = [sharedOverMind enemyWithHighestEndurance];
            break;
        case kAIEnemyWithLowestEssence:
            enemy = [sharedOverMind enemyWithLowestEssence];
            break;
        case kAIEnemyWithHighestEssence:
            enemy = [sharedOverMind enemyWithHighestEssence];
            break;
        case kAIEnemyWithLowestDefense:
            enemy = [sharedOverMind enemyWithLowestDefense];
            break;
        case kAIEnemyWithLowestAffinity:
            enemy = [sharedOverMind enemyWithLowestAffinity];
            break;
        case kAIEnemyWithHPBelowPercent:
            NSLog(@"It's choosing this.");
            enemy = [sharedOverMind enemyWithHPBelowPercent:(float)aDecision.parameter];
            break;
        case kAIEnemyWithEssenceBelowPercent:
            enemy = [sharedOverMind enemyWithEssenceBelowPercent:(float)aDecision.parameter];
            break;
        case kAIEnemyWithEnduranceBelowPercent:
            enemy = [sharedOverMind enemyWithEnduranceBelowPercent:(float)aDecision.parameter];
            break;
        case kAIFatiguedEnemy:
            enemy = [sharedOverMind fatiguedEnemy];
            break;
        case kAIDrauraedEnemy:
            enemy = [sharedOverMind drauraedEnemy];
            break;
        case kAISlothedEnemy:
            enemy = [sharedOverMind slothedEnemy];
            break;
        case kAIDisorientedEnemy:
            enemy = [sharedOverMind disorientedEnemy];
            break;
        case kAIHexedEnemy:
            enemy = [sharedOverMind hexedEnemy];
            break;
        case kAIEnemyHasBleeders:
            enemy = [sharedOverMind enemyHasBleeders];
            break;
        case kAINeedsElementalGuard:
            enemy = [sharedOverMind needsElementalGuard:aDecision.parameter];
            break;
        case kAINeedsElementalAttack:
            enemy = [sharedOverMind needsElementalAttack:aDecision.parameter];
            break;
        case kAIEnemyNotMotivated:
            enemy = [sharedOverMind notMotivated];
            break;
        case kAIEnemyNotAuraed:
            enemy = [sharedOverMind notAuraed];
            break;
        case kAIAnyCharacter:
            character = [sharedOverMind anyCharacter];
            break;
        case kAICharacterWithLowestHP:
            character = [sharedOverMind characterWithLowestHP];
            break;
        case kAICharacterWithHighestHP:
            character = [sharedOverMind characterWithHighestHP];
            break;
        case kAICharacterWithLowestStat:
            character = [sharedOverMind characterWithLowestStat:aDecision.parameter];
            break;
        case kAICharacterWithHighestStat:
            character = [sharedOverMind characterWithHighestStat:aDecision.parameter];
            break;
        case kAICharacterWithHighestEssence:
            character = [sharedOverMind characterWithHighestEssence];
            break;
        case kAICharacterWithLowestEndurance:
            character = [sharedOverMind characterWithLowestEndurance];
            break;
        case kAICharacterWithLowestEssence:
            character = [sharedOverMind characterWithLowestEssence];
            break;
        case kAICharacterWithHighestEndurance:
            character = [sharedOverMind characterWithHighestEndurance];
            break;
        case kAICharacterWithHPAbovePercent:
            character = [sharedOverMind characterWithHPAbovePercent:(float)aDecision.parameter];
            break;
        case kAICharacterWithEssenceAbovePercent:
            character = [sharedOverMind characterWithEssenceAbovePercent:(float)aDecision.parameter];
            break;
        case kAICharacterWithEnduranceAbovePercent:
            character = [sharedOverMind characterWithEnduranceAbovePercent:(float)aDecision.parameter];
            break;
        case kAICharacterWithHPBelowPercent:
            character = [sharedOverMind characterWithHPBelowPercent:(float)aDecision.parameter];
            break;
        case kAICharacterWithEssenceBelowPercent:
            character = [sharedOverMind characterWithEssenceBelowPercent:(float)aDecision.parameter];
            break;
        case kAICharacterWithEnduranceBelowPercent:
            character = [sharedOverMind characterWithEnduranceBelowPercent:(float)aDecision.parameter];
            break;
        case kAIAuraedCharacter:
            character = [sharedOverMind auraedCharacter];
            break;
        case kAIMotivatedCharacter:
            character = [sharedOverMind motivatedCharacter];
            break;
        case kAIFatiguedCharacter:
            character = [sharedOverMind fatiguedCharacter];
            break;
        case kAIDrauraedCharacter:
            character = [sharedOverMind drauraedCharacter];
            break;
        case kAISlothedCharacter:
            character = [sharedOverMind slothedCharacter];
            break;
        case kAIDisorientedCharacter:
            character = [sharedOverMind disorientedCharacter];
            break;
        case kAIHexedCharacter:
            character = [sharedOverMind hexedCharacter];
            break;
        case kAICharacterWithLowestElementalAffinity:
            character = [sharedOverMind characterWithLowestElementalAffinity:aDecision.parameter];
            break;
        case kAICharacterWithHighestElementalAffinity:
            character = [sharedOverMind characterWithHighestElementalAffinity:aDecision.parameter];
            break;
        default:
            break;
    }
    
    if (isDisoriented) {
        if (enemy) {
            enemy = [sharedOverMind anyEnemy];
        }
        if (character) {
            character = [sharedOverMind anyCharacter];
        }
    }
    
    switch (aDecision.ability) {
            //Physical abilities
        case kAIEnemySmash:
           // //NSLog(@"Enemy Smash! %d", target.whichCharacter);
            //endurance -= 30;
            [sharedOverMind enemy:self smashes:character];
            break;
        case kAIEnemyBite:
            ////NSLog(@"Enemy Bite! %d", target.whichCharacter);
            //endurance -= 20;
            [sharedOverMind enemy:self bites:character];
            break;
        case kAIEnemyArrow:
            [sharedOverMind enemy:self arrows:character];
            break;
        case kAIEnemySlash:
            [sharedOverMind enemy:self slashes:character];
            break;
            
        // Magical abilities
        case kAIEnemyEnergyBall:
            ////NSLog(@"Enemy EnergyBall! %d", target.whichCharacter);
            //essence -= 25;
            //endurance -= 10;
            [sharedOverMind enemy:self energyBalls:character];
            break;
        case kAIEnemyFire:
            ////NSLog(@"Enemy Fire! %d", target.whichCharacter);
            //essence -= 40;
            [sharedOverMind enemy:self fires:character];
            break;
        case kAIEnemyFireAllCharacters:
            [sharedOverMind enemyFiresAllCharacters:self];
            break;
        case kAIEnemyPoisonAllCharacters:
            [sharedOverMind enemyPoisonsAllCharacters:self];
            break;
        case kAIEnemyPoison:
            [sharedOverMind enemy:self poisons:character];
            break;
        case kAIEnemyWater:
            [sharedOverMind enemy:self waters:character];
            break;
        case kAIEnemyWaterAllCharacters:
            [sharedOverMind enemyWatersAllCharacters:self];
            break;
        case kAIEnemyRage:
            [sharedOverMind enemy:self rages:character];
            break;
        case kAIEnemyRageAllCharacters:
            [sharedOverMind enemyRagesAllCharacters:self];
            break;
            
        // Enemy effects on enemies
        case kAIEnemyHeal:
            ////NSLog(@"Enemy Heal! %d", target.whichCharacter);
            //essence -= 15;
            [sharedOverMind enemy:self heals:enemy];
            break;
        case kAIEnemyFatigueCure:
            ////NSLog(@"Enemy would cure fatigue! %d", target.whichCharacter);
            //essence -= 20;
            [sharedOverMind enemyCuresFatigue:enemy];
            break;
        case kAIEnemyHealNegativeStatus:
            [sharedOverMind enemy:self healsNegativeStatusEffectOn:enemy];
            break;
        case kAIEnemyHealBleeder:
            [sharedOverMind enemy:self healsBleedersOn:enemy];
            break;
        
        default:
            break;
    }
    if (boobytrapped) {
        [Boobytrap triggerTrap:self];
        boobytrapped = NO;
    }
}

- (int)calculateBiteDamageToCharacter:(AbstractBattleCharacter *)aCharacter {
    float biteDamage = ((((strength + strengthModifier + agility + agilityModifier) / 1.8) * 3 - aCharacter.dexterity - aCharacter.dexterityModifier - aCharacter.agility - aCharacter.agilityModifier) * (endurance / maxEndurance));
    biteDamage += arc4random() % (int)(level + levelModifier + 10);
    endurance -= 5 + (level * 0.2);
    return (int)biteDamage;
}

- (int)calculateSmashDamageToCharacter:(AbstractBattleCharacter *)aCharacter {
    float smashDamage = (((strength + strengthModifier) * 5) - aCharacter.agility - aCharacter.agilityModifier - aCharacter.dexterity - aCharacter.dexterityModifier - aCharacter.stamina - aCharacter.staminaModifier) * (endurance / maxEndurance);
    smashDamage += arc4random() % (int)(level + levelModifier + 10);
    endurance -= 10 + (level * 0.2);
    return (int)smashDamage;
}

- (int)calculateEnergyBallDamageToCharacter:(AbstractBattleCharacter *)aCharacter {
    float energyDamage = (((power + powerModifier) * 3.5 - aCharacter.affinity - aCharacter.affinityModifier) * (essence / maxEssence));
    energyDamage += arc4random() % (int)(level + levelModifier + 10);
    essence -= 10 + (level * 0.2);
    return (int)energyDamage;
}

- (int)calculateHealAmountTo:(AbstractBattleEnemy *)aEnemy {
    float healAmount = ((affinity + affinityModifier) * 4) * (essence / maxEssence);
    healAmount += arc4random() % (int)(level + levelModifier + 10);
    essence -= 12 + (level * 0.2);
    return (int)healAmount;
}

- (int)calculateFireDamageToCharacter:(AbstractBattleCharacter *)aCharacter {
    float fireDamage = (((power + powerModifier) * 3 - aCharacter.affinity - aCharacter.affinityModifier) * (fireAffinity / aCharacter.fireAffinity) * (essence / maxEssence));
    fireDamage += arc4random() % (int)(level + levelModifier + 10);
    if (aCharacter.fireProtectionEquipped) {
        fireDamage *= 0.66;
    }
    if (aCharacter.isProtectedFromFire) {
        fireDamage *= 0.66;
    }
    essence -= 15 + (level * 0.2);
    return (int)fireDamage;
}

- (int)calculateFireDamageToASingleCharacter:(AbstractBattleCharacter *)aCharacter {
    float fireDamage = (((power + powerModifier) * 4.5 - aCharacter.affinity - aCharacter.affinityModifier) * (fireAffinity / aCharacter.fireAffinity) * (essence / maxEssence));
    fireDamage += arc4random() % (int)(level + levelModifier + 10);
    if (aCharacter.fireProtectionEquipped) {
        fireDamage *= 0.66;
    }
    if (aCharacter.isProtectedFromFire) {
        fireDamage *= 0.66;
    }
    essence -= 15 + (level * 0.2);
    return (int)fireDamage;
}

- (int)calculateArrowDamageToCharacter:(AbstractBattleCharacter *)aCharacter {
    float arrowDamage = ((dexterity + dexterityModifier) * 3 - aCharacter.agility - aCharacter.agilityModifier - aCharacter.dexterity - aCharacter.dexterityModifier) * (endurance / maxEndurance);
    arrowDamage += arc4random() % (int)(level + levelModifier + 10);
    endurance -= 8 + (level * 0.2);
    return (int)arrowDamage;
}

- (int)calculateSlashDamageToCharacter:(AbstractBattleCharacter *)aCharacter {
    float slashDamage = ((strength + strengthModifier) * 3.5 - aCharacter.agility - aCharacter.agilityModifier - aCharacter.dexterity - aCharacter.dexterityModifier) * (endurance / maxEndurance);
    slashDamage += arc4random() % (int)(level + levelModifier + 10);
    endurance -= 10 + (level * 0.2);
    return (int)slashDamage;
}

- (int)calculatePoisonDamageToCharacter:(AbstractBattleCharacter *)aCharacter {
    float poisonDamage = ((power + powerModifier) * 3 - aCharacter.affinity - aCharacter.affinityModifier) * (poisonAffinity / aCharacter.poisonAffinity) * (essence / maxEssence);
    poisonDamage += arc4random() % (int)(level + levelModifier + 10);
    if (aCharacter.poisonProtectionEquipped) {
        poisonDamage *= 0.66;
    }
    if (aCharacter.isProtectedFromPoison) {
        poisonDamage *= 0.66;
    }
    essence -= 15 + (level * 0.2);
    return (int)poisonDamage;
}

- (int)calculatePoisonDamageToASingleCharacter:(AbstractBattleCharacter *)aCharacter {
    float poisonDamage = ((power + powerModifier) * 4.5 - aCharacter.affinity - aCharacter.affinityModifier) * (poisonAffinity / aCharacter.poisonAffinity) * (essence / maxEssence);
    poisonDamage += arc4random() % (int)(level + levelModifier + 10);
    if (aCharacter.poisonProtectionEquipped) {
        poisonDamage *= 0.66;
    }
    if (aCharacter.isProtectedFromPoison) {
        poisonDamage *= 0.66;
    }
    essence -= 15 + (level * 0.2);
    return (int)poisonDamage;
}

- (int)calculateWaterDamageToCharacter:(AbstractBattleCharacter *)aCharacter {
    float waterDamage = ((power + powerModifier) * 3 - aCharacter.affinity - aCharacter.affinityModifier) * (waterAffinity / aCharacter.waterAffinity) * (essence / maxEssence);
    waterDamage += arc4random() % (int)(level + levelModifier + 10);
    if (aCharacter.waterProtectionEquipped) {
        waterDamage *= 0.66;
    }
    if (aCharacter.isProtectedFromWater) {
        waterDamage *= 0.66;
    }
    return (int)waterDamage;
}

- (int)calculateWaterDamageToASingleCharacter:(AbstractBattleCharacter *)aCharacter {
    float waterDamage = ((power + powerModifier) * 4.5 - aCharacter.affinity - aCharacter.affinityModifier) * (waterAffinity / aCharacter.waterAffinity) * (essence / maxEssence);
    waterDamage += arc4random() % (int)(level + levelModifier + 10);
    if (aCharacter.waterProtectionEquipped) {
        waterDamage *= 0.66;
    }
    if (aCharacter.isProtectedFromWater) {
        waterDamage *= 0.66;
    }
    essence -= 15 + (level * 0.2);
    return (int)waterDamage;
}

- (int)calculateRageDamageToCharacter:(AbstractBattleCharacter *)aCharacter {
    float rageDamage = ((power + powerModifier) * 3 - aCharacter.affinity - aCharacter.affinityModifier) * (rageAffinity / aCharacter.rageAffinity) * (essence / maxEssence);
    rageDamage += arc4random() % (int)(level + levelModifier + 10);
    if (aCharacter.rageProtectionEquipped) {
        rageDamage *= 0.66;
    }
    if (aCharacter.isProtectedFromRage) {
        rageDamage *= 0.66;
    }
    essence -= 15 + (level * 0.2);
    return (int)rageDamage;
}

- (int)calculateRageDamageToASingleCharacter:(AbstractBattleCharacter *)aCharacter {
    float rageDamage = ((power + powerModifier) * 4.5 - aCharacter.affinity - aCharacter.affinityModifier) * (rageAffinity / aCharacter.rageAffinity) * (essence / maxEssence);
    rageDamage += arc4random() % (int)(level + levelModifier + 10);
    if (aCharacter.rageProtectionEquipped) {
        rageDamage *= 0.66;
    }
    if (aCharacter.isProtectedFromRage) {
        rageDamage *= 0.66;
    }
    essence -= 15 + (level * 0.2);
    return (int)rageDamage;
}

- (void)levelUp {
    
    level++;
    strength ++;
    agility ++;
    stamina ++;
    dexterity ++;
    power ++;
    affinity ++;
    if (maxEssence != 0) {
        maxEssence++;
    }
    maxEndurance++;
    if (RANDOM_0_TO_1() > 0.5) {
        strength++;
    }
    if (RANDOM_0_TO_1() > 0.5) {
        agility++;
    }
    if (RANDOM_0_TO_1() > 0.5) {
        stamina++;
    }
    if (RANDOM_0_TO_1() > 0.5) {
        dexterity++;
    }
    if (RANDOM_0_TO_1() > 0.5) {
        power++;
    }
    if (RANDOM_0_TO_1() > 0.5) {
        affinity++;
    }
    if (RANDOM_0_TO_1() > 0.5) {
        luck++;
    }
    if (RANDOM_0_TO_1() > 0.5) {
        endurance++;
    }
    if (essence > 0 && RANDOM_0_TO_1() > 0.5) {
        essence++;
    }
    endurance = maxEndurance;
    essence = maxEssence;
    maxHP += (level + (level * 0.5) + stamina);
    hp = maxHP;

}

@end

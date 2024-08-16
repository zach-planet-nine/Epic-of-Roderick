//
//  AbstractBattleEntity.m
//  TEORBattleTest
//
//  Created by Zach Babb on 5/25/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "AbstractBattleEntity.h"
#import "AbstractScene.h"
#import "Global.h"
#import "TouchManager.h"
#import "InputManager.h"
#import "GameController.h"
#import "PackedSpriteSheet.h"
#import "Image.h"
#import "BitmapFont.h"
#import "BattleStringAnimation.h"


@implementation AbstractBattleEntity

@synthesize whichCharacter;
@synthesize state;
@synthesize level;
@synthesize levelModifier;
@synthesize hp;
@synthesize maxHP;
@synthesize endurance;
@synthesize maxEndurance;
@synthesize essence;
@synthesize maxEssence;
@synthesize strength;
@synthesize agility;
@synthesize stamina;
@synthesize dexterity;
@synthesize power;
@synthesize affinity;
@synthesize luck;
@synthesize strengthModifier;
@synthesize agilityModifier;
@synthesize staminaModifier;
@synthesize dexterityModifier;
@synthesize powerModifier;
@synthesize affinityModifier;
@synthesize luckModifier;
@synthesize criticalChance;
@synthesize waterAffinity;
@synthesize skyAffinity;
@synthesize lifeAffinity;
@synthesize rageAffinity;
@synthesize fireAffinity;
@synthesize stoneAffinity;
@synthesize woodAffinity;
@synthesize poisonAffinity;
@synthesize divineAffinity;
@synthesize deathAffinity;
@synthesize isProtectedFromWater;
@synthesize isProtectedFromSky;
@synthesize isProtectedFromRage;
@synthesize isProtectedFromLife;
@synthesize isProtectedFromFire;
@synthesize isProtectedFromStone;
@synthesize isProtectedFromWood;
@synthesize isProtectedFromPoison;
@synthesize isProtectedFromDeath;
@synthesize isProtectedFromDivine;
@synthesize essenceHelper;
@synthesize isAlive;
@synthesize rect;
@synthesize renderPoint;
@synthesize battleTimer;
@synthesize essenceColor;
@synthesize isBlind;
@synthesize isParalyzed;
@synthesize isDrauraed;
@synthesize isAuraed;
@synthesize isFatigued;
@synthesize isMotivated;
@synthesize isDisoriented;
@synthesize isHexed;
@synthesize isSlothed;
@synthesize cannotBeHealed;
@synthesize enhanceBleederDamage;
@synthesize active;
@synthesize wait;
@synthesize waitTimer;
@synthesize waterProtectionEquipped;
@synthesize skyProtectionEquipped;
@synthesize rageProtectionEquipped;
@synthesize lifeProtectionEquipped;
@synthesize fireProtectionEquipped;
@synthesize stoneProtectionEquipped;
@synthesize woodProtectionEquipped;
@synthesize poisonProtectionEquipped;
@synthesize divineProtectionEquipped;
@synthesize deathProtectionEquipped;


- (id)init {
	
	if (self = [super init]) {
		sharedTouchManager = [TouchManager sharedTouchManager];
		sharedGameController = [GameController sharedGameController];
		sharedInputManager = [InputManager sharedInputManager];
		//When fully implemented this can be here.
		//battleFont = sharedGameController.currentScene.battleFont;
		selectorImage = [sharedGameController.teorPSS imageForKey:@"SelectorImage40x40.png"];
		bleeders = 0;
        level = 0;
        levelModifier = 0;
        hp = 0;
        maxHP = 0;
        essence = 0;
        maxEssence = 0;
        endurance = 0;
        maxEndurance = 0;
        strength = 0;
        strengthModifier = 0;
        agility = 0;
        agilityModifier = 0;
        stamina = 0;
        staminaModifier = 0;
        dexterity = 0;
        dexterityModifier = 0;
        power = 0;
        powerModifier = 0;
        affinity = 0;
        affinityModifier = 0;
        luck = 0;
        luckModifier = 0;
        criticalChance = 0;
        bleeders = 0;
        isAlive = YES;
        waterAffinity = 0;
        skyAffinity = 0;
        rageAffinity = 0;
        lifeAffinity = 0;
        fireAffinity = 0;
        stoneAffinity = 0;
        woodAffinity = 0;
        poisonAffinity = 0;
        divineAffinity = 0;
        deathAffinity = 0;
        isProtectedFromWater = NO;
        isProtectedFromSky = NO;
        isProtectedFromRage = NO;
        isProtectedFromLife = NO;
        isProtectedFromFire = NO;
        isProtectedFromStone = NO;
        isProtectedFromRage = NO;
        isProtectedFromLife = NO;
        isProtectedFromWood = NO;
        isProtectedFromPoison = NO;
        isProtectedFromDivine = NO;
        isProtectedFromDeath = NO;
        waterProtectionEquipped = NO;
        skyProtectionEquipped = NO;
        lifeProtectionEquipped = NO;
        rageProtectionEquipped = NO;
        fireProtectionEquipped = NO;
        stoneProtectionEquipped = NO;
        woodProtectionEquipped = NO;
        poisonProtectionEquipped = NO;
        divineProtectionEquipped = NO;
        deathProtectionEquipped = NO;
        waterAttack = 0;
        skyAttack = 0;
        fireAttack = 0;
        stoneAttack = 0;
        lifeAttack = 0;
        rageAttack = 0;
        woodAttack = 0;
        poisonAttack = 0;
        deathAttack = 0;
        divineAttack = 0;
        waterAttackEquipped = NO;
        skyAttackEquipped = NO;
        rageAttackEquipped = NO;
        lifeAttackEquipped = NO;
        fireAttackEquipped = NO;
        stoneAttackEquipped = NO;
        woodAttackEquipped = NO;
        poisonAttackEquipped = NO;
        deathAttackEquipped = NO;
        divineAttackEquipped = NO;
        isFatigued = NO;
        isMotivated = NO;
        isDrauraed = NO;
        isAuraed = NO;
        isDisoriented = NO;
        isHexed = NO;
        isSlothed = NO;
        fatigueAttack = NO;
        drauraAttack = NO;
        disorientedAttack = NO;
        hexAttack = NO;
        slothAttack = NO;
        fatigueProtection = NO;
        drauraProtection = NO;
        disorientedProtection = NO;
        hexProtection = NO;
        slothProtection = NO;
        geboPotential = NO;
        othalaPotential = NO;
        numberOfAttacks = 1;
        doubleAttack = NO;
        cannotBeHealed = NO;
        receiveDoubleHealing = NO;
        doubleHealingGiven = NO;
        attackModifier = 1;
        effectModifier = 1;
        enduranceAttack = NO;
        enduranceDoesNotDeplete = NO;
        halfEnduranceExpenditure = NO;
        attackAttacksAllEnemies = NO;
        enhanceBleederDamage = NO;
        damageEssence = NO;
        rainIsHealingYou = NO;
        attacksCauseBleeders = NO;
        attackAddsSkeletonsToWunjo = NO;
        boneShield = NO;
        attackEnhancesFavor = NO;
        //NSLog(@"Initialization of ABE successful.");
        
	}
	
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	if (bleeders > 0) {
		for (int i = 0; i < bleeders; i++) {
            bleederTimers[i] -= aDelta;
            if (bleederTimers[i] < 0) {
                bleederTimers[i] = 3;
                int dam = [self calculateBleederDamage];
                [self youTookDamage:dam];
            }
        }
	}
	if (renderDamage && damageRenderPoint.y > renderPoint.y - 50) {
		damageRenderPoint.y -= aDelta * 20;
	} else if (renderDamage) {
		renderDamage = NO;
		damage = 0;
	}
	if (renderHealing && healingRenderPoint.y > renderPoint.y - 50) {
		healingRenderPoint.y -= aDelta * 20;
	} else if (renderHealing) {
		renderHealing = NO;
		healing = 0;
	}
	if (renderEssenceGain && essenceRenderPoint.y > renderPoint.y - 50) {
		essenceRenderPoint.y -= aDelta * 20;
	} else if (renderEssenceGain) {
		renderEssenceGain = NO;
		essenceGain = 0;
	}
	//Status timers.
	if (isBlind) {
		blindTimer -= aDelta;
		if (blindTimer < 0) {
			isBlind = NO;
			blindTimer = 0;
		}
	}
    
    if (isDrauraed) {
        drauraTimer -= aDelta;
        if (drauraTimer < 0) {
            isDrauraed = NO;
            //NSLog(@"Draura wore off.");
        }
    }
    if (isAuraed && auraTimer != -1) {
        auraTimer -= aDelta;
        if (auraTimer < 0) {
            isAuraed = NO;
        }
    }
    if (isFatigued) {
        fatigueTimer -= aDelta;
        if (fatigueTimer < 0) {
            isFatigued = NO;
        }
    }
    if (isMotivated && motivatedTimer != -1) {
        motivatedTimer -= aDelta;
        if (motivatedTimer < 0) {
            isMotivated = NO;
        }
    }
    if (isDisoriented) {
        disorientedTimer -= aDelta;
        if (disorientedTimer < 0) {
            isDisoriented = NO;
        }
    }
    if (isHexed) {
        hexTimer -= aDelta;
        if (hexTimer < 0) {
            isHexed = NO;
        }
    }
    if (isSlothed) {
        slothTimer -= aDelta;
        if (slothTimer < 0) {
            isSlothed = NO;
        }
    }
    
    //Revised AbstractBattleEntity updateWithDelta
    /*if (essence != maxEssence) {
        float essenceAdder = (MAX(1, ((power + powerModifier + affinity + affinityModifier) / 2 * 0.1))) * aDelta + (essenceHelper * aDelta);
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
        float enduranceAdder = (MAX(1, ((stamina + staminaModifier) * 0.1))) * aDelta;
        if (isFatigued) {
            enduranceAdder *= 0.6;
        } else if (isMotivated) {
            enduranceAdder *= 1.6;
        }
        endurance += enduranceAdder;
        if (endurance > maxEndurance) {
            endurance = maxEndurance;
        }
    }*/
    

}

- (void)render {
	//if (hasSelectorImage) {
	//	[selectorImage renderCenteredAtPoint:selectorImage.renderPoint];
	//}
	if (renderDamage) {
		[battleFont renderStringAt:damageRenderPoint text:[NSString stringWithFormat:@"%d", damage]];
	}
	if (renderHealing) {
		[battleFont renderStringAt:healingRenderPoint withText:[NSString stringWithFormat:@"%d", healing] withColor:Color4fMake(0, 1, 0, 1)];
	}
	if (renderEssenceGain) {
		[battleFont renderStringAt:essenceRenderPoint withText:[NSString stringWithFormat:@"%d", essenceGain] withColor:essenceColor];
	}
}

- (void)youHaveDied {}

- (void)youWereRaised {
    //implement in AbstractBattleCharacter
}

- (BOOL)isDead {
	
	if (hp <= 0) {
		state = kEntityState_Dead;
		return YES;
	} else {
		return NO;
	}
}

- (void)resetBattleTimer {
	
	battleTimer = 0.0;
}

- (CGRect)getRect {
	
	return CGRectMake(renderPoint.x - 30, renderPoint.y - 50, 60, 100);
}

- (void)addSelectorImage {
	
	for (AbstractBattleEntity *entity in sharedGameController.currentScene.activeEntities) {
		[entity removeSelectorImage];
	}
	hasSelectorImage = YES;
}

- (void)removeSelectorImage {
	
	hasSelectorImage = NO;
}
	
//Only used by characters, but sent to all active entities.
- (void)relinquishPriority {
}

- (void)addBleeder {
	
    if (protectedFromBleeders) {
        if (RANDOM_0_TO_1() < 0.5) {
            return;
        }
    }
    bleederTimers[bleeders] = 3;
    bleeders++;
    
}

- (void)removeBleeder {
	
    if (bleeders > 0) {
        bleeders--;
        bleederTimers[bleeders] = 0;
    }
}

- (BOOL)hasBleeders {
    
    if (bleeders > 0) {
        return YES;
    }
    return NO;
}

- (int)calculateBleederDamage {
	
    if (enhanceBleederDamage) {
        return (int)(((maxHP / 0.06) - (stamina + staminaModifier)) + arc4random() % 10);
    }
	return (int)(((maxHP * 0.03) - (stamina + staminaModifier)) + arc4random() % 10);
   
}

- (void)youTookDamage:(int)aDamage {
	//Only here because of when everything inits.
	battleFont = sharedGameController.currentScene.battleFont;
    if (isAlive) {
        hp -= aDamage;
        endurance += 1;
        essence += 1;
        if (endurance > maxEndurance) {
            endurance = maxEndurance;
        }
        if (essence > maxEssence) {
            essence = maxEssence;
        }
        //NSLog(@"Current HP is: %f", hp);
        if (hp < 0) {
            hp = 0;
            [self youHaveDied];
        }

    }
		//[self takeDamage:aDamage];
}

- (void)youTookCriticalDamage:(int)aDamage {}

- (void)youTookEssenceDamage:(int)aEssenceDamage {
    
    if (isAlive) {
        essence -= aEssenceDamage;
    }
}

- (void)youWereHealed:(int)aHealing {
	battleFont = sharedGameController.currentScene.battleFont;
	//Override for undead maybe?
    BattleStringAnimation *healingString = [[BattleStringAnimation alloc] initHealingString:[NSString stringWithFormat:@"%d", aHealing] from:renderPoint];
    [sharedGameController.currentScene addObjectToActiveObjects:healingString];
    [healingString release];
	[self flashColor:Color4fMake(0, 1, 0, 1)];
}

- (void)youWereGivenEssence:(int)aEssence {
	
	battleFont = sharedGameController.currentScene.battleFont;
	[self flashColor:essenceColor];
}

- (void)gainPriority {}

- (void)flashColor:(Color4f)aColor {
	
    if (isAlive) {
        flashColor = Color4fMake(aColor.red, aColor.green, aColor.blue, 0.99);
        flashes = 3;
        isFlashing = YES;
        flashTimer = 0.04;
    }

	
}

- (void)increaseLevelModifierBy:(int)aMod {
	
	if (levelModifier == -level && aMod > level) {
		levelModifier = 0;
	} else {
		levelModifier += aMod;
	}
    if (levelModifier > 37) {
        levelModifier = 37;
    }
    //NSLog(@"Level: %f, levelModifier: %f", level, levelModifier);
}

- (void)decreaseLevelModifierBy:(int)aMod {
	
	levelModifier -= aMod;
	if (level + levelModifier < 0) {
		levelModifier = -level;
	}
    if (levelModifier < -37) {
        levelModifier = -37;
    }
    //NSLog(@"Level: %f, levelModifier: %f", level, levelModifier);
}

- (void)increaseStrengthModifierBy:(int)aMod{
	
	if (strengthModifier == -strength && aMod > strength) {
		strengthModifier = 0;
	} else {
		strengthModifier += aMod;
	}
    if (strengthModifier > 37) {
        strengthModifier = 37;
    }
    //NSLog(@"Str: %f, StrMod:%f", strength, strengthModifier);
}


- (void)decreaseStrengthModifierBy:(int)aMod {
	
	strengthModifier -= aMod;
	if (strength + strengthModifier < 0) {
		strengthModifier = -strength;
	} 
    if (strengthModifier < -37) {
        strengthModifier = -37;
    }
    //NSLog(@"Str: %f, StrMod:%f", strength, strengthModifier);
}

- (void)increaseAgilityModifierBy:(int)aMod {
	
	if (agilityModifier == -agility && aMod > agility) {
		agilityModifier = 0;
	} else {
		agilityModifier += aMod;
	}
    if (agilityModifier > 37) {
        agilityModifier = 37;
    }
    //NSLog(@"Agi: %f, agiMod: %f", agility, agilityModifier);
}


- (void)decreaseAgilityModifierBy:(int)aMod {
	
	agilityModifier -= aMod;
	if (agility + agilityModifier < 0) {
		agilityModifier = -agility;
	} 
    if (agilityModifier < -37) {
        agilityModifier = -37;
    }
    //NSLog(@"Agi: %f, agiMod: %f", agility, agilityModifier);
}

- (void)increaseStaminaModifierBy:(int)aMod {
	
	if (staminaModifier == -stamina && aMod > stamina) {
		staminaModifier = 0;
	} else {
		staminaModifier += aMod;
	}
    if (staminaModifier > 37) {
        staminaModifier = 37;
    }
    //NSLog(@"Sta: %f, staMod: %f", stamina, staminaModifier);

}


- (void)decreaseStaminaModifierBy:(int)aMod {
	
	staminaModifier -= aMod;
	if (stamina + staminaModifier < 0) {
		staminaModifier = -level;
	} 
    if (staminaModifier < -37) {
        staminaModifier = -37;
    }
    //NSLog(@"Sta: %f, staMod: %f", stamina, staminaModifier);
}

- (void)increaseDexterityModifierBy:(int)aMod {
	
	if (dexterityModifier == -dexterity && aMod > dexterity) {
		dexterityModifier = 0;
	} else {
		dexterityModifier += aMod;
	}
    if (dexterityModifier > 37) {
        dexterityModifier = 37;
    }
    //NSLog(@"Dex: %f, dexMod: %f", dexterity, dexterityModifier);
}


- (void)decreaseDexterityModifierBy:(int)aMod {
	
	dexterityModifier -= aMod;
	if (dexterity + dexterityModifier < 0) {
		dexterityModifier = -dexterity;
	} 
    if (dexterityModifier < -37) {
        dexterityModifier = -37;
    }
    //NSLog(@"Dex: %f, dexMod: %f", dexterity, dexterityModifier);
}

- (void)increasePowerModifierBy:(int)aMod {
	
	if (powerModifier == -power && aMod > power) {
		powerModifier = 0;
	} else {
		powerModifier += aMod;
	}
    if (powerModifier > 37) {
        powerModifier = 37;
    }
    //NSLog(@"Power: %f, PowerModifier: %f", power, powerModifier);
}


- (void)decreasePowerModifierBy:(int)aMod {
	
	powerModifier -= aMod;
	if (power + powerModifier < 0) {
		powerModifier = -power;
	} 
    if (powerModifier < -37) {
        powerModifier = -37;
    }
    //NSLog(@"Power: %f, PowerModifier: %f", power, powerModifier);
}

- (void)increaseAffinityModifierBy:(int)aMod {
    if (affinityModifier == -affinity && aMod > affinity) {
        affinityModifier = 0;
    } else {
        affinityModifier += aMod;
    }
    if (affinityModifier > 37) {
        affinityModifier = 37;
    }
    //NSLog(@"Affinity: %f, AffinityModifier: %f", affinity, affinityModifier);
}

- (void)decreaseAffinityModifierBy:(int)aMod {
	
	affinityModifier -= aMod;
	if (affinity + affinityModifier < 0) {
		affinityModifier = -affinity;
	} 
    if (affinityModifier < -37) {
        affinityModifier = -37;
    }
    //NSLog(@"Affinity: %f, AffinityModifier: %f", affinity, affinityModifier);
}


- (void)increaseLuckModifierBy:(int)aMod {
	
	if (luckModifier == -luck && aMod > luck) {
		luckModifier = 0;
	} else {
		luckModifier += aMod;
	}
    if (luckModifier > 37) {
        luckModifier = 37;
    }
    //NSLog(@"Luck: %f, LuckModifier: %f", luck, luckModifier);

}

- (void)decreaseLuckModifierBy:(int)aMod {
	
	luckModifier -= aMod;
	if (luck + luckModifier < 0) {
		luckModifier = -luck;
	} 
    if (luckModifier < -37) {
        luckModifier = -37;
    }
    //NSLog(@"Luck: %f, LuckModifier: %f", luck, luckModifier);

}

- (void)youWereBlinded:(int)aBlindRoll {
	if (aBlindRoll > 0) {
		isBlind = YES;
		blindTimer = aBlindRoll;
	}
}

- (void)youWereParalyzed:(int)aParalyzeRoll {
	
	if (aParalyzeRoll > 0) {
		isParalyzed = YES;
		paralyzeTimer = aParalyzeRoll;
	}
}

- (void)youWereFatigued:(int)aFatigueRoll {
    
    if (isAlive) {
        if (aFatigueRoll > 0 && isMotivated == NO) {
            isFatigued = YES;
            fatigueTimer = aFatigueRoll;
            BattleStringAnimation *bsa = [[BattleStringAnimation alloc] initStatusString:@"Fatigued!" from:renderPoint];
            [sharedGameController.currentScene addObjectToActiveObjects:bsa];
            [bsa release];
        } else if (aFatigueRoll > 0 && isMotivated) {
            isMotivated = NO;
            motivatedTimer = 0;
            BattleStringAnimation *bsa = [[BattleStringAnimation alloc] initStatusString:@"deMotivated!" from:renderPoint];
            [sharedGameController.currentScene addObjectToActiveObjects:bsa];
            [bsa release];
        }

    }
    
}

- (void)youWereMotivated:(int)aMotivationRoll {
    
    if (isAlive) {
        if (aMotivationRoll > 0 && isFatigued == NO) {
            isMotivated = YES;
            motivatedTimer = aMotivationRoll;
        } else if (aMotivationRoll > 0 && isFatigued) {
            isFatigued = NO;
            fatigueTimer = 0;
        }
    }
   
}

- (void)youWereDrauraed:(int)aDrauraRoll {
    
    if (isAlive) {
        if (aDrauraRoll > 0 && isAuraed == NO) {
            isDrauraed = YES;
            drauraTimer = aDrauraRoll;
            BattleStringAnimation *drauraString = [[BattleStringAnimation alloc] initStatusString:@"Drauraed!" from:renderPoint];
            [sharedGameController.currentScene addObjectToActiveObjects:drauraString];
            [drauraString release];
        } else if (aDrauraRoll > 0 && isAuraed) {
            BattleStringAnimation *unAuraed = [[BattleStringAnimation alloc] initStatusString:@"deAurared!" from:renderPoint];
            [sharedGameController.currentScene addObjectToActiveObjects:unAuraed];
            [unAuraed release];
            isAuraed = NO;
            auraTimer = 0;
        }
    }
    
}

- (void)youWereAuraed:(int)aAuraRoll {
    
    if (isAlive) {
        if (aAuraRoll > 0 && isDrauraed == NO) {
            isAuraed = YES;
            auraTimer = aAuraRoll;
        } else if (aAuraRoll > 0 && isDrauraed) {
            isDrauraed = NO;
            drauraTimer = 0;
        }
    }
    
}

- (void)youWereDisoriented:(int)aDisorientedRoll {
    
    if (isAlive) {
        if (aDisorientedRoll > 0) {
            isDisoriented = YES;
            disorientedTimer = aDisorientedRoll;
            BattleStringAnimation *disoriented = [[BattleStringAnimation alloc] initStatusString:@"Disoriented!" from:renderPoint];
            [sharedGameController.currentScene addObjectToActiveObjects:disoriented];
            [disoriented release];
        }
    }
}

- (void)youWereHexed:(int)aHexRoll {
    
    if (aHexRoll > 0) {
        isHexed = YES;
        hexTimer = aHexRoll;
    }
}

- (void)youWereSlothed:(int)aSlothRoll {
    
    if (aSlothRoll > 0) {
        isSlothed = YES;
        slothTimer = aSlothRoll;
        if (isAlive) {
            BattleStringAnimation *slothed = [[BattleStringAnimation alloc] initStatusString:@"Slothed!" from:renderPoint];
            [sharedGameController.currentScene addObjectToActiveObjects:slothed];
            [slothed release];
        }
    }
}

- (void)unlockGeboPotential {}

- (void)unlockOthalaPotential {}

- (void)unlockOthalaEquippedPotential {}

- (void)enduranceDoesNotDeplete {
    enduranceDoesNotDeplete = YES;
}

- (void)enduranceDoesDeplete {
    
    enduranceDoesNotDeplete = NO;
}

- (void)gainElementalAttack:(int)aElement {
    
    switch (aElement) {
        case kWater:
            waterAttack++;
            break;
        case kSky:
            skyAttack++;
            break;
        case kRage:
            rageAttack++;
            break;
        case kLife:
            lifeAttack++;
            break;
        case kFire:
            fireAttack++;
            break;
        case kStone:
            stoneAttack++;
            break;
        case kWood:
            woodAttack++;
            break;
        case kPoison:
            poisonAttack++;
            break;
        case kDeath:
            deathAttack++;
            break;
        case kDivine:
            divineAttack++;
            break;
        default:
            break;
    }
}

- (void)loseElementalAttack:(int)aElement {
    
    switch (aElement) {
        case kWater:
            waterAttack--;
            if (waterAttack < 0) {
                waterAttack = 0;
            }
            break;
        case kSky:
            skyAttack--;
            if (skyAttack < 0) {
                skyAttack = 0;
            }
            break;
        case kRage:
            rageAttack--;
            if (rageAttack < 0) {
                rageAttack = 0;
            }
            break;
        case kLife:
            lifeAttack--;
            if (lifeAttack < 0) {
                lifeAttack = 0;
            }
            break;
        case kFire:
            fireAttack--;
            if (fireAttack < 0) {
                fireAttack = 0;
            }
            break;
        case kStone:
            stoneAttack--;
            if (stoneAttack < 0) {
                stoneAttack = 0;
            }
            break;
        case kWood:
            woodAttack--;
            if (woodAttack < 0) {
                woodAttack = 0;
            }
            break;
        case kPoison:
            poisonAttack--;
            if (poisonAttack < 0) {
                poisonAttack = 0;
            }
            break;
        case kDeath:
            deathAttack--;
            if (deathAttack < 0) {
                deathAttack = 0;
            }
            break;
        case kDivine:
            divineAttack--;
            if (divineAttack < 0) {
                divineAttack = 0;
            }
            break;
        default:
            break;
    }

}

- (void)gainElementalProtection:(int)aElement {
    
    switch (aElement) {
        case kWater:
            isProtectedFromWater++;
            break;
        case kSky:
            isProtectedFromSky++;
            break;
        case kRage:
            isProtectedFromRage++;
            break;
        case kLife:
            isProtectedFromLife++;
            break;
        case kFire:
            isProtectedFromFire++;
            break;
        case kStone:
            isProtectedFromStone++;
            break;
        case kWood:
            isProtectedFromWood++;
            break;
        case kPoison:
            isProtectedFromPoison++;
            break;
        case kDeath:
            isProtectedFromDeath++;
            break;
        case kDivine:
            isProtectedFromDivine++;
            break;
        default:
            break;
    }
}

- (void)loseElementalProtection:(int)aElement {
    
    switch (aElement) {
        case kWater:
            isProtectedFromWater--;
            if (isProtectedFromWater < 0) {
                isProtectedFromWater = 0;
            }
            break;
        case kSky:
            isProtectedFromSky--;
            if (isProtectedFromSky < 0) {
                isProtectedFromSky = 0;
            }
            break;
        case kRage:
            isProtectedFromRage--;
            if (isProtectedFromRage < 0) {
                isProtectedFromRage = 0;
            }
            break;
        case kLife:
            isProtectedFromLife--;
            if (isProtectedFromLife < 0) {
                isProtectedFromLife = 0;
            }
            break;
        case kFire:
            isProtectedFromFire--;
            if (isProtectedFromFire < 0) {
                isProtectedFromFire = 0;
            }
            break;
        case kStone:
            isProtectedFromStone--;
            if (isProtectedFromStone < 0) {
                isProtectedFromStone = 0;
            }
            break;
        case kWood:
            isProtectedFromWood--;
            if (isProtectedFromWood < 0) {
                isProtectedFromWood = 0;
            }
            break;
        case kPoison:
            isProtectedFromPoison--;
            if (isProtectedFromPoison < 0) {
                isProtectedFromPoison = 0;
            }
            break;
        case kDeath:
            isProtectedFromDeath--;
            if (isProtectedFromDeath < 0) {
                isProtectedFromDeath = 0;
            }
            break;
        case kDivine:
            isProtectedFromDivine--;
            if (isProtectedFromDivine < 0) {
                isProtectedFromDivine = 0;
            }
            break;
        default:
            break;
    }
    
}

- (void)youGainedDoubleHealing {
    
    receiveDoubleHealing = YES;
    BattleStringAnimation *bsa = [[BattleStringAnimation alloc] initStatusString:@"Healing x 2!" from:renderPoint];
    [sharedGameController.currentScene addObjectToActiveObjects:bsa];
    [bsa release];
}

- (void)youLostDoubleHealing {
    
    receiveDoubleHealing = NO;
    BattleStringAnimation *bsa = [[BattleStringAnimation alloc] initStatusString:@"Healing Regular" from:renderPoint];
    [sharedGameController.currentScene addObjectToActiveObjects:bsa];
    [bsa release];
}

- (void)youWereBerkanoed {
    
    if (isMotivated && motivatedTimer != -1) {
        isMotivated = NO;
    }
    if (isAuraed && auraTimer != -1) {
        isAuraed = NO;
    }
    if (levelModifier > 0) {
        levelModifier = 0;
    }
    if (strengthModifier > 0) {
        strengthModifier = 0;
    }
    if (staminaModifier > 0) {
        staminaModifier = 0;
    }
    if (agilityModifier > 0) {
        agilityModifier = 0;
    }
    if (dexterityModifier > 0) {
        dexterityModifier = 0;
    }
    if (powerModifier > 0) {
        powerModifier = 0;
    }
    if (affinityModifier > 0) {
        affinityModifier = 0;
    }
    if (luckModifier > 0) {
        luckModifier = 0;
    }
    BattleStringAnimation *bsa = [[BattleStringAnimation alloc] initStatusString:@"Berkanoed!" from:renderPoint];
    [sharedGameController.currentScene addObjectToActiveObjects:bsa];
    [bsa release];
}

- (void)gainProtectionFromDying {
    
    if (isAlive && !deathProtection) {
        BattleStringAnimation *deathPro = [[BattleStringAnimation alloc] initStatusString:@"Cannot Die!" from:renderPoint];
        [sharedGameController.currentScene addObjectToActiveObjects:deathPro];
        [deathPro release];
        deathProtection = YES;
    } else if (isAlive) {
        
        [BattleStringAnimation makeIneffectiveStringAt:renderPoint];
    }
}

- (void)loseProtectionFromDying {
    
    if (isAlive && deathProtection) {
        deathProtection = NO;
        BattleStringAnimation *deathPro = [[BattleStringAnimation alloc] initStatusString:@"Death Protection wore off" from:renderPoint];
        [sharedGameController.currentScene addObjectToActiveObjects:deathPro];
        [deathPro release];
    }
}

- (void)addToStatusDurations:(float)aDuration {
    
    if (isDrauraed) {
        drauraTimer += aDuration;
    }
    if (isFatigued) {
        fatigueTimer += aDuration;
    }
    if (isSlothed) {
        slothTimer += aDuration;
    }
    if (isHexed) {
        hexTimer += aDuration;
    }
    if (isDisoriented) {
        disorientedTimer += aDuration;
    }
}

- (void)youWillTakeDoubleDamage {
    willTakeDoubleDamage = YES;
}

- (void)gainDoubleEffect {
    
    doubleEffect = YES;
}

- (void)youWillNotLoseEndurance {
    
    enduranceDoesNotDeplete = YES;
}

- (void)youWillLoseEndurance {
    
    enduranceDoesNotDeplete = NO;
}

- (void)youWillLoseHalfEndurance {
    
    halfEnduranceExpenditure = YES;
}

- (void)youWillNotLoseHalfEndurance {
    
    halfEnduranceExpenditure = NO;
}

- (void)attacksWillCauseBleeders {
    
    attacksCauseBleeders = YES;
}

- (void)attacksWillNotCauseBleeders {
    
    attacksCauseBleeders = NO;
}

- (void)gainAutoRaise {
    
    autoRaise = YES;
}

- (void)loseAutoRaise {
    
    autoRaise = NO;
}

- (void)gainDrainAttack {
    
    drainAttack = YES;
}

- (void)loseDrainAttack {
    
    drainAttack = NO;
}

@end

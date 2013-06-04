//
//  BattleRoderick.m
//  TEORBattleTest
//
//  Created by Zach Babb on 5/25/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "BattleRoderick.h"
#import "Animation.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleEnemy.h"
#import "PackedSpriteSheet.h"
#import "Image.h"
#import "BattleValkyrie.h"
#import "BattlePriest.h"
#import "RaidhoSingleCharacter.h"
#import "FirstSwordSlash.h"
#import "Bleeder.h"
#import "AnsuzSingleEnemy.h"
#import "AnsuzSingleCharacter.h"
#import "AnsuzAllEnemies.h"
#import "AnsuzAllCharacters.h"
#import "IsaSingleEnemy.h"
#import "IsaAllEnemies.h"
#import "IsaSingleCharacter.h"
#import "IsaAllCharacters.h"
#import "OthalaSingleEnemy.h"
#import "OthalaAllEnemies.h"
#import "GromanthSingleEnemy.h"
#import "GromanthAllEnemies.h"
#import "GromanthSingleCharacter.h"
#import "GromanthAllCharacters.h"
#import "NordrinSingleEnemy.h"
#import "NordrinAllEnemies.h"
#import "NordrinSingleCharacter.h"
#import "NordrinAllCharacters.h"
#import "SudrinSingleEnemy.h"
#import "SudrinAllEnemies.h"
#import "SudrinSingleCharacter.h"
#import "SudrinAllCharacters.h"
#import "AustrinSingleEnemy.h"
#import "AustrinAllEnemies.h"
#import "AustrinSingleCharacter.h"
#import "AustrinAllCharacters.h"
#import "VestrinSingleEnemy.h"
#import "VestrinAllEnemies.h"
#import "VestrinSingleCharacter.h"
#import "VestrinAllCharacters.h"


@implementation BattleRoderick

@synthesize battles;
@synthesize hasLearnedElemental;

- (id)initWithBattleLocation:(int)aLocation {
	
	if (self = [super init]) {
		
		Image *roderick = [sharedGameController.teorPSS imageForKey:@"RoderickFacingForward50x80.png"];
		currentTurnAnimation = [[Animation alloc] init];
		[currentTurnAnimation addFrameWithImage:roderick delay:0.3];
		currentTurnAnimation.state = kAnimationState_Stopped;
		[roderick release];
		currentAnimation = currentTurnAnimation;
		battleLocation = aLocation;
		whichCharacter = kRoderick;
		[super initBattleAttributes];
		/*switch (battleLocation) {
			case 0:
				rect = CGRectMake(20, 240, 60, 120);
				renderPoint = CGPointMake(45, 300);
				timerRect.renderPoint = CGPointMake(20, 240);
				timer.renderPoint = CGPointMake(21, 241);
				break;
			case 1:
				rect = CGRectMake(20, 120, 60, 120);
				renderPoint = CGPointMake(45, 180);
				timerRect.renderPoint = CGPointMake(20, 120);
				timer.renderPoint = CGPointMake(21, 121);
				break;
			case 2:
				rect = CGRectMake(20, 0, 60, 120);
				renderPoint = CGPointMake(45, 60);
				timerRect.renderPoint = CGPointMake(20, 0);
				timer.renderPoint = CGPointMake(21, 1);
				break;
			default:
				break;
		}*/
		isDisoriented = YES;
        disorientedTimer = 50;
		selectorImage.renderPoint = CGPointMake(renderPoint.x, renderPoint.y - 40);
		essenceColor = essenceMeter.color = Color4fMake(0, 0, 1.0, 1.0);
        hasLearnedElemental = NO;
	}
	
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	[super updateWithDelta:aDelta];
}

- (void)render {
	
	[super render];
}
		
- (void)resetBattleTimer {
	
	battleTimer = 0.0;
	currentTurn = NO;
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
            FirstSwordSlash *fss = [[FirstSwordSlash alloc] initToEnemy:aEnemy waiting:i + 0.5];
            [sharedGameController.currentScene addObjectToActiveObjects:fss];
            [fss release];
            doubleAttack--;
        }
        if (attackAttacksAllEnemies) {
            for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
                if ([enemy isKindOfClass:[AbstractBattleEnemy class]] && enemy.isAlive && enemy != aEnemy) {
                    //Maybe make a fresh object here that's the same for everyone.
                    FirstSwordSlash *extraAttack = [[FirstSwordSlash alloc] initToEnemy:enemy waiting:0.3];
                    [sharedGameController.currentScene addObjectToActiveObjects:extraAttack];
                    [extraAttack release];
                }
            }
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
        if (attacksAddToStatusTimers) {
            [aEnemy addToStatusDurations:1];
        }
        if (attacksAddToRageMeter) {
            BattleValkyrie *valk = [sharedGameController.battleCharacters objectForKey:@"BattleValkyrie"];
            valk.rageMeter += 1;
        }
        
        FirstSwordSlash *fss = [[FirstSwordSlash alloc] initToEnemy:aEnemy waiting:i];
        [sharedGameController.currentScene addObjectToActiveObjects:fss];
        [fss release];

    }
    int enduranceLost = 10 + (level * 0.2);

    if (enduranceDoesNotDeplete) {
        enduranceLost = 0;
    }
    if (halfEnduranceExpenditure) {
        enduranceLost /= 2;
    }
    endurance -= enduranceLost;

}

- (void)queueRune:(int)aRune {
	
	[super queueRune:aRune];
	[sharedInputManager setState:kRoderickRunePlacement];
}

- (void)runeWasPlacedOnEnemy:(AbstractBattleEnemy *)aEnemy {
	
	[super runeWasPlacedOnEnemy:aEnemy];
	switch (queuedRuneNumber) {
		case 201:
			queuedRuneNumber = 0;
			[AnsuzSingleEnemy youWerePlacedOnEnemy:aEnemy];
            essence -= 10;
			break;
        case 53:
            queuedRuneNumber = 0;
            IsaSingleEnemy *ise = [[IsaSingleEnemy alloc] initToEnemy:aEnemy];
            [sharedGameController.currentScene addObjectToActiveObjects:ise];
            [ise release];
            essence -= 7;
            break;
        case 332:
            queuedRuneNumber = 0;
            OthalaSingleEnemy *ose = [[OthalaSingleEnemy alloc] initToEnemy:aEnemy];
            [sharedGameController.currentScene addObjectToActiveObjects:ose];
            [ose release];
            essence -= 10;
            break;
        case 179:
            queuedRuneNumber = 0;
            GromanthSingleEnemy *gse = [[GromanthSingleEnemy alloc] initToEnemy:aEnemy];
            [sharedGameController.currentScene addObjectToActiveObjects:gse];
            [gse release];
            essence -= 12;
            break;
        case 129:
            queuedRuneNumber = 0;
            NordrinSingleEnemy *nse = [[NordrinSingleEnemy alloc] initToEnemy:aEnemy];
            [sharedGameController.currentScene addObjectToActiveObjects:nse];
            [nse release];
            essence -= 40;
            break;
        case 111:
            queuedRuneNumber = 0;
            SudrinSingleEnemy *sse = [[SudrinSingleEnemy alloc] initToEnemy:aEnemy];
            [sharedGameController.currentScene addObjectToActiveObjects:sse];
            [sse release];
            essence -= 18;
            break;
        case 69:
            queuedRuneNumber = 0;
            AustrinSingleEnemy *ase = [[AustrinSingleEnemy alloc] initToEnemy:aEnemy];
            [sharedGameController.currentScene addObjectToActiveObjects:ase];
            [ase release];
            essence -= 15;
            break;
        case 39:
            queuedRuneNumber = 0;
            VestrinSingleEnemy *vse = [[VestrinSingleEnemy alloc] initToEnemy:aEnemy];
            [sharedGameController.currentScene addObjectToActiveObjects:vse];
            [vse release];
            essence -= 30;
            break;
		default:
			break;
	}
}

- (void)runeWasPlacedOnCharacter:(AbstractBattleCharacter *)aCharacter {
	
	[super runeWasPlacedOnCharacter:aCharacter];
	switch (queuedRuneNumber) {
		case 201:
			queuedRuneNumber = 0;
			AnsuzSingleCharacter *asc = [[AnsuzSingleCharacter alloc] initToCharacter:aCharacter];
			[sharedGameController.currentScene addObjectToActiveObjects:asc];
			[asc release];
            essence -= 8;
			break;
        case 53:
            queuedRuneNumber = 0;
            [IsaSingleCharacter grantWaterElementTo:aCharacter];
            essence -= 10;
            break;
        case 179:
            queuedRuneNumber = 0;
            GromanthSingleCharacter *gsc = [[GromanthSingleCharacter alloc] initToCharacter:aCharacter];
            [sharedGameController.currentScene addObjectToActiveObjects:gsc];
            [gsc release];
            essence -= 8;
            break;
        case 129:
            queuedRuneNumber = 0;
            NordrinSingleCharacter *nsc = [[NordrinSingleCharacter alloc] initToCharacter:aCharacter];
            [sharedGameController.currentScene addObjectToActiveObjects:nsc];
            [nsc release];
            essence -= 20;
            break;
        case 111:
            queuedRuneNumber = 0;
            SudrinSingleCharacter *ssc = [[SudrinSingleCharacter alloc] initToCharacter:aCharacter];
            [sharedGameController.currentScene addObjectToActiveObjects:ssc];
            [ssc release];
            essence -= 80;
            break;
        case 69:
            queuedRuneNumber = 0;
            AustrinSingleCharacter *ausc = [[AustrinSingleCharacter alloc] initToCharacter:aCharacter];
            [sharedGameController.currentScene addObjectToActiveObjects:ausc];
            [ausc release];
            essence -= 24;
            break;
        case 39:
            queuedRuneNumber = 0;
            [VestrinSingleCharacter grantSkyElementTo:aCharacter];
            essence -= 15;
            break;
		default:
			break;
	}
}

- (void)runeAffectedAllEnemies {
	
	[super runeAffectedAllEnemies];
	switch (queuedRuneNumber) {
		case 201:
			queuedRuneNumber = 0;
			AnsuzAllEnemies *aae = [[AnsuzAllEnemies alloc] init];
			[sharedGameController.currentScene addObjectToActiveObjects:aae];
			[aae release];
            essence -= maxEssence / 2;
            break;
        case 53:
            queuedRuneNumber = 0;
            IsaAllEnemies *iae = [[IsaAllEnemies alloc] init];
            [sharedGameController.currentScene addObjectToActiveObjects:iae];
            [iae release];
            essence -= 12;
            break;
        case 332:
            queuedRuneNumber = 0;
            OthalaAllEnemies *oae = [[OthalaAllEnemies alloc] init];
            [sharedGameController.currentScene addObjectToActiveObjects:oae];
            [oae release];
            essence -= 14;
            break;
        case 179:
            queuedRuneNumber = 0;
            GromanthAllEnemies *gae = [[GromanthAllEnemies alloc] init];
            [sharedGameController.currentScene addObjectToActiveObjects:gae];
            [gae release];
            essence -= 20;
            break;
        case 129:
            queuedRuneNumber = 0;
            NordrinAllEnemies *nae = [[NordrinAllEnemies alloc] init];
            [sharedGameController.currentScene addObjectToActiveObjects:nae];
            [nae release];
            essence -= 60;
            break;
        case 111:
            queuedRuneNumber = 0;
            SudrinAllEnemies *sae = [[SudrinAllEnemies alloc] init];
            [sharedGameController.currentScene addObjectToActiveObjects:sae];
            [sae release];
            essence -= 30;
            break;
        case 69:
            queuedRuneNumber = 0;
            AustrinAllEnemies *auae = [[AustrinAllEnemies alloc] init];
            [sharedGameController.currentScene addObjectToActiveObjects:auae];
            [auae release];
            essence -= 20;
            break;
        case 39:
            queuedRuneNumber = 0;
            VestrinAllEnemies *vae = [[VestrinAllEnemies alloc] init];
            [sharedGameController.currentScene addObjectToActiveObjects:vae];
            [vae release];
            essence -= 25;
            break;
		default:
			break;
	}
}

- (void)runeAffectedAllCharacters {
	
	[super runeAffectedAllCharacters];
	switch (queuedRuneNumber) {
		case 201:
			queuedRuneNumber = 0;
			AnsuzAllCharacters *aac = [[AnsuzAllCharacters alloc] init];
			[sharedGameController.currentScene addObjectToActiveObjects:aac];
			[aac release];
            essence -= 16;
			break;
        case 53:
            queuedRuneNumber = 0;
            [IsaAllCharacters grantWaterShields];
            essence -= 15;
            break;
            
        case 179:
            queuedRuneNumber = 0;
            GromanthAllCharacters *gac = [[GromanthAllCharacters alloc] init];
            [sharedGameController.currentScene addObjectToActiveObjects:gac];
            [gac release];
            essence -= 10;
            break;
        case 129:
            queuedRuneNumber = 0;
            NordrinAllCharacters *nac = [[NordrinAllCharacters alloc] init];
            [sharedGameController.currentScene addObjectToActiveObjects:nac];
            [nac release];
            essence -= 18;
            break;
        case 111:
            queuedRuneNumber = 0;
            [SudrinAllCharacters healAllCharacters];
            essence -= 25;
            break;
        case 69:
            queuedRuneNumber = 0;
            [AustrinAllCharacters healCharacterEssences];
            essence -= 20;
            break;
        case 39:
            queuedRuneNumber = 0;
            [VestrinAllCharacters grantSkyShields];
            essence -= 14;
            break;
		default:
			break;
	}
}

- (void)unlockGeboPotential {
    
    if (geboPotential) {
        return;
    }
    waterAffinity += 5;
    skyAffinity += 5;
    [self increasePowerModifierBy:5];
    [self increaseStaminaModifierBy:5];
    geboPotential = YES;
}

- (void)unlockOthalaPotential {
    
    if (othalaPotential) {
        return;
    }
    waterAffinity += 10;
    skyAffinity += 10;
    [self increasePowerModifierBy:10];
    [self increaseStaminaModifierBy:10];
    othalaPotential = YES;
}

- (void)unlockOthalaEquippedPotential {
    
    waterAffinity += 10;
    skyAffinity += 10;
    [self increasePowerModifierBy:10];
    [self increaseStaminaModifierBy:10];
}

- (int)calculateAttackDamageTo:(AbstractBattleEnemy *)aEnemy {
    
    float tempDamage = ((strength + strengthModifier) * 5.5) - (aEnemy.dexterity + aEnemy.dexterityModifier + aEnemy.agility + aEnemy.agilityModifier + aEnemy.stamina + aEnemy.staminaModifier);
    ////NSLog(@"((%f + %f) * 4) - (%f + %f + %f + %f + %f + %f) = ?", strength, strengthModifier, aEnemy.dexterity, aEnemy.dexterityModifier, aEnemy.agility, aEnemy.agilityModifier, aEnemy.stamina, aEnemy.staminaModifier);
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
    if (tempDamage < 0) {
        return 0;
    }
    tempDamage *= (endurance / maxEndurance);
    if (endurance < 0) {
        return 0;
    }
    tempDamage += (arc4random() % (int)(level + levelModifier + 10));
    
    if (doubleEffect) {
        for (RaidhoSingleCharacter *obj in sharedGameController.currentScene.activeObjects) {
            if ([obj isMemberOfClass:[RaidhoSingleCharacter class]]) {
                [obj enhanceEffectTo:aEnemy];
            }
        }
        tempDamage *= 2;
        doubleEffect = NO;
    }
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

- (void)youTookDamage:(int)aDamage {
    //BattleStringAnimation *bsa = [[BattleStringAnimation alloc] initDamageString:[NSString stringWithFormat:@"%d", aDamage] from:renderPoint];
    //[sharedGameController.currentScene addObjectToActiveObjects:bsa];
    //[bsa release];
    [super youTookDamage:aDamage];
    if (sharedGameController.realm == kRealm_ChapterOneChampionBattle && isAlive == NO) {
        [sharedGameController.currentScene moveToNextStageInScene];
    }

}

- (int)calculateIsaDamageTo:(AbstractBattleEnemy *)aEnemy {
    
    float isaDamage = (power + powerModifier) * 3 - (aEnemy.affinity + aEnemy.affinityModifier);
    isaDamage += (waterAffinity - aEnemy.waterAffinity) * 3;
    isaDamage *= (essence / maxEssence);
    if (aEnemy.isProtectedFromWater > 0) {
        isaDamage /= 2;
        [aEnemy loseElementalProtection:kWater];
    }
    if (doubleEffect) {
        for (RaidhoSingleCharacter *obj in sharedGameController.currentScene.activeObjects) {
            if ([obj isMemberOfClass:[RaidhoSingleCharacter class]]) {
                [obj enhanceEffectTo:aEnemy];
            }
        }
        isaDamage *= 2;
        doubleEffect = NO;
    }
    return (int)isaDamage;
}

- (int)calculateOthalaDamageTo:(AbstractBattleEnemy *)aEnemy {
    
    if (doubleEffect) {
        for (RaidhoSingleCharacter *obj in sharedGameController.currentScene.activeObjects) {
            if ([obj isMemberOfClass:[RaidhoSingleCharacter class]]) {
                [obj enhanceEffectTo:aEnemy];
            }
        }
        doubleEffect = NO;
        return battles * 4;
    }
    return battles * 2;
}

- (int)calculateGromanthDurationTo:(AbstractBattleEnemy *)aEnemy {
    
    float gromanthDuration = (power + powerModifier) - (aEnemy.affinity + aEnemy.affinityModifier) + (level + levelModifier - aEnemy.level - aEnemy.levelModifier);
    gromanthDuration += (waterAffinity - aEnemy.waterAffinity);
    gromanthDuration *= (essence / maxEssence);
    if (gromanthDuration < 0) {
        gromanthDuration = 0;
    }
    if (doubleEffect) {
        for (RaidhoSingleCharacter *obj in sharedGameController.currentScene.activeObjects) {
            if ([obj isMemberOfClass:[RaidhoSingleCharacter class]]) {
                [obj enhanceEffectTo:aEnemy];
            }
        }
        gromanthDuration *= 2;
        doubleEffect = NO;
    }
    return (int)gromanthDuration;
}

- (float)calculateGromanthAffinityTimeTo:(AbstractBattleEnemy *)aEnemy {
    
    float gromanthTime = ((power + powerModifier) - (aEnemy.affinity + aEnemy.affinityModifier)) * (waterAffinity / aEnemy.waterAffinity) * (essence / maxEssence) * 2;
    if (doubleEffect) {
        for (RaidhoSingleCharacter *obj in sharedGameController.currentScene.activeObjects) {
            if ([obj isMemberOfClass:[RaidhoSingleCharacter class]]) {
                [obj enhanceEffectTo:aEnemy];
            }
            gromanthTime *= 2;
            doubleEffect = NO;
        }
        return gromanthTime;
    }
    
    return ((power + powerModifier) - (aEnemy.affinity + aEnemy.affinityModifier)) * (waterAffinity / aEnemy.waterAffinity) * (essence / maxEssence);
}

- (float)calculateGromanthAffinityTimeToCharacter:(AbstractBattleCharacter *)aCharacter {
    
    return ((power + powerModifier) + ((waterAffinity + aCharacter.waterAffinity) / 2)) * (essence / maxEssence);
}

- (int)calculateNordrinDamageTo:(AbstractBattleEnemy *)aEnemy {
    
    float tempDamage = ((power + powerModifier) * 10) - (aEnemy.affinity + aEnemy.affinityModifier);
    tempDamage *= (waterAffinity / aEnemy.waterAffinity);
    tempDamage *= (skyAffinity / aEnemy.skyAffinity);
    tempDamage *= (essence / maxEssence);
    if (doubleEffect) {
        for (RaidhoSingleCharacter *obj in sharedGameController.currentScene.activeObjects) {
            if ([obj isMemberOfClass:[RaidhoSingleCharacter class]]) {
                [obj enhanceEffectTo:aEnemy];
            }
        }
        tempDamage *= 2;
        doubleEffect = NO;
    }
    return (int)tempDamage;
}

- (int)calculateSudrinDurationTo:(AbstractBattleEnemy *)aEnemy {
    
    float sudrinDuration = ((power + powerModifier) - (aEnemy.affinity + aEnemy.affinityModifier) + (level + levelModifier - aEnemy.level - aEnemy.levelModifier));
    sudrinDuration += (skyAffinity - aEnemy.skyAffinity);
    sudrinDuration *= (essence / maxEssence);
    if (sudrinDuration < 0) {
        sudrinDuration = 0;
    }
    if (doubleEffect) {
        for (RaidhoSingleCharacter *obj in sharedGameController.currentScene.activeObjects) {
            if ([obj isMemberOfClass:[RaidhoSingleCharacter class]]) {
                [obj enhanceEffectTo:aEnemy];
            }
        }
        sudrinDuration *= 2;
        doubleEffect = NO;
    }
    return (int)sudrinDuration;
}

- (float)calculateAustrinDurationTo:(AbstractBattleEnemy *)aEnemy {
    
    float austrinDuration = ((affinity + affinityModifier) - (aEnemy.affinity + aEnemy.affinityModifier) + (level + levelModifier - aEnemy.level - aEnemy.levelModifier));
    austrinDuration *= (skyAffinity / aEnemy.skyAffinity);
    //NSLog(@"aEnemy.skyAffinity is %f", aEnemy.skyAffinity);
    austrinDuration *= (essence / maxEssence);
    if (austrinDuration < 0) {
        austrinDuration = 0;
    }
    if (doubleEffect) {
        for (RaidhoSingleCharacter *obj in sharedGameController.currentScene.activeObjects) {
            if ([obj isMemberOfClass:[RaidhoSingleCharacter class]]) {
                [obj enhanceEffectTo:aEnemy];
            }
        }
        austrinDuration *= 2;
        doubleEffect = NO;
    }
    return austrinDuration;
}

- (int)calculateAustrinDamageTo:(AbstractBattleEnemy *)aEnemy {
    
    float austrinDamage = (((power + powerModifier) * skyAffinity) - ((aEnemy.affinity + aEnemy.affinityModifier) * aEnemy.skyAffinity));
    austrinDamage *= (essence / maxEssence);
    if (doubleEffect) {
        for (RaidhoSingleCharacter *obj in sharedGameController.currentScene.activeObjects) {
            if ([obj isMemberOfClass:[RaidhoSingleCharacter class]]) {
                [obj enhanceEffectTo:aEnemy];
            }
        }
        austrinDamage *= 2;
        doubleEffect = NO;
    }
    return (int)austrinDamage;
}

- (float)calculateAustrinCharacterDurationTo:(AbstractBattleCharacter *)aCharacter {
    
    float austrinDuration = ((affinity + affinityModifier + ((skyAffinity + aCharacter.skyAffinity) / 2) + ((level + levelModifier) / 10)));
    austrinDuration *= (essence / maxEssence);
    //NSLog(@"AustrinDuration is %f", austrinDuration);
    if (doubleEffect) {
        for (RaidhoSingleCharacter *obj in sharedGameController.currentScene.activeObjects) {
            if ([obj isMemberOfClass:[RaidhoSingleCharacter class]]) {
                [obj enhanceEffectTo:aCharacter];
            }
        }
        austrinDuration *= 2;
        doubleEffect = NO;
    }
    return austrinDuration;
                              
}

- (float)calculateVestrinDurationTo:(AbstractBattleEnemy *)aEnemy {
    
    float vestrinDuration = ((power + powerModifier) * (skyAffinity / aEnemy.skyAffinity));
    vestrinDuration *= (essence / maxEssence);
    if (doubleEffect) {
        for (RaidhoSingleCharacter *obj in sharedGameController.currentScene.activeObjects) {
            if ([obj isMemberOfClass:[RaidhoSingleCharacter class]]) {
                [obj enhanceEffectTo:aEnemy];
            }
        }
        vestrinDuration *= 2;
        doubleEffect = NO;
    }
    return vestrinDuration;
}

- (int)calculateVestrinDamageTo:(AbstractBattleEnemy *)aEnemy {
    
    float vestrinDamage = ((power + powerModifier + (skyAffinity - aEnemy.skyAffinity)) * 5 - (aEnemy.affinity + aEnemy.affinityModifier));
    vestrinDamage *= (essence / maxEssence);
    if (doubleEffect) {
        for (RaidhoSingleCharacter *obj in sharedGameController.currentScene.activeObjects) {
            if ([obj isMemberOfClass:[RaidhoSingleCharacter class]]) {
                [obj enhanceEffectTo:aEnemy];
            }
        }
        vestrinDamage *= 2;
        doubleEffect = NO;
    }
    return (int)vestrinDamage;
}

- (float)calculateVestrinRollTo:(AbstractBattleEnemy *)aEnemy {
    
    float vestrinRoll = (level + levelModifier + skyAffinity + (RANDOM_0_TO_1() * (luck + luckModifier)));
    vestrinRoll *= (essence / maxEssence);
    if (doubleEffect) {
        for (RaidhoSingleCharacter *obj in sharedGameController.currentScene.activeObjects) {
            if ([obj isMemberOfClass:[RaidhoSingleCharacter class]]) {
                [obj enhanceEffectTo:aEnemy];
            }
        }
        vestrinRoll *= 2;
        doubleEffect = NO;
    }
    return (int)vestrinRoll;
}

@end

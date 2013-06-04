//
//  BattleValkyrie.m
//  TEORBattleTest
//
//  Created by Zach Babb on 5/25/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "BattleValkyrie.h"
#import "AbstractBattleEnemy.h"
#import "AbstractScene.h"
#import "OverMind.h"
#import "Animation.h"
#import "Image.h"
#import "GameController.h"
#import "PackedSpriteSheet.h"
#import "FirstSpearPoke.h"
#import "SpearShower.h"
#import "BattlePriest.h"
#import "Bleeder.h"
#import "RaidhoSingleCharacter.h"
#import "SowiloSingleEnemy.h"
#import "SowiloAllEnemies.h"
#import "SowiloSingleCharacter.h"
#import "SowiloAllCharacters.h"
#import "HagalazSingleEnemy.h"
#import "HagalazAllEnemies.h"
#import "HagalazSingleCharacter.h"
#import "HagalazAllCharacters.h"
#import "JeraSingleEnemy.h"
#import "JeraAllEnemies.h"
#import "JeraSingleCharacter.h"
#import "JeraAllCharacters.h"
#import "NauthizSingleEnemy.h"
#import "NauthizAllEnemies.h"
#import "NauthizAllCharacters.h"
#import "NauthizSingleCharacter.h"
#import "BerkanoSingleEnemy.h"
#import "BerkanoAllEnemies.h"
#import "BerkanoSingleCharacter.h"
#import "BerkanoAllCharacters.h"
#import "PrimazSingleEnemy.h"
#import "PrimazAllEnemies.h"
#import "PrimazSingleCharacter.h"
#import "PrimazAllCharacters.h"
#import "AkathSingleEnemy.h"
#import "AkathAllEnemies.h"
#import "AkathSingleCharacter.h"
#import "AkathAllCharacters.h"
#import "HolgethSingleEnemy.h"
#import "HolgethAllEnemies.h"
#import "HolgethSingleCharacter.h"
#import "HolgethAllCharacters.h"




@implementation BattleValkyrie

@synthesize rageMeter;
@synthesize damageDealt;

- (id)initWithBattleLocation:(int)aLocation {
	
	if (self = [super init]) {
		
		//Image *valkyrie = [sharedGameController.teorPSS imageForKey:@"Valkyrie50x80.png"];
        Image *valkyrie = [[Image alloc] initWithImageNamed:@"Alexdottir_4x_ready.png" filter:GL_LINEAR];
        valkyrie.scale = Scale2fMake(0.25, 0.25);
		currentTurnAnimation = [[Animation alloc] init];
		[currentTurnAnimation addFrameWithImage:valkyrie delay:0.3];
		currentTurnAnimation.state = kAnimationState_Stopped;
		[valkyrie release];
        Image *valkSelected = [[Image alloc] initWithImageNamed:@"Alexdottir_4x_attack.png" filter:GL_LINEAR];
        valkSelected.scale = Scale2fMake(0.25, 0.25);
		selected = [[Animation alloc] init];
		[selected addFrameWithImage:valkSelected delay:0.3];
		selected.state = kAnimationState_Stopped;
		[valkSelected release];
		currentAnimation = currentTurnAnimation;
		battleLocation = aLocation;
		whichCharacter = kValkyrie;
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
		selectorImage.renderPoint = CGPointMake(renderPoint.x, renderPoint.y - 40);
		target = [sharedGameController.teorPSS imageForKey:@"Target40x40.png"];
		essenceColor = essenceMeter.color = Color4fMake(1.0, 0.2, 0.0, 1.0);
        rageTarget = nil;
		rageMeter = 10;
		
	}
	
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	[super updateWithDelta:aDelta];
	if (rageMeter < 0 && rageTarget) {
		[self rageTriggered];
	}
}

- (CGPoint)getTargetPoint {
	
	return target.renderPoint;
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
            FirstSpearPoke *fss = [[FirstSpearPoke alloc] initToEnemy:aEnemy waiting:0.5];
            [sharedGameController.currentScene addObjectToActiveObjects:fss];
            [fss release];
            doubleAttack--;
        }
        if (attackAttacksAllEnemies) {
            for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
                if ([enemy isKindOfClass:[AbstractBattleEnemy class]] && enemy.isAlive && enemy != aEnemy) {
                    //Maybe make a fresh object here that's the same for everyone.
                    FirstSpearPoke *extraAttack = [[FirstSpearPoke alloc] initToEnemy:enemy waiting:0.3];
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
            rageMeter -= 1;
        }
        if (attacksAddToStatusTimers) {
            [aEnemy addToStatusDurations:1];
        }
        
        FirstSpearPoke *fss = [[FirstSpearPoke alloc] initToEnemy:aEnemy waiting:i];
        [sharedGameController.currentScene addObjectToActiveObjects:fss];
        [fss release];

    }
	
    int enduranceLost = 8 + (level * 0.2);
    if (enduranceDoesNotDeplete) {
        enduranceLost = 0;
    }
    if (halfEnduranceExpenditure) {
        enduranceLost /= 2;
    }

    endurance -= enduranceLost;

}

- (void)rageWasLinkedToEnemy:(AbstractBattleEnemy *)aEnemy {
	
	rageTarget = aEnemy;
	[self rageTriggered];
}

- (void)rageTriggered {
    if (rageMeter < 0) {
        rageMeter = 0;
    }
	if (rageTarget && rageTarget.isAlive && rageMeter < (maxHP + (level * 2)) * 0.5) {
		SpearShower *ss = [[SpearShower alloc] initToEnemy:rageTarget];
		[sharedGameController.currentScene addObjectToActiveObjects:ss];
		[ss release]; 
        rageMeter = maxHP + (level * 2);
	}
    if (!rageTarget.isAlive) {
        rageTarget = nil;
    }
}

- (void)updateTargetLocationWithAcceleration:(UIAcceleration *)aAcceleration {
	
	target.renderPoint = CGPointMake(target.renderPoint.x - (aAcceleration.y * 5), target.renderPoint.y + (aAcceleration.x * 5));
}

- (void)resetBattleTimer {
	
	battleTimer = 0.0;
	currentTurn = NO;
}

- (void)queueRune:(int)aRune {
	
	[super queueRune:aRune];
	[sharedInputManager setState:kValkyrieRunePlacement];
}

- (void)runeWasPlacedOnEnemy:(AbstractBattleEnemy *)aEnemy {
	
	[super runeWasPlacedOnEnemy:aEnemy];
	switch (queuedRuneNumber) {
		case 253:
			queuedRuneNumber = 0;
			SowiloSingleEnemy *sse = [[SowiloSingleEnemy alloc] initToEnemy:aEnemy];
			[sharedGameController.currentScene addObjectToActiveObjects:sse];
			[sse release];
            essence -= 10;
			break;
        case 165:
            queuedRuneNumber = 0;
            HagalazSingleEnemy *hse = [[HagalazSingleEnemy alloc] initToEnemy:aEnemy];
            [sharedGameController.currentScene addObjectToActiveObjects:hse];
            [hse release];
            essence -= 15;
            break;
        case 245:
            queuedRuneNumber = 0;
            JeraSingleEnemy *jse = [[JeraSingleEnemy alloc] initToEnemy:aEnemy];
            [sharedGameController.currentScene addObjectToActiveObjects:jse];
            [jse release];
            essence -= 30;
            break;
        case 116:
            queuedRuneNumber = 0;
            NauthizSingleEnemy *nse = [[NauthizSingleEnemy alloc] initToEnemy:aEnemy];
            [sharedGameController.currentScene addObjectToActiveObjects:nse];
            [nse release];
            essence -= 20;
            break;
        case 375:
            queuedRuneNumber = 0;
            BerkanoSingleEnemy *bse = [[BerkanoSingleEnemy alloc] initToEnemy:aEnemy];
            [sharedGameController.currentScene addObjectToActiveObjects:bse];
            [bse release];
            essence -= 25;
            break;
        case 56:
            queuedRuneNumber = 0;
            PrimazSingleEnemy *pse = [[PrimazSingleEnemy alloc] initToEnemy:aEnemy];
            [sharedGameController.currentScene addObjectToActiveObjects:pse];
            [pse release];
            essence -= 15;
            break;
        case 217:
            queuedRuneNumber = 0;
            AkathSingleEnemy *ase = [[AkathSingleEnemy alloc] initToEnemy:aEnemy];
            [sharedGameController.currentScene addObjectToActiveObjects:ase];
            [ase release];
            essence -= 21;
            break;
        case 286:
            queuedRuneNumber = 0;
            HolgethSingleEnemy *hose = [[HolgethSingleEnemy alloc] initToEnemy:aEnemy];
            [sharedGameController.currentScene addObjectToActiveObjects:hose];
            [hose release];
            essence -= 24;
            break;
		default:
			break;
	}
}

- (void)runeWasPlacedOnCharacter:(AbstractBattleCharacter *)aCharacter {
	
	[super runeWasPlacedOnCharacter:aCharacter];
	switch (queuedRuneNumber) {
		case 253:
			queuedRuneNumber = 0;
			SowiloSingleCharacter *ssc = [[SowiloSingleCharacter alloc] initToCharacter:aCharacter];
			[sharedGameController.currentScene addObjectToActiveObjects:ssc];
			[ssc release];
            essence -= 10;
			break;
        case 165:
            queuedRuneNumber = 0;
            HagalazSingleCharacter *hsc = [[HagalazSingleCharacter alloc] initToCharacter:aCharacter];
            [sharedGameController.currentScene addObjectToActiveObjects:hsc];
            [hsc release];
            essence -= 15;
            break;
        case 245:
            queuedRuneNumber = 0;
            JeraSingleCharacter *jsc = [[JeraSingleCharacter alloc] initToCharacter:aCharacter];
            [sharedGameController.currentScene addObjectToActiveObjects:jsc];
            [jsc release];
            essence -= 22;
            break;
        case 116:
            queuedRuneNumber = 0;
            [NauthizSingleCharacter grantLifeAttackTo:aCharacter];
            essence -= 12;
            break;
        case 375:
            queuedRuneNumber = 0;
            BerkanoSingleCharacter *bsc = [[BerkanoSingleCharacter alloc] initToCharacter:aCharacter];
            [sharedGameController.currentScene addObjectToActiveObjects:bsc];
            [bsc release];
            essence -= 30;
            break;
        case 56:
            queuedRuneNumber = 0;
            [PrimazSingleCharacter grantRageAttackTo:aCharacter];
            essence -= 12;
            break;
        case 217:
            queuedRuneNumber = 0;
            AkathSingleCharacter *asc = [[AkathSingleCharacter alloc] initToCharacter:aCharacter];
            [sharedGameController.currentScene addObjectToActiveObjects:asc];
            [asc release];
            essence -= 15;
            break;
        case 286:
            queuedRuneNumber = 0;
            HolgethSingleCharacter *hosc = [[HolgethSingleCharacter alloc] initToCharacter:aCharacter];
            [sharedGameController.currentScene addObjectToActiveObjects:hosc];
            [hosc release];
            essence -= 7;
            break;
		default:
			break;
	}
}

- (void)runeAffectedAllEnemies {
	
	[super runeAffectedAllEnemies];
	switch (queuedRuneNumber) {
		case 253:
			queuedRuneNumber = 0;
			SowiloAllEnemies *sae = [[SowiloAllEnemies alloc] init];
			[sharedGameController.currentScene addObjectToActiveObjects:sae];
			[sae release];
            essence -= 18;
			break;
        case 165:
            queuedRuneNumber = 0;
            HagalazAllEnemies *hae = [[HagalazAllEnemies alloc] init];
            [sharedGameController.currentScene addObjectToActiveObjects:hae];
            [hae release];
            essence -= 24;
            break;
        case 245:
            queuedRuneNumber = 0;
            JeraAllEnemies *jae = [[JeraAllEnemies alloc] init];
            [sharedGameController.currentScene addObjectToActiveObjects:jae];
            [jae release];
            essence -= 52;
            break;
        case 116:
            queuedRuneNumber = 0;
            NauthizAllEnemies *nae = [[NauthizAllEnemies alloc] init];
            [sharedGameController.currentScene addObjectToActiveObjects:nae];
            [nae release];
            essence -= 33;
            break;
        case 375:
            queuedRuneNumber = 0;
            BerkanoAllEnemies *bae = [[BerkanoAllEnemies alloc] init];
            [sharedGameController.currentScene addObjectToActiveObjects:bae];
            [bae release];
            essence -= 45;
            break;
        case 56:
            queuedRuneNumber = 0;
            PrimazAllEnemies *pae = [[PrimazAllEnemies alloc] init];
            [sharedGameController.currentScene addObjectToActiveObjects:pae];
            [pae release];
            essence -= 20;
            break;
        case 217:
            queuedRuneNumber = 0;
            AkathAllEnemies *aae = [[AkathAllEnemies alloc] init];
            [sharedGameController.currentScene addObjectToActiveObjects:aae];
            [aae release];
            essence -= 33;
            break;
        case 286:
            queuedRuneNumber = 0;
            HolgethAllEnemies *hoae = [[HolgethAllEnemies alloc] init];
            [sharedGameController.currentScene addObjectToActiveObjects:hoae];
            [hoae release];
            essence -= 35;
            break;
		default:
			break;
	}
}

- (void)runeAffectedAllCharacters {
	
	[super runeAffectedAllCharacters];
	switch (queuedRuneNumber) {
		case 253:
			queuedRuneNumber = 0;
			SowiloAllCharacters *sac = [[SowiloAllCharacters alloc] init];
			[sharedGameController.currentScene addObjectToActiveObjects:sac];
			[sac release];
            essence -= 12;
			break;
        case 165:
            queuedRuneNumber = 0;
            HagalazAllCharacters *hac = [[HagalazAllCharacters alloc] init];
            [sharedGameController.currentScene addObjectToActiveObjects:hac];
            [hac release];
            essence -= 35;
            break;
        case 245:
            queuedRuneNumber = 0;
            JeraAllCharacters *jac = [[JeraAllCharacters alloc] init];
            [sharedGameController.currentScene addObjectToActiveObjects:jac];
            [jac release];
            essence -= 28;
            break;
        case 116:
            queuedRuneNumber = 0;
            NauthizAllCharacters *nac = [[NauthizAllCharacters alloc] init];
            [sharedGameController.currentScene addObjectToActiveObjects:nac];
            [nac release];
            essence -= 18;
            break;
        case 375:
            queuedRuneNumber = 0;
            BerkanoAllCharacters *bac = [[BerkanoAllCharacters alloc] init];
            [sharedGameController.currentScene addObjectToActiveObjects:bac];
            [bac release];
            essence -= 27;
            break;
        case 56:
            queuedRuneNumber = 0;
            PrimazAllCharacters *pac = [[PrimazAllCharacters alloc] init];
            [sharedGameController.currentScene addObjectToActiveObjects:pac];
            [pac release];
            essence -= 23;
            break;
        case 217:
            queuedRuneNumber = 0;
            [AkathAllCharacters grantLifeShields];
            essence -= 18;
            break;
        case 286:
            queuedRuneNumber = 0;
            [HolgethAllCharacters grantRageShields];
            essence -= 18;
            break;
		default:
			break;
	}
}

- (void)initBattleAttributes {
    
    [super initBattleAttributes];
    rageTarget = nil;
    damageDealt = 0;
}

- (void)unlockGeboPotential {
    
    if (geboPotential) {
        return;
    }
    rageAffinity += 5;
    lifeAffinity += 5;
    [self increaseAgilityModifierBy:5];
    [self increaseDexterityModifierBy:5];
    geboPotential = YES;
} 

- (void)youTookDamage:(int)aDamage {
    rageMeter -= aDamage;
    //NSLog(@"rageMeter is: %f. Because aDamage was %d", rageMeter, aDamage);
    [super youTookDamage:aDamage];
}

- (int)calculateAttackDamageTo:(AbstractBattleEnemy *)aEnemy {
    
    float tempDamage = (((strength + strengthModifier + dexterity + dexterityModifier) / 2 ) * 5) - (aEnemy.dexterity + aEnemy.dexterityModifier + aEnemy.agility + aEnemy.agilityModifier + aEnemy.stamina + aEnemy.staminaModifier);
    ////NSLog(@"Strength: %f, StrMod: %f, dex:%f, dexmod: %f", strength, strengthModifier, dexterity, dexterityModifier);
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
        tempDamage *= fabsf(1 + (endurance / maxEndurance));
    }
    if (tempDamage < 0) {
        return 0;
    }
    tempDamage *= (endurance / maxEndurance);
    if (endurance < 0) {
        return 0;
    }
    ////NSLog(@"endurance: %f, maxEndurance: %f", endurance, maxEndurance);
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

- (float)calculateSowiloRollTo:(AbstractBattleEnemy *)aEnemy {
    
    float sowiloRoll = ((affinity + affinityModifier + level + levelModifier - aEnemy.level - aEnemy.levelModifier + lifeAffinity - aEnemy.lifeAffinity) * (lifeAffinity / aEnemy.lifeAffinity) * (essence / maxEssence));
    if (doubleEffect) {
        for (RaidhoSingleCharacter *obj in sharedGameController.currentScene.activeObjects) {
            if ([obj isMemberOfClass:[RaidhoSingleCharacter class]]) {
                [obj enhanceEffectTo:aEnemy];
            }
        }
        doubleEffect = NO;
        sowiloRoll *= 2;
    }
    return sowiloRoll;
}

- (int)calculateSowiloStaminaDownTo:(AbstractBattleEnemy *)aEnemy {
    
    float staminaDown = ((affinity + affinityModifier - aEnemy.affinity - aEnemy.affinityModifier) * (lifeAffinity / aEnemy.lifeAffinity) * (essence / maxEssence));
    if (doubleEffect) {
        for (RaidhoSingleCharacter *obj in sharedGameController.currentScene.activeObjects) {
            if ([obj isMemberOfClass:[RaidhoSingleCharacter class]]) {
                [obj enhanceEffectTo:aEnemy];
            }
        }
        doubleEffect = NO;
        staminaDown *= 2;
    }
    return (int)staminaDown;
}

- (float)calculateHagalazDurationTo:(AbstractBattleEnemy *)aEnemy {
    
    float hagalazDuration = ((affinity + affinityModifier + level + levelModifier - aEnemy.level - aEnemy.levelModifier + waterAffinity - aEnemy.waterAffinity) * (essence / maxEssence));
    if (doubleEffect) {
        for (RaidhoSingleCharacter *obj in sharedGameController.currentScene.activeObjects) {
            if ([obj isMemberOfClass:[RaidhoSingleCharacter class]]) {
                [obj enhanceEffectTo:aEnemy];
            }
        }
        doubleEffect = NO;
        return (hagalazDuration + 1) * 2;
    }
    return hagalazDuration + 1;
}

- (float)calculateHagalazDurationToCharacter:(AbstractBattleCharacter *)aCharacter {
    
    float hagalazDuration = ((affinity + affinityModifier + level + levelModifier + waterAffinity) * (essence / maxEssence));
    if (doubleEffect) {
        for (RaidhoSingleCharacter *obj in sharedGameController.currentScene.activeObjects) {
            if ([obj isMemberOfClass:[RaidhoSingleCharacter class]]) {
                [obj enhanceEffectTo:aCharacter];
            }
        }
        doubleEffect = NO;
        return (hagalazDuration + 1) * 2;
    }
    return hagalazDuration + 1;
}

- (float)calculateJeraDurationTo:(AbstractBattleCharacter *)aCharacter {
    
    float jeraDuration = ((affinity + affinityModifier + rageAffinity + aCharacter.rageAffinity) * (essence / maxEssence));
    if (doubleEffect) {
        for (RaidhoSingleCharacter *obj in sharedGameController.currentScene.activeObjects) {
            if ([obj isMemberOfClass:[RaidhoSingleCharacter class]]) {
                [obj enhanceEffectTo:aCharacter];
            }
        }
        doubleEffect = NO;
        return (jeraDuration + 1) * 2;
    }
    return jeraDuration + 1;
}

- (int)calculateNauthizDamageTo:(AbstractBattleEnemy *)aEnemy {
    
    float nauthizDamage = ((power + powerModifier) * 0.33 * (lifeAffinity / aEnemy.lifeAffinity));
    nauthizDamage *= (essence / maxEssence);
    if (doubleEffect) {
        for (RaidhoSingleCharacter *obj in sharedGameController.currentScene.activeObjects) {
            if ([obj isMemberOfClass:[RaidhoSingleCharacter class]]) {
                [obj enhanceEffectTo:aEnemy];
            }
        }
        nauthizDamage *= 2;
        doubleEffect = NO;
    }
    return (int)nauthizDamage;
}

- (float)calculateNauthizDuration {
    
    float nauthizDuration = ((affinity + affinityModifier + level + levelModifier) + (lifeAffinity * 1.5) + (RANDOM_0_TO_1() * (luck + luckModifier)));
    nauthizDuration *= (essence / maxEssence);
    if (doubleEffect) {
        for (RaidhoSingleCharacter *obj in sharedGameController.currentScene.activeObjects) {
            if ([obj isMemberOfClass:[RaidhoSingleCharacter class]]) {
                [obj enhanceEffectTo:self];
            }
        }
        nauthizDuration *= 2;
        doubleEffect = NO;
    }
    return nauthizDuration;
}

- (int)calculateBerkanoHealingTo:(AbstractBattleCharacter *)aCharacter {
    
    float berkanoHealing = ((affinity + affinityModifier + deathAffinity + aCharacter.deathAffinity) * (essence / maxEssence));
    berkanoHealing /= 400;
    berkanoHealing *= aCharacter.maxHP;
    if (doubleEffect) {
        for (RaidhoSingleCharacter *obj in sharedGameController.currentScene.activeObjects) {
            if ([obj isMemberOfClass:[RaidhoSingleCharacter class]]) {
                [obj enhanceEffectTo:aCharacter];
            }
        }
        berkanoHealing *= 2;
        doubleEffect = NO;
    }
    return berkanoHealing;
}

- (float)calculateBerkanoDuration {
    
    float berkanoDuration = ((affinity + affinityModifier + deathAffinity + level + levelModifier) * (essence / maxEssence));
    if (doubleEffect) {
        for (RaidhoSingleCharacter *obj in sharedGameController.currentScene.activeObjects) {
            if ([obj isMemberOfClass:[RaidhoSingleCharacter class]]) {
                [obj enhanceEffectTo:self];
            }
        }
        berkanoDuration *= 2;
        doubleEffect = NO;
    }
    return berkanoDuration - 3;
}

- (float)calculatePrimazDurationTo:(AbstractBattleEnemy *)aEnemy {
    
    float primazDuration = ((power + powerModifier + ((rageAffinity + aEnemy.rageAffinity) / 2)) * (essence / maxEssence));
    if (doubleEffect) {
        for (RaidhoSingleCharacter *obj in sharedGameController.currentScene.activeObjects) {
            if ([obj isMemberOfClass:[RaidhoSingleCharacter class]]) {
                [obj enhanceEffectTo:aEnemy];
            }
        }
        primazDuration *= 2;
        doubleEffect = NO;
    }
    return primazDuration;
}

- (int)calculatePrimazDamageTo:(AbstractBattleEnemy *)aEnemy {
    
    float primazDamage = ((power + powerModifier) * 5 * (rageAffinity / aEnemy.rageAffinity) * (essence / maxEssence) + ((RANDOM_0_TO_1() * (10 + luck + luckModifier))));
    if (doubleEffect) {
        for (RaidhoSingleCharacter *obj in sharedGameController.currentScene.activeObjects) {
            if ([obj isMemberOfClass:[RaidhoSingleCharacter class]]) {
                [obj enhanceEffectTo:aEnemy];
            }
        }
        primazDamage *= 2;
        doubleEffect = NO;
    }
    return (int)primazDamage;
}

- (int)calculatePrimazRageAdderFrom:(AbstractBattleCharacter *)aCharacter {
    
    float rageAdder = ((8 + (aCharacter.rageAffinity / 5)) * (essence / maxEssence));
    aCharacter.essence -= 8;
    if (doubleEffect) {
        for (RaidhoSingleCharacter *obj in sharedGameController.currentScene.activeObjects) {
            if ([obj isMemberOfClass:[RaidhoSingleCharacter class]]) {
                [obj enhanceEffectTo:aCharacter];
            }
        }
        rageAdder *= 2;
        doubleEffect = NO;
    }
    return (int)rageAdder;
}

- (float)calculateAkathAdderTo:(AbstractBattleEnemy *)aEnemy {
    
    float akathAdder = ((affinity + affinityModifier + ((level + levelModifier - aEnemy.level - aEnemy.levelModifier) * (lifeAffinity / aEnemy.lifeAffinity))));
    akathAdder *= (essence / maxEssence);
    if (doubleEffect) {
        for (RaidhoSingleCharacter *obj in sharedGameController.currentScene.activeObjects) {
            if ([obj isMemberOfClass:[RaidhoSingleCharacter class]]) {
                [obj enhanceEffectTo:aEnemy];
            }
        }
        akathAdder *= 2;
        doubleEffect = NO;
    }
    return akathAdder;
                        
}

- (int)calculateHolgethBirds {
    
    float holgethBirds = ((power + powerModifier + rageAffinity) / 10) * (essence / maxEssence);
    if (doubleEffect) {
        for (RaidhoSingleCharacter *obj in sharedGameController.currentScene.activeObjects) {
            if ([obj isMemberOfClass:[RaidhoSingleCharacter class]]) {
                [obj enhanceEffectTo:self];
            }
        }
        holgethBirds *= 2;
        doubleEffect = NO;
    }
    holgethBirds = CLAMP(holgethBirds, 1, 10);
    return (int)holgethBirds;
    
    
}

- (int)calculateHolgethBleeders {
    
    float holgethBleeders = ((power + powerModifier + rageAffinity) / 5) * (essence / maxEssence);
    if (doubleEffect) {
        for (RaidhoSingleCharacter *obj in sharedGameController.currentScene.activeObjects) {
            if ([obj isMemberOfClass:[RaidhoSingleCharacter class]]) {
                [obj enhanceEffectTo:self];
            }
        }
        holgethBleeders *= 2;
        doubleEffect = NO;
    }
    holgethBleeders = CLAMP(holgethBleeders, 1, 30);
    return (int)holgethBleeders;
}

- (int)calculateHolgethHealers {
    
    float holgethHealers = ((affinity + affinityModifier + rageAffinity) / 8) * (essence / maxEssence);
    if (doubleEffect) {
        for (RaidhoSingleCharacter *obj in sharedGameController.currentScene.activeObjects) {
            if ([obj isMemberOfClass:[RaidhoSingleCharacter class]]) {
                [obj enhanceEffectTo:self];
            }
        }
        holgethHealers *= 2;
        doubleEffect = NO;
    }
    holgethHealers = CLAMP(holgethHealers, 1, 20);
    return (int)holgethHealers;
}

- (int)calculateSpearShowerDamageTo:(AbstractBattleEnemy *)aEnemy {
    
    float spearDamage = ((strength + strengthModifier + agility + agilityModifier + dexterity + dexterityModifier) * 3) - aEnemy.agility - aEnemy.agilityModifier - aEnemy.dexterity - aEnemy.dexterityModifier;
    spearDamage += (arc4random() % (int)(luck + luckModifier + 1));
    if (doubleEffect) {
        for (RaidhoSingleCharacter *obj in sharedGameController.currentScene.activeObjects) {
            if ([obj isMemberOfClass:[RaidhoSingleCharacter class]]) {
                [obj enhanceEffectTo:aEnemy];
            }
        }
        spearDamage *= 2;
        doubleEffect = NO;
    }
    return spearDamage;
}

- (void)gainPriority {
    [super gainPriority];
    currentAnimation = selected;
    
}

- (void)relinquishPriority {
    currentAnimation = currentTurnAnimation;
    
    [super relinquishPriority];
}

@end

//
//  BattlePriest.m
//  TEORBattleTest
//
//  Created by Zach Babb on 5/25/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "BattlePriest.h"
#import "Image.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "BattleValkyrie.h"
#import "PackedSpriteSheet.h"
#import "Animation.h"
#import "Bleeder.h"
#import "TouchManager.h"
#import "AbstractBattleEnemy.h"
#import "FirstPriestAttack.h"
#import "RaidhoSingleCharacter.h"
#import "WunjoSingleEnemy.h"
#import "WunjoAllEnemies.h"
#import "WunjoSingleCharacter.h"
#import "WunjoAllCharacters.h"
#import "GeboSingleEnemy.h"
#import "GeboAllEnemies.h"
#import "GeboSingleCharacter.h"
#import "GeboAllCharacters.h"
#import "EhwazSingleEnemy.h"
#import "EhwazAllEnemies.h"
#import "EhwazSingleCharacter.h"
#import "EhwazAllCharacters.h"
#import "DagazSingleEnemy.h"
#import "DagazAllEnemies.h"
#import "DagazSingleCharacter.h"
#import "DagazAllCharacters.h"
#import "IngrethSingleEnemy.h"
#import "IngrethAllEnemies.h"
#import "IngrethSingleCharacter.h"
#import "IngrethAllCharacters.h"
#import "HelazSingleEnemy.h"
#import "HelazAllEnemies.h"
#import "HelazSingleCharacter.h"
#import "HelazAllCharacters.h"
#import "EpelthSingleEnemy.h"
#import "EpelthAllEnemies.h"
#import "EpelthSingleCharacter.h"
#import "EpelthAllCharacters.h"
#import "SmeazSingleEnemy.h"
#import "SmeazAllEnemies.h"
#import "SmeazSingleCharacter.h"
#import "SmeazAllCharacters.h"


@implementation BattlePriest

@synthesize isAttacking;
@synthesize favor;
@synthesize godTimer;
@synthesize odinFavor, thorFavor, tyrFavor, freyaFavor, friggFavor;

- (id)initWithBattleLocation:(int)aLocation {
	
	if (self = [super init]) {
		
		//Image *priest = [sharedGameController.teorPSS imageForKey:@"Priest50x80.png"];
        Image *priest = [[Image alloc] initWithImageNamed:@"Baal_ready_pose_4x.png" filter:GL_LINEAR];
        priest.scale = Scale2fMake(0.25, 0.25);
		currentTurnAnimation = [[Animation alloc] init];
		[currentTurnAnimation addFrameWithImage:priest delay:0.3];
		currentTurnAnimation.state = kAnimationState_Stopped;
		[priest release];
        Image *priestSelected = [[Image alloc] initWithImageNamed:@"Baal_action_pose_10x-2.png" filter:GL_LINEAR];
        priestSelected.scale = Scale2fMake(0.1, 0.1);
		selected = [[Animation alloc] init];
		[selected addFrameWithImage:priestSelected delay:0.3];
		selected.state = kAnimationState_Stopped;
		[priestSelected release];
		currentAnimation = currentTurnAnimation;
		battleLocation = aLocation;
		whichCharacter = kPriest;
        odinFavor = 1;
        thorFavor = 1;
        tyrFavor = 1;
        freyaFavor = 1;
        friggFavor = 1;
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

		essenceColor = essenceMeter.color = Color4fMake(1.0, 0.0, 0.0, 1.0);
		sacraficeSetUp = NO;
		
	}
	
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	[super updateWithDelta:aDelta];
	if (sharedTouchManager.state == kPriest && sacraficeSetUp == NO) {
		[sharedTouchManager enableUIDevice];
		sacraficeSetUp = YES;
	}
	if (isAttacking) {
		attackTimer -= aDelta;
		if (attackTimer < 0) {
			//Make the Priest attack animation again.
			attackTimer = (10 / level);
		}
	}
}

- (void)startAttackingEnemy:(AbstractBattleEnemy *)aEnemy {
	//Make a Priest attack animation here.
	attackTimer = (10 / level);
	isAttacking = YES;
	victim = aEnemy;
	FirstPriestAttack *fpa = [[FirstPriestAttack alloc] initToEnemy:aEnemy];
	[sharedGameController.currentScene addObjectToActiveObjects:fpa];
	[fpa release];
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
            FirstPriestAttack *fpa = [[FirstPriestAttack alloc] initToEnemy:aEnemy waiting:i + 0.5];
            [sharedGameController.currentScene addObjectToActiveObjects:fpa];
            [fpa release];
            doubleAttack--;
        }
        if (attackAttacksAllEnemies) {
            for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
                if ([enemy isKindOfClass:[AbstractBattleEnemy class]] && enemy.isAlive && enemy != aEnemy) {
                    //Maybe make a fresh object here that's the same for everyone.
                    FirstPriestAttack *extraAttack = [[FirstPriestAttack alloc] initToEnemy:enemy waiting:0.3];
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
            if (roll < 20) {
                odinFavor += 0.05;
            }
            if (20 <= roll && roll < 40) {
                thorFavor += 0.05;
            }
            if (40 <= roll && roll < 60) {
                tyrFavor += 0.05;
            }
            if (60 <= roll && roll < 80) {
                freyaFavor += 0.05;
            }
            if (80 <= roll) {
                friggFavor += 0.05;
            }
        }
        if (attacksAddToRageMeter) {
            BattleValkyrie *valk = [sharedGameController.battleCharacters objectForKey:@"BattleValkyrie"];
            valk.rageMeter += 1;
        }
        if (attacksAddToStatusTimers) {
            [aEnemy addToStatusDurations:1];
        }
        
        FirstPriestAttack *fpa = [[FirstPriestAttack alloc] initToEnemy:aEnemy waiting:i];
        [sharedGameController.currentScene addObjectToActiveObjects:fpa];
        [fpa release];

    }
       
    int enduranceLost = maxEndurance / (2 - ((affinity + affinityModifier) / 100));
    if (enduranceDoesNotDeplete) {
        //implementation
    }
    if (halfEnduranceExpenditure) {
        //implementation
    }
    
    endurance -= enduranceLost;

}

- (void)stopAttacking {
	
	isAttacking = NO;
}

- (void)loseEndurance {
    
    int enduranceLost = 15 + (level * 0.2);
    enduranceLost += 2;
    if (enduranceDoesNotDeplete) {
        enduranceLost = 0;
    }
    if (halfEnduranceExpenditure) {
        enduranceLost /= 2;
    }
    
    endurance -= enduranceLost;
    if (endurance < 0) {
        endurance = 0;
    }

}

- (void)resetBattleTimer {
	
	battleTimer = 0.0;
	currentTurn = NO;
}

- (void)queueRune:(int)aRune {
	
	[super queueRune:aRune];
	[sharedInputManager setState:kPriestRunePlacement];
}

- (void)runeWasPlacedOnEnemy:(AbstractBattleEnemy *)aEnemy {
	
	[super runeWasPlacedOnEnemy:aEnemy];
	switch (queuedRuneNumber) {
		case 210:
			queuedRune = 0;
			WunjoSingleEnemy *wse = [[WunjoSingleEnemy alloc] initToEnemy:aEnemy];
			[sharedGameController.currentScene addObjectToActiveObjects:wse];
			[wse release];
            essence -= 32;
			break;
        case 166:
            queuedRuneNumber = 0;
            GeboSingleEnemy *gse = [[GeboSingleEnemy alloc] initToEnemy:aEnemy];
            [sharedGameController.currentScene addObjectToActiveObjects:gse];
            [gse release];
            essence -= 5;
            break;
        case 254:
            queuedRuneNumber = 0;
            EhwazSingleEnemy *ese = [[EhwazSingleEnemy alloc] initToEnemy:aEnemy];
            [sharedGameController.currentScene addObjectToActiveObjects:ese];
            [ese release];
            essence -= 32;
            break;
        case 218:
            queuedRuneNumber = 0;
            DagazSingleEnemy *dse = [[DagazSingleEnemy alloc] initToEnemy:aEnemy];
            [sharedGameController.currentScene addObjectToActiveObjects:dse];
            [dse release];
            essence -= 28;
            break;
        case 286:
            queuedRuneNumber = 0;
            IngrethSingleEnemy *ise = [[IngrethSingleEnemy alloc] initToEnemy:aEnemy];
            [sharedGameController.currentScene addObjectToActiveObjects:ise];
            [ise release];
            essence -= 30;
            break;
        case 141:
            queuedRuneNumber = 0;
            HelazSingleEnemy *hse = [[HelazSingleEnemy alloc] initToEnemy:aEnemy];
            [sharedGameController.currentScene addObjectToActiveObjects:hse];
            [hse release];
            essence -= 24;
            break;
        case 242:
            queuedRuneNumber = 0;
            EpelthSingleEnemy *epse = [[EpelthSingleEnemy alloc] initToEnemy:aEnemy];
            [sharedGameController.currentScene addObjectToActiveObjects:epse];
            [epse release];
            essence -= 48;
            break;
        case 203:
            queuedRuneNumber = 0;
            SmeazSingleEnemy *sse = [[SmeazSingleEnemy alloc] initToEnemy:aEnemy];
            [sharedGameController.currentScene addObjectToActiveObjects:sse];
            [sse release];
            essence -= 24;
            break;
		default:
			break;
	}
}

- (void)runeAffectedAllEnemies {
	
	[super runeAffectedAllEnemies];
	switch (queuedRuneNumber) {
		case 210:
			queuedRuneNumber = 0;
			WunjoAllEnemies *wae = [[WunjoAllEnemies alloc] init];
			[sharedGameController.currentScene addObjectToActiveObjects:wae];
			[wae release];
            essence -= 55;
			break;
        case 166:
            queuedRuneNumber = 0;
            GeboAllEnemies *gae = [[GeboAllEnemies alloc] init];
            [sharedGameController.currentScene addObjectToActiveObjects:gae];
            [gae release];
            essence -= 24;
            break;
        case 254:
            queuedRuneNumber = 0;
            EhwazAllEnemies *eae = [[EhwazAllEnemies alloc] init];
            [sharedGameController.currentScene addObjectToActiveObjects:eae];
            [eae release];
            essence -= 36;
            break;
        case 218:
            queuedRuneNumber = 0;
            [DagazAllEnemies hexEnemies];
            essence -= 40;
            break;
        case 286:
            queuedRuneNumber = 0;
            IngrethAllEnemies *iae = [[IngrethAllEnemies alloc] init];
            [sharedGameController.currentScene addObjectToActiveObjects:iae];
            [iae release];
            essence -= 55;
            break;
        case 142:
            queuedRuneNumber = 0;
            HelazAllEnemies *hae = [[HelazAllEnemies alloc] init];
            [sharedGameController.currentScene addObjectToActiveObjects:hae];
            [hae release];
            essence -= 30;
            break;
        case 241:
            queuedRuneNumber = 0;
            EpelthAllEnemies *epae = [[EpelthAllEnemies alloc] init];
            [sharedGameController.currentScene addObjectToActiveObjects:epae];
            [epae release];
            essence -= 40;
            break;
        case 203:
            queuedRuneNumber = 0;
            SmeazAllEnemies *sae = [[SmeazAllEnemies alloc] init];
            [sharedGameController.currentScene addObjectToActiveObjects:sae];
            [sae release];
            essence -= 36;
            break;
		default:
			break;
	}
}

- (void)runeWasPlacedOnCharacter:(AbstractBattleCharacter *)aCharacter {
	
	[super runeWasPlacedOnCharacter:aCharacter];
	switch (queuedRuneNumber) {
		case 210:
			queuedRuneNumber = 0;
			WunjoSingleCharacter *wsc = [[WunjoSingleCharacter alloc] initToCharacter:aCharacter];
			[sharedGameController.currentScene addObjectToActiveObjects:wsc];
			[wsc release];
            essence -= 22;
			break;
        case 166:
            queuedRuneNumber = 0;
            GeboSingleCharacter *gsc = [[GeboSingleCharacter alloc] initToCharacter:aCharacter];
            [sharedGameController.currentScene addObjectToActiveObjects:gsc];
            [gsc release];
            essence -= 25;
            break;
        case 254:
            queuedRuneNumber = 0;
            EhwazSingleCharacter *esc = [[EhwazSingleCharacter alloc] initToCharacter:aCharacter];
            [sharedGameController.currentScene addObjectToActiveObjects:esc];
            [esc release];
            essence -= 24;
            break;
        case 218:
            queuedRuneNumber = 0;
            DagazSingleCharacter *dsc = [[DagazSingleCharacter alloc] initToCharacter:aCharacter];
            [sharedGameController.currentScene addObjectToActiveObjects:dsc];
            [dsc release];
            essence -= 22;
            break;
        case 286:
            queuedRuneNumber = 0;
            IngrethSingleCharacter *isc = [[IngrethSingleCharacter alloc] initToCharacter:aCharacter];
            [sharedGameController.currentScene addObjectToActiveObjects:isc];
            [isc release];
            essence -= 18;
            break;
        case 142:
            queuedRuneNumber = 0;
            [HelazSingleCharacter grantDivineAttackTo:aCharacter];
            essence -= 18;
            break;
        case 241:
            queuedRuneNumber = 0;
            [EpelthSingleCharacter grantDeathAttackTo:aCharacter];
            essence -= 18;
            break;
        case 203:
            queuedRuneNumber = 0;
            SmeazSingleCharacter *ssc = [[SmeazSingleCharacter alloc] initToCharacter:aCharacter];
            [sharedGameController.currentScene addObjectToActiveObjects:ssc];
            [ssc release];
            essence -= 36;
            break;
		default:
			break;
	}
}

- (void)runeAffectedAllCharacters {
	
	[super runeAffectedAllCharacters];
	switch (queuedRuneNumber) {
		case 210:
			queuedRuneNumber = 0;
			[WunjoAllCharacters giveAllCharactersProtection];
            essence -= 24;
			break;
        case 166:
            queuedRuneNumber = 0;
            essence -= 20;
            break;
        case 254:
            queuedRuneNumber = 0;
            EhwazAllCharacters *eac = [[EhwazAllCharacters alloc] init];
            [sharedGameController.currentScene addObjectToActiveObjects:eac];
            [eac release];
            essence -= 33;
            break;
        case 218:
            queuedRuneNumber = 0;
            [DagazAllCharacters auraAllCharacters];
            essence -= 48;
            break;
        case 286:
            queuedRuneNumber = 0;
            //Add with god timers.
            essence -= 24;
            break;
        case 142:
            queuedRuneNumber = 0;
            [HelazAllCharacters grantDivineShields];
            essence -= 28;
            break;
        case 241:
            queuedRuneNumber = 0;
            EpelthAllCharacters *epac = [[EpelthAllCharacters alloc] init];
            [sharedGameController.currentScene addObjectToActiveObjects:epac];
            [epac release];
            essence -= 32;
            break;
        case 203:
            queuedRuneNumber = 0;
            SmeazAllCharacters *sac = [[SmeazAllCharacters alloc] init];
            [sharedGameController.currentScene addObjectToActiveObjects:sac];
            [sac release];
            essence -= 33;
            break;
		default:
			break;
	}
}

- (int)calculateAttackDamageTo:(AbstractBattleEnemy *)aEnemy {
    
    float tempDamage = (((affinity + affinityModifier + power + powerModifier) / 2.3 ) * 4.3) - (aEnemy.power + aEnemy.powerModifier + aEnemy.affinity + aEnemy.affinityModifier);
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
    tempDamage *= fabsf((endurance / maxEndurance) + 0.05);
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

- (float)calculateGeboDurationTo:(AbstractBattleEnemy *)aEnemy {
    
    float geboDuration = ((affinity + affinityModifier) * (lifeAffinity / aEnemy.lifeAffinity)) * 0.4 * (essence / maxEssence);
    if (doubleEffect) {
        for (RaidhoSingleCharacter *obj in sharedGameController.currentScene.activeObjects) {
            if ([obj isMemberOfClass:[RaidhoSingleCharacter class]]) {
                [obj enhanceEffectTo:aEnemy];
            }
        }
        geboDuration *= 2;
        doubleEffect = NO;
    }
    return 1 + geboDuration;
}

- (void)unlockGeboPotential {
    
    if (geboPotential) {
        return;
    }
    divineAffinity += 5;
    deathAffinity += 5;
    [self increaseAffinityModifierBy:5];
    [self increaseStaminaModifierBy:5];
    geboPotential = YES;
}

- (int)calculateGeboDamageTo:(AbstractBattleEnemy *)aEnemy {
    
    float geboDamage = ((power + powerModifier - aEnemy.affinity - aEnemy.affinityModifier) * 4 * (lifeAffinity / aEnemy.lifeAffinity) * (essence / maxEssence));
    if (doubleEffect) {
        for (RaidhoSingleCharacter *obj in sharedGameController.currentScene.activeObjects) {
            if ([obj isMemberOfClass:[RaidhoSingleCharacter class]]) {
                [obj enhanceEffectTo:aEnemy];
            }
        }
        geboDamage *= 2;
        doubleEffect = NO;
    }
    return (int)geboDamage;
}

- (int)calculateEhwazDamageTo:(AbstractBattleEnemy *)aEnemy {
    
    float ehwazDamage = ((power + powerModifier - aEnemy.affinity - aEnemy.affinityModifier + divineAffinity - aEnemy.divineAffinity) * 8 * (essence / maxEssence));
    if (doubleEffect) {
        for (RaidhoSingleCharacter *obj in sharedGameController.currentScene.activeObjects) {
            if ([obj isMemberOfClass:[RaidhoSingleCharacter class]]) {
                [obj enhanceEffectTo:aEnemy];
            }
        }
        ehwazDamage *= 2;
        doubleEffect = NO;
    }
    return (int)ehwazDamage;
}

- (float)calculateEhwazDurationTo:(AbstractBattleCharacter *)aCharacter {
    
    float ehwazDuration = ((affinity + affinityModifier + divineAffinity) * 0.3 * (essence / maxEssence));
    if (doubleEffect) {
        for (RaidhoSingleCharacter *obj in sharedGameController.currentScene.activeObjects) {
            if ([obj isMemberOfClass:[RaidhoSingleCharacter class]]) {
                [obj enhanceEffectTo:aCharacter];
            }
        }
        ehwazDuration *= 2;
        doubleEffect = NO;
    }
    return ehwazDuration;
}

- (int)calculateDagazHexRollTo:(AbstractBattleEnemy *)aEnemy {
    
    float hexRoll = ((affinity + affinityModifier + poisonAffinity - aEnemy.affinity - aEnemy.affinityModifier - aEnemy.poisonAffinity) * (poisonAffinity / aEnemy.poisonAffinity) * (essence / maxEssence));
    if (doubleEffect) {
        for (RaidhoSingleCharacter *obj in sharedGameController.currentScene.activeObjects) {
            if ([obj isMemberOfClass:[RaidhoSingleCharacter class]]) {
                [obj enhanceEffectTo:aEnemy];
            }
        }
        hexRoll *= 2;
        doubleEffect = NO;
    }
    return (int)hexRoll;
}

- (int)calculateDagazAuraRollTo:(AbstractBattleCharacter *)aCharacter {
    
    float auraRoll = ((affinity + affinityModifier * ((poisonAffinity + aCharacter.poisonAffinity) * 0.01)) * (essence / maxEssence));
    if (doubleEffect) {
        for (RaidhoSingleCharacter *obj in sharedGameController.currentScene.activeObjects) {
            if ([obj isMemberOfClass:[RaidhoSingleCharacter class]]) {
                [obj enhanceEffectTo:aCharacter];
            }
        }
        auraRoll *= 2;
        doubleEffect = NO;
    }
    return (int)auraRoll;
}

- (int)calculateIngrethDamageTo:(AbstractBattleEnemy *)aEnemy {
    
    float ingrethDamage = ((power + powerModifier + (10 * (odinFavor + thorFavor + tyrFavor + freyaFavor + friggFavor))) * (divineAffinity / aEnemy.divineAffinity) * (essence / maxEssence));
    if (doubleEffect) {
        for (RaidhoSingleCharacter *obj in sharedGameController.currentScene.activeObjects) {
            if ([obj isMemberOfClass:[RaidhoSingleCharacter class]]) {
                [obj enhanceEffectTo:aEnemy];
            }
        }
        ingrethDamage *= 2;
        doubleEffect = NO;
    }
    return (int)ingrethDamage;
}

- (int)calculateHelazDamageTo:(AbstractBattleEnemy *)aEnemy {
    
    float helazDamage = ((power + powerModifier + divineAffinity - aEnemy.affinity - aEnemy.affinityModifier) * (divineAffinity / aEnemy.divineAffinity) * (essence / maxEssence));
    if (doubleEffect) {
        for (RaidhoSingleCharacter *obj in sharedGameController.currentScene.activeObjects) {
            if ([obj isMemberOfClass:[RaidhoSingleCharacter class]]) {
                [obj enhanceEffectTo:aEnemy];
            }
        }
        helazDamage *= 2;
        doubleEffect = NO;
    }
    return (int)helazDamage;
}

- (int)calculateEpelthDamageTo:(AbstractBattleEnemy *)aEnemy {
    
    float epelthDamage = ((power + powerModifier + deathAffinity - aEnemy.affinity - aEnemy.affinityModifier - aEnemy.deathAffinity) * 4 * (deathAffinity / aEnemy.deathAffinity) * (essence / maxEssence));
    if (doubleEffect) {
        for (RaidhoSingleCharacter *obj in sharedGameController.currentScene.activeObjects) {
            if ([obj isMemberOfClass:[RaidhoSingleCharacter class]]) {
                [obj enhanceEffectTo:aEnemy];
            }
        }
        epelthDamage *= 2;
        doubleEffect = NO;
    }
    return (int)epelthDamage;
}

- (int)calculateEpelthEnduranceAdded {
    
    float enduranceAdded = ((affinity + affinityModifier + deathAffinity + level + levelModifier) * (essence / maxEssence));
    if (doubleEffect) {
        for (RaidhoSingleCharacter *obj in sharedGameController.currentScene.activeObjects) {
            if ([obj isMemberOfClass:[RaidhoSingleCharacter class]]) {
                [obj enhanceEffectTo:self];
            }
        }
        enduranceAdded *= 2;
        doubleEffect = NO;
    }
    return (int)enduranceAdded;
}

- (int)calculateSmeazDamageTo:(AbstractBattleEnemy *)aEnemy {
    
    float smeazDamage = ((power + powerModifier) * 2.4 * (deathAffinity / aEnemy.deathAffinity) * (essence / maxEssence));
    if (doubleEffect) {
        for (RaidhoSingleCharacter *obj in sharedGameController.currentScene.activeObjects) {
            if ([obj isMemberOfClass:[RaidhoSingleCharacter class]]) {
                [obj enhanceEffectTo:aEnemy];
            }
        }
        smeazDamage *= 2;
        doubleEffect = NO;
    }
    return (int)smeazDamage;
}

- (float)calculateSmeazDuration {
    
    float smeazDuration = ((affinity + affinityModifier + deathAffinity) * 0.8 * (essence / maxEssence));
    if (doubleEffect) {
        for (RaidhoSingleCharacter *obj in sharedGameController.currentScene.activeObjects) {
            if ([obj isMemberOfClass:[RaidhoSingleCharacter class]]) {
                [obj enhanceEffectTo:self];
            }
        }
        smeazDuration *= 2;
        doubleEffect = NO;
    }
    return smeazDuration;
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

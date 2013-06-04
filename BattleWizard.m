//
//  BattleWizard.m
//  TEORBattleTest
//
//  Created by Zach Babb on 5/25/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "BattleWizard.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleAnimation.h"
#import "AbstractBattleEnemy.h"
#import "BattleValkyrie.h"
#import "BattlePriest.h"
#import "Image.h"
#import "Animation.h"
#import "WizardBones.h"
#import "Bleeder.h"
#import "PackedSpriteSheet.h"
#import "FirstWizardBallAttack.h"
#import "DoomRoll.h"
#import "RollingBones.h"
#import "Textbox.h"
#import "KenazSingleEnemy.h"
#import "KenazAllEnemies.h"
#import "KenazSingleCharacter.h"
#import "KenazAllCharacters.h"
#import "RaidhoSingleEnemy.h"
#import "RaidhoAllEnemies.h"
#import "RaidhoSingleCharacter.h"
#import "RaidhoAllCharacters.h"
#import "MannazSingleEnemy.h"
#import "MannazAllEnemies.h"
#import "MannazSingleCharacter.h"
#import "MannazAllCharacters.h"
#import "TiwazSingleEnemy.h"
#import "TiwazAllEnemies.h"
#import "TiwazSingleCharacter.h"
#import "TiwazAllCharacters.h"
#import "IngwazSingleEnemy.h"
#import "IngwazAllEnemies.h"
#import "IngwazSingleCharacter.h"
#import "IngwazAllCharacters.h"
#import "FyrazSingleEnemy.h"
#import "FyrazAllEnemies.h"
#import "FyrazSingleCharacter.h"
#import "FyrazAllCharacters.h"
#import "DaleythSingleEnemy.h"
#import "DaleythAllEnemies.h"
#import "DaleythSingleCharacter.h"
#import "DaleythAllCharacters.h"
#import "EkwazSingleEnemy.h"
#import "EkwazAllEnemies.h"
#import "EkwazSingleCharacter.h"
#import "EkwazAllCharacters.h"


@implementation BattleWizard

@synthesize divinationTimer;

- (id)initWithBattleLocation:(int)aLocation {
	
	if (self = [super init]) {
		
		Image *wizard = [sharedGameController.teorPSS imageForKey:@"Wizard50x80.png"];
		currentTurnAnimation = [[Animation alloc] init];
		[currentTurnAnimation addFrameWithImage:wizard delay:0.3];
		currentTurnAnimation.state = kAnimationState_Stopped;
		[wizard release];
		currentAnimation = currentTurnAnimation;
		battleLocation = aLocation;
		whichCharacter = kWizard;
		[super initBattleAttributes];
		selectorImage.renderPoint = CGPointMake(renderPoint.x, renderPoint.y - 40);
		wizardBall = [sharedGameController.teorPSS imageForKey:@"WizardBall15x15.png"];
		essenceColor = essenceMeter.color = Color4fMake(1.0, 0.0, 1.0, 1.0);
	}
	
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	[super updateWithDelta:aDelta];
	if (wizardBallTimerOn) {
		wizardBall.scale = Scale2fMake(wizardBall.scale.x + aDelta, wizardBall.scale.y + aDelta);
		if (wizardBall.scale.x > 3.0) {
			wizardBall.scale = Scale2fMake(3.0, 3.0);
		}
	}
	if (divinationTimer > 0) {
		divinationTimer -= aDelta;
		if (divinationTimer < 0) {
			divinationTimer = 0;
			Textbox *tb = [[Textbox alloc] initWithRect:CGRectMake(100, 0, 380, 40) color:Color4fMake(0, 0, 0.7, 0.5) duration:0.7 animating:NO text:@"Reaper shows up to attack everyone."];
			[sharedGameController.currentScene addObjectToActiveObjects:tb];
			[tb release];			
			[sharedGameController.currentScene addObjectToActiveObjects:queuedDivination];
			[queuedDivination release];
			queuedDivination = nil;
		}
	}
}

- (void)render {
	
	[super render];
	if (wizardBallTimerOn) {
		[wizardBall renderCenteredAtPoint:wizardBall.renderPoint];
	}
}

- (void)startWizardAttack {
	wizardBallTimerOn = YES;
	wizardBall.scale = Scale2fMake(0.5, 0.5);
	wizardBall.renderPoint = CGPointMake(renderPoint.x + 30, renderPoint.y + 30);
}

- (void)stopWizardAttack {
	wizardBallTimerOn = NO;
}

- (void)unlockGeboPotential {
    
    if (geboPotential) {
        return;
    }
    stoneAffinity += 5;
    fireAffinity += 5;
    [self increasePowerModifierBy:5];
    [self increaseAffinityModifierBy:5];
    geboPotential = YES;
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
            FirstWizardBallAttack *fwba = [[FirstWizardBallAttack alloc] initToEnemy:aEnemy waiting:i + 0.5];
            [sharedGameController.currentScene addObjectToActiveObjects:fwba];
            [fwba release];
            doubleAttack--;
        }
        if (attackAttacksAllEnemies) {
            for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
                if ([enemy isKindOfClass:[AbstractBattleEnemy class]] && enemy.isAlive && enemy != aEnemy) {
                    //Maybe make a fresh object here that's the same for everyone.
                    FirstWizardBallAttack *extraAttack = [[FirstWizardBallAttack alloc] initToEnemy:enemy waiting:0.3];
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
        
        wizardBallTimerOn = NO;
        FirstWizardBallAttack *fwba = [[FirstWizardBallAttack alloc] initToEnemy:aEnemy waiting:i];
        [sharedGameController.currentScene addObjectToActiveObjects:fwba];
        [fwba release];

    }
        
    int enduranceLost = maxEndurance * (wizardBall.scale.x / 3);
    if (enduranceDoesNotDeplete) {
        enduranceLost = 0;
    }
    if (halfEnduranceExpenditure) {
        enduranceLost /= 2;
    }
    
    endurance -= enduranceLost;
    

	
}

- (void)makeWizardBallPower:(float)aPower {
	wizardBall.scale = Scale2fMake(aPower, aPower);
}

- (float)findWizardBallPower {
	return wizardBall.scale.x;
}

- (void)rollBones {
	RollingBones *wizardBones = [[RollingBones alloc] init];
	[sharedGameController.currentScene addObjectToActiveObjects:wizardBones];
	[wizardBones release];	
}

- (void)resetBattleTimer {
	
	battleTimer = 0.0;
	currentTurn = NO;
}

- (void)queueRune:(int)aRune {
	
	[super queueRune:aRune];
	[sharedInputManager setState:kWizardRunePlacement];
}

- (void)runeWasPlacedOnEnemy:(AbstractBattleEnemy *)aEnemy {
	
	[super runeWasPlacedOnEnemy:aEnemy];
	switch (queuedRuneNumber) {
		case 120:
			queuedRuneNumber = 0;
			KenazSingleEnemy *kse = [[KenazSingleEnemy alloc] initToEnemy:aEnemy];
			[sharedGameController.currentScene addObjectToActiveObjects:kse];
			[kse release];
            essence -= 12;
			break;
        case 288:
            queuedRuneNumber = 0;
            RaidhoSingleEnemy *rse = [[RaidhoSingleEnemy alloc] initToEnemy:aEnemy];
            [sharedGameController.currentScene addObjectToActiveObjects:rse];
            [rse release];
            essence -= 10;
            break;
        case 252:
            queuedRuneNumber = 0;
            MannazSingleEnemy *mse = [[MannazSingleEnemy alloc] initToEnemy:aEnemy];
            [sharedGameController.currentScene addObjectToActiveObjects:mse];
            [mse release];
            essence -= 32;
            break;
        case 157:
            queuedRuneNumber = 0;
            TiwazSingleEnemy *tse = [[TiwazSingleEnemy alloc] initToEnemy:aEnemy];
            [sharedGameController.currentScene addObjectToActiveObjects:tse];
            [tse release];
            essence -= 48;
            break;
        case 287:
            queuedRuneNumber = 0;
            IngwazSingleEnemy *ise = [[IngwazSingleEnemy alloc] initToEnemy:aEnemy];
            [sharedGameController.currentScene addObjectToActiveObjects:ise];
            [ise release];
            essence -= 35;
            break;
        case 169:
            queuedRuneNumber = 0;
            FyrazSingleEnemy *fse = [[FyrazSingleEnemy alloc] initToEnemy:aEnemy];
            [sharedGameController.currentScene addObjectToActiveObjects:fse];
            [fse release];
            essence -= 44;
            break;
        case 143:
            queuedRuneNumber = 0;
            DaleythSingleEnemy *dse = [[DaleythSingleEnemy alloc] initToEnemy:aEnemy];
            [sharedGameController.currentScene addObjectToActiveObjects:dse];
            [dse release];
            essence -= 22;
            break;
        case 145:
            queuedRuneNumber = 0;
            EkwazSingleEnemy *ese = [[EkwazSingleEnemy alloc] initToEnemy:aEnemy];
            [sharedGameController.currentScene addObjectToActiveObjects:ese];
            [ese release];
            essence -= 14;
            break;
		default:
			break;
	}
}

- (void)runeWasPlacedOnCharacter:(AbstractBattleCharacter *)aCharacter {

	[super runeWasPlacedOnCharacter:aCharacter];
	switch (queuedRuneNumber) {
		case 120:
			queuedRuneNumber = 0;
			KenazSingleCharacter *ksc = [[KenazSingleCharacter alloc] initToCharacter:aCharacter];
			[sharedGameController.currentScene addObjectToActiveObjects:ksc];
			[ksc release];
            essence -= 12;
			break;
        case 288:
            queuedRuneNumber = 0;
            RaidhoSingleCharacter *rsc = [[RaidhoSingleCharacter alloc] initToCharacter:aCharacter];
            [sharedGameController.currentScene addObjectToActiveObjects:rsc];
            [rsc release];
            essence -= 28;
            break;
        case 252:
            queuedRuneNumber = 0;
            [MannazSingleCharacter grantFireAttackTo:aCharacter];
            essence -= 18;
            break;
        case 157:
            queuedRuneNumber = 0;
            TiwazSingleCharacter *tsc = [[TiwazSingleCharacter alloc] initToCharacter:aCharacter];
            [sharedGameController.currentScene addObjectToActiveObjects:tsc];
            [tsc release];
            essence -= 25;
            break;
        case 287:
            queuedRuneNumber = 0;
            [IngwazSingleCharacter grantStoneAttackTo:aCharacter];
            essence -= 18;
            break;
        case 169:
            queuedRuneNumber = 0;
            FyrazSingleCharacter *fsc = [[FyrazSingleCharacter alloc] initToCharacter:aCharacter];
            [sharedGameController.currentScene addObjectToActiveObjects:fsc];
            [fsc release];
            essence -= 25;
            break;
        case 143:
            queuedRuneNumber = 0;
            DaleythSingleCharacter *dsc = [[DaleythSingleCharacter alloc] initToCharacter:aCharacter];
            [sharedGameController.currentScene addObjectToActiveObjects:dsc];
            [dsc release];
            essence -= 24;
            break;
        case 145:
            queuedRuneNumber = 0;
            EkwazSingleCharacter *esc = [[EkwazSingleCharacter alloc] initToCharacter:aCharacter];
            [sharedGameController.currentScene addObjectToActiveObjects:esc];
            [esc release];
            essence -= 18;
            break;
		default:
			break;
	}
	
}

- (void)runeAffectedAllEnemies {
	
	[super runeAffectedAllEnemies];
	switch (queuedRuneNumber) {
		case 120:
			queuedRuneNumber = 0;
			KenazAllEnemies *kae = [[KenazAllEnemies alloc] init];
			[sharedGameController.currentScene addObjectToActiveObjects:kae];
			[kae release];
            essence -= 8;
			break;
        case 288:
            queuedRuneNumber = 0;
            RaidhoAllEnemies *rae = [[RaidhoAllEnemies alloc] init];
            [sharedGameController.currentScene addObjectToActiveObjects:rae];
            [rae release];
            essence -= 15;
            break;
        case 252:
            queuedRuneNumber = 0;
            MannazAllEnemies *mae = [[MannazAllEnemies alloc] init];
            [sharedGameController.currentScene addObjectToActiveObjects:mae];
            [mae release];
            essence -= 43;
            break;
        case 157:
            queuedRuneNumber = 0;
            TiwazAllEnemies *tae = [[TiwazAllEnemies alloc] init];
            [sharedGameController.currentScene addObjectToActiveObjects:tae];
            [tae release];
            essence -= 70;
            break;
        case 287:
            queuedRuneNumber = 0;
            IngwazAllEnemies *iae = [[IngwazAllEnemies alloc] init];
            [sharedGameController.currentScene addObjectToActiveObjects:iae];
            [iae release];
            essence -= 55;
            break;
        case 169:
            queuedRuneNumber = 0;
            FyrazAllEnemies *fae = [[FyrazAllEnemies alloc] init];
            [sharedGameController.currentScene addObjectToActiveObjects:fae];
            [fae release];
            essence -= 65;
            break;
        case 143:
            queuedRuneNumber = 0;
            DaleythAllEnemies *dae = [[DaleythAllEnemies alloc] init];
            [sharedGameController.currentScene addObjectToActiveObjects:dae];
            [dae release];
            essence -= 38;
            break;
        case 145:
            queuedRuneNumber = 0;
            EkwazAllEnemies *eae = [[EkwazAllEnemies alloc] init];
            [sharedGameController.currentScene addObjectToActiveObjects:eae];
            [eae release];
            essence -= 24;
            break;
		default:
			break;
	}
}

- (void)runeAffectedAllCharacters {
	
	[super runeAffectedAllCharacters];
	switch (queuedRuneNumber) {
		case 120:
			queuedRuneNumber = 0;
			KenazAllCharacters *kac = [[KenazAllCharacters alloc] init];
			[sharedGameController.currentScene addObjectToActiveObjects:kac];
			[kac release];
            essence -= 22;
			break;
        case 288:
            queuedRuneNumber = 0;
            RaidhoAllCharacters *rac = [[RaidhoAllCharacters alloc] init];
            [sharedGameController.currentScene addObjectToActiveObjects:rac];
            [rac release];
            essence -= 18;
            break;
        case 252:
            queuedRuneNumber = 0;
            [MannazAllCharacters grantFireShields];
            essence -= 16;
            break;
        case 157:
            queuedRuneNumber = 0;
            TiwazAllCharacters *tac = [[TiwazAllCharacters alloc] init];
            [sharedGameController.currentScene addObjectToActiveObjects:tac];
            [tac release];
            essence -= 24;
            break;
        case 287:
            queuedRuneNumber = 0;
            [IngwazAllCharacters grantStoneShields];
            essence -= 16;
            break;
        case 169:
            queuedRuneNumber = 0;
            FyrazAllCharacters *fac = [[FyrazAllCharacters alloc] init];
            [sharedGameController.currentScene addObjectToActiveObjects:fac];
            [fac release];
            if (essence > 0) {
                essence -= essence;
            }
            break;
        case 143:
            queuedRuneNumber = 0;
            [DaleythAllCharacters accelerateTime];
            essence -= 25;
            break;
        case 145:
            queuedRuneNumber = 0;
            EkwazAllCharacters *eac = [[EkwazAllCharacters alloc] init];
            [sharedGameController.currentScene addObjectToActiveObjects:eac];
            [eac release];
            essence -= 23;
            break;
		default:
			break;
	}
}
	

- (void)youRolledA:(int)aRoll {
	
	/*switch (aRoll) {
		case 1:
			//Add objects for divination here that will be added to active objects
			//once the timer goes down.
			break;
		default:
			break;
	}*/
	/*Textbox *tb = [[Textbox alloc] initWithRect:CGRectMake(100, 0, 380, 40) color:Color4fMake(0, 0, 0.7, 0.5) duration:0.5 animating:NO text:@"I feel a doom is upon you..."];
	[sharedGameController.currentScene addObjectToActiveObjects:tb];
	[tb release];*/
	queuedDivination = [[DoomRoll alloc] init];
	divinationTimer = 12;
}

- (int)calculateAttackDamageTo:(AbstractBattleEnemy *)aEnemy {
    
    float tempDamage = (((strength + strengthModifier + power + powerModifier) / 3.3 ) * (5 * wizardBall.scale.x)) - (aEnemy.dexterity + aEnemy.dexterityModifier + aEnemy.agility + aEnemy.agilityModifier + aEnemy.affinity + aEnemy.affinityModifier);
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
    tempDamage *= ((endurance / maxEndurance) + 0.05);
    if (wizardBall.scale.x > 1.5) {
        tempDamage += (arc4random() % (int)((level + levelModifier) * 4));
    }
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

- (void)initBattleAttributes {
    
    wizardBallTimerOn = NO;
    [super initBattleAttributes];
}

- (int)calculateKenazDamageTo:(AbstractBattleEnemy *)aEnemy {
    
    float kenazDamage = ((power + powerModifier) * 6  - aEnemy.affinity - aEnemy.affinityModifier) * (fireAffinity / aEnemy.fireAffinity) * (essence / maxEssence);
    if (doubleEffect) {
        for (RaidhoSingleCharacter *obj in sharedGameController.currentScene.activeObjects) {
            if ([obj isMemberOfClass:[RaidhoSingleCharacter class]]) {
                [obj enhanceEffectTo:aEnemy];
            }
        }
        kenazDamage *= 2;
        doubleEffect = NO;
    }
    return (int)kenazDamage;
}

- (int)calculateRaidhoSlothRollTo:(AbstractBattleEnemy *)aEnemy {
    
    float raidhoRoll = ((affinity + affinityModifier) * (rageAffinity / aEnemy.rageAffinity) * (essence / maxEssence));
    if (doubleEffect) {
        for (RaidhoSingleCharacter *obj in sharedGameController.currentScene.activeObjects) {
            if ([obj isMemberOfClass:[RaidhoSingleCharacter class]]) {
                [obj enhanceEffectTo:aEnemy];
            }
        }
        raidhoRoll *= 2;
        doubleEffect = NO;
    }
    return (int)raidhoRoll;
}

- (int)calculateMannazSoldierCountTo:(AbstractBattleEnemy *)aEnemy {
    
    float soldierCount = ((power + powerModifier + fireAffinity - aEnemy.fireAffinity) / 4) * (essence / maxEssence);
    if (doubleEffect) {
        for (RaidhoSingleCharacter *obj in sharedGameController.currentScene.activeObjects) {
            if ([obj isMemberOfClass:[RaidhoSingleCharacter class]]) {
                [obj enhanceEffectTo:aEnemy];
            }
        }
        soldierCount *= 2;
        doubleEffect = NO;
    }
    return (int)soldierCount;
}

- (int)calculateTiwazDamageTo:(AbstractBattleEnemy *)aEnemy {
    
    float tiwazDamage = ((power + powerModifier) * 4.7 * (stoneAffinity / aEnemy.stoneAffinity) * (essence / maxEssence));
    if (doubleEffect) {
        for (RaidhoSingleCharacter *obj in sharedGameController.currentScene.activeObjects) {
            if ([obj isMemberOfClass:[RaidhoSingleCharacter class]]) {
                [obj enhanceEffectTo:aEnemy];
            }
        }
        tiwazDamage *= 2;
        doubleEffect = NO;
    }
    return (int)tiwazDamage;
}

- (float)calculateTiwazDurationTo:(AbstractBattleCharacter *)aCharacter {
    
    float tiwazDuration = ((affinity + affinityModifier) / 2 * ((stoneAffinity + aCharacter.stoneAffinity) / 3) * (essence / maxEssence));
    if (doubleEffect) {
        for (RaidhoSingleCharacter *obj in sharedGameController.currentScene.activeObjects) {
            if ([obj isMemberOfClass:[RaidhoSingleCharacter class]]) {
                [obj enhanceEffectTo:aCharacter];
            }
        }
        tiwazDuration *= 2;
        doubleEffect = NO;
    }
    //NSLog(@"TiwazDuration is: %f", tiwazDuration);
    return tiwazDuration;
}

- (int)calculateIngwazDamageTo:(AbstractBattleEnemy *)aEnemy {
    
    float ingwazDamage = ((power + powerModifier) * 6 * (stoneAffinity / aEnemy.stoneAffinity) * (essence / maxEssence));
    if (doubleEffect) {
        for (RaidhoSingleCharacter *obj in sharedGameController.currentScene.activeObjects) {
            if ([obj isMemberOfClass:[RaidhoSingleCharacter class]]) {
                [obj enhanceEffectTo:aEnemy];
            }
        }
        ingwazDamage *= 2;
        doubleEffect = NO;
    }
    return (int)ingwazDamage;
}

- (int)calculateFyrazDamageTo:(AbstractBattleEnemy *)aEnemy {
    
    float fyrazDamage = ((power * 4 + powerModifier - aEnemy.affinity - aEnemy.affinityModifier) * 7 * (fireAffinity / aEnemy.fireAffinity) * (essence / maxEssence));
    if (doubleEffect) {
        for (RaidhoSingleCharacter *obj in sharedGameController.currentScene.activeObjects) {
            if ([obj isMemberOfClass:[RaidhoSingleCharacter class]]) {
                [obj enhanceEffectTo:aEnemy];
            }
        }
        fyrazDamage *= 2;
        doubleEffect = NO;
    }
    return (int)fyrazDamage;
}

- (float)calculateFyrazEssenceGiven {
    
    float essenceGiven = (essence + fireAffinity) * 0.7;
    if (doubleEffect) {
        for (RaidhoSingleCharacter *obj in sharedGameController.currentScene.activeObjects) {
            if ([obj isMemberOfClass:[RaidhoSingleCharacter class]]) {
                [obj enhanceEffectTo:self];
            }
        }
        essenceGiven *= 2;
        doubleEffect = NO;
    }
    return essenceGiven;
}

- (int)calculateDaleythDamageTo:(AbstractBattleEnemy *)aEnemy {
    
    float daleythDamage = ((power + powerModifier + divineAffinity - aEnemy.divineAffinity - aEnemy.affinity - aEnemy.affinityModifier) * 3.4 * (divineAffinity / aEnemy.divineAffinity) * (essence / maxEssence));
    if (doubleEffect) {
        for (RaidhoSingleCharacter *obj in sharedGameController.currentScene.activeObjects) {
            if ([obj isMemberOfClass:[RaidhoSingleCharacter class]]) {
                [obj enhanceEffectTo:self];
            }
        }
        daleythDamage *= 2;
        doubleEffect = NO;
    }
    return (int)daleythDamage;
}

- (int)calculateDaleythHealingTo:(AbstractBattleCharacter *)aCharacter {
    
    float daleythHealing = aCharacter.maxHP;
    daleythHealing *= (essence / maxEssence);
    daleythHealing += divineAffinity;
    if (doubleEffect) {
        for (RaidhoSingleCharacter *obj in sharedGameController.currentScene.activeObjects) {
            if ([obj isMemberOfClass:[RaidhoSingleCharacter class]]) {
                [obj enhanceEffectTo:aCharacter];
            }
        }
        daleythHealing *= 2;
        doubleEffect = NO;
    }
    return (int)daleythHealing;
}

- (void)accelerateTime {
    
    if (divinationTimer > 0) {
        float tempTime = (affinity + affinityModifier + divineAffinity) * 0.25;
        tempTime *= (essence / maxEssence);
        divinationTimer -= tempTime;
        divinationTimer = MAX(divinationTimer, 2);
    } else {
        for (AbstractBattleCharacter *character in sharedGameController.currentScene.activeEntities) {
            if ([character isKindOfClass:[AbstractBattleCharacter class]] && character.isAlive) {
                [character updateWithDelta:1];
            }
        }
    }
}

- (int)calculateEkwazDamageTo:(AbstractBattleEnemy *)aEnemy {
    
    float ekwazDamage = ((power + powerModifier - aEnemy.affinity - aEnemy.affinityModifier) * 3.2 * (stoneAffinity / aEnemy.stoneAffinity) * (essence / maxEssence));
    if (doubleEffect) {
        for (RaidhoSingleCharacter *obj in sharedGameController.currentScene.activeObjects) {
            if ([obj isMemberOfClass:[RaidhoSingleCharacter class]]) {
                [obj enhanceEffectTo:aEnemy];
            }
        }
        ekwazDamage *= 2;
        doubleEffect = NO;
    }
    return (int)ekwazDamage;
}

- (float)calculateEkwazTotalDamage {
    
    float totalDamage = (power + powerModifier);
    for (AbstractBattleCharacter *character in sharedGameController.currentScene.activeEntities) {
        if ([character isKindOfClass:[AbstractBattleCharacter class]] && character.isAlive) {
            totalDamage += character.strength + character.strengthModifier + character.stoneAffinity;
        }
    }
    totalDamage *= 2.6;
    totalDamage *= (essence / maxEssence);
    if (doubleEffect) {
        for (RaidhoSingleCharacter *obj in sharedGameController.currentScene.activeObjects) {
            if ([obj isMemberOfClass:[RaidhoSingleCharacter class]]) {
                [obj enhanceEffectTo:self];
            }
        }
        totalDamage *= 2;
        doubleEffect = NO;
    }
    return totalDamage;
}

- (float)calculateEkwazDurationTo:(AbstractBattleCharacter *)aCharacter {
    
    float ekwazDuration = ((affinity + affinityModifier + stoneAffinity + aCharacter.stoneAffinity) * 1.5 * (essence / maxEssence));
    if (doubleEffect) {
        for (RaidhoSingleCharacter *obj in sharedGameController.currentScene.activeObjects) {
            if ([obj isMemberOfClass:[RaidhoSingleCharacter class]]) {
                [obj enhanceEffectTo:aCharacter];
            }
        }
        ekwazDuration *= 2;
        doubleEffect = NO;
    }
    return ekwazDuration;
}

@end

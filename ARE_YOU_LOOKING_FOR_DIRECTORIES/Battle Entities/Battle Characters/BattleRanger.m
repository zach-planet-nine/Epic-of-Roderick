//
//  BattleRanger.m
//  TEORBattleTest
//
//  Created by Zach Babb on 5/25/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "BattleRanger.h"
#import "AbstractScene.h"
#import "AbstractBattleAnimalEntity.h"
#import "AbstractBattleEnemy.h"
#import "BattleValkyrie.h"
#import "BattlePriest.h"
#import "Image.h"
#import "Animation.h"
#import "TargetObject.h"
#import "TouchManager.h"
#import "GameController.h"
#import "InputManager.h"
#import "PackedSpriteSheet.h"
#import "RaidhoSingleCharacter.h"
#import "Frog.h"
#import "Hawk.h"
#import "Bleeder.h"
#import "FirstArrowShot.h"
#import "EihwazSingleEnemy.h"
#import "EihwazAllEnemies.h"
#import "EihwazSingleCharacter.h"
#import "EihwazAllCharacters.h"
#import "FehuSingleEnemy.h"
#import "FehuAllEnemies.h"
#import "FehuSingleCharacter.h"
#import "FehuAllCharacters.h"
#import "UruzSingleEnemy.h"
#import "UruzAllEnemies.h"
#import "UruzSingleCharacter.h"
#import "UruzAllCharacters.h"
#import "ThurisazSingleEnemy.h"
#import "ThurisazAllEnemies.h"
#import "ThurisazSingleCharacter.h"
#import "ThurisazAllCharacters.h"
#import "AlgizSingleEnemy.h"
#import "AlgizAllEnemies.h"
#import "AlgizSingleCharacter.h"
#import "AlgizAllCharacters.h"
#import "LaguzSingleEnemy.h"
#import "LaguzAllEnemies.h"
#import "LaguzSingleCharacter.h"
#import "LaguzAllCharacters.h"
#import "HoppatSingleEnemy.h"
#import "HoppatAllEnemies.h"
#import "HoppatSingleCharacter.h"
#import "HoppatAllCharacters.h"
#import "SwopazSingleEnemy.h"
#import "SwopazAllEnemies.h"
#import "SwopazSingleCharacter.h"
#import "SwopazAllCharacters.h"


@implementation BattleRanger

@synthesize currentAnimal;

- (id)initWithBattleLocation:(int)aLocation {
	
	if (self = [super init]) {
		
		Image *ranger = [sharedGameController.teorPSS imageForKey:@"Ranger50x80.png"];
		currentTurnAnimation = [[Animation alloc] init];
		[currentTurnAnimation addFrameWithImage:ranger delay:0.3];
		currentTurnAnimation.state = kAnimationState_Stopped;
		[ranger release];
		currentAnimation = currentTurnAnimation;
		battleLocation = aLocation;
		whichCharacter = kRanger;
		currentAnimal = [[Hawk alloc] init];
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
		essenceColor = essenceMeter.color = Color4fMake(0.0, 1.0, 0.0, 1.0);
		targetOn = NO;
		target.renderPoint = CGPointMake(360, 160);
		
	}
	
	return self;
}

- (void)initBattleAttributes {
    [super initBattleAttributes];
    [currentAnimal joinBattle];
}

- (void)updateWithDelta:(float)aDelta {
	[super updateWithDelta:aDelta];
	[currentAnimal updateWithDelta:aDelta];
}

- (void)render {
	
	[super render];
	[currentAnimal render];
}

- (CGRect)getAnimalRect {
	//Make this different based on animal maybe.
	return CGRectMake(currentAnimal.renderPoint.x - 20, currentAnimal.renderPoint.y - 20, 40, 40);
}

- (void)setTargetPoint:(CGPoint)aPoint {
	
	target.renderPoint = aPoint;
}
	
	

- (CGPoint)getTargetPoint {
	
	return target.renderPoint;
}

- (void)updateTargetLocationWithAcceleration:(UIAcceleration *)aAcceleration {
	
	target.renderPoint = CGPointMake(target.renderPoint.x - (aAcceleration.y * 5), target.renderPoint.y + (aAcceleration.x * 5));
	if (target.renderPoint.x < 240) {
		target.renderPoint = CGPointMake(240, target.renderPoint.y);
	}
	if (target.renderPoint.x > 480) {
		target.renderPoint = CGPointMake(480, target.renderPoint.y);
	}
	if (target.renderPoint.y < 0) {
		target.renderPoint = CGPointMake(target.renderPoint.x, 0);
	}
	if (target.renderPoint.y > 320) {
		target.renderPoint = CGPointMake(target.renderPoint.x, 320);
	}
}

- (void)updateTargetLocationWithX:(float)aX Y:(float)aY Z:(float)aZ {
    target.renderPoint = CGPointMake(target.renderPoint.x - (aY * 5), target.renderPoint.y + (aX * 7));
	if (target.renderPoint.x < 240) {
		target.renderPoint = CGPointMake(240, target.renderPoint.y);
	}
	if (target.renderPoint.x > 480) {
		target.renderPoint = CGPointMake(480, target.renderPoint.y);
	}
	if (target.renderPoint.y < 0) {
		target.renderPoint = CGPointMake(target.renderPoint.x, 0);
	}
	if (target.renderPoint.y > 320) {
		target.renderPoint = CGPointMake(target.renderPoint.x, 320);
	}
}

- (BOOL)isHawkInDefenseMode {
    if ([currentAnimal isMemberOfClass:[Hawk class]]) {
        Hawk *hawker = currentAnimal;
        if (hawker.defenseMode) {
            return YES;
        }
    }
    return NO;
}

- (void)animalWasLinkedToEnemy:(AbstractBattleEnemy *)aEnemy {
    if ([currentAnimal isMemberOfClass:[Hawk class]]) {
        [currentAnimal flyBackToRanger];
    }
	currentAnimal.target = aEnemy;
	//currentAnimal.battleTimer = 3.0;
}

- (void)animalWasLinkedToCharacter:(AbstractBattleCharacter *)aCharacter {
	if ([currentAnimal isMemberOfClass:[Hawk class]] && currentAnimal.target != aCharacter) {
        [currentAnimal flyBackToRanger];
    }
	currentAnimal.target = aCharacter;
	//currentAnimal.battleTimer = 3.0;
}

- (void)animalWasLinkedToAllEnemies {
	if ([currentAnimal isMemberOfClass:[Hawk class]]) {
        [currentAnimal flyBackToRanger];
    }
	currentAnimal.allEnemies = YES;
	//currentAnimal.battleTimer = 3.0;
}

- (void)animalWasLinkedToAllCharacters {
	if ([currentAnimal isMemberOfClass:[Hawk class]]) {
        [currentAnimal flyBackToRanger];
    }
	currentAnimal.allCharacters = YES;
	//currentAnimal.battleTimer = 3.0;
}

- (void)resetBattleTimer {
	
	battleTimer = 0.0;
	currentTurn = NO;
}

- (void)queueRune:(int)aRune {
	
	[super queueRune:aRune];
	[sharedInputManager setState:kRangerRunePlacement];
}

- (void)runeWasPlacedOnEnemy:(AbstractBattleEnemy *)aEnemy {
	
	[super runeWasPlacedOnEnemy:aEnemy];
	switch (queuedRuneNumber) {
		case 195:
			queuedRuneNumber = 0;
			EihwazSingleEnemy *ese = [[EihwazSingleEnemy alloc] initToEnemy:aEnemy];
			[sharedGameController.currentScene addObjectToActiveObjects:ese];
			[ese release];
            essence -= 14;
			break;
        case 149:
            queuedRuneNumber = 0;
            FehuSingleEnemy *fse = [[FehuSingleEnemy alloc] initToEnemy:aEnemy];
            [sharedGameController.currentScene addObjectToActiveObjects:fse];
            [fse release];
            essence -= 12;
            break;
        case 117:
            queuedRuneNumber = 0;
            UruzSingleEnemy *use = [[UruzSingleEnemy alloc] initToEnemy:aEnemy];
            [sharedGameController.currentScene addObjectToActiveObjects:use];
            [use release];
            essence -= 32;
            break;
        case 175:
            queuedRuneNumber = 0;
            ThurisazSingleEnemy *tse = [[ThurisazSingleEnemy alloc] initToEnemy:aEnemy];
            [sharedGameController.currentScene addObjectToActiveObjects:tse];
            [tse release];
            essence -= 24;
            break;
        case 209:
            queuedRuneNumber = 0;
            AlgizSingleEnemy *ase = [[AlgizSingleEnemy alloc] initToEnemy:aEnemy];
            [sharedGameController.currentScene addObjectToActiveObjects:ase];
            [ase release];
            essence -= 19;
            break;
        case 104:
            queuedRuneNumber = 0;
            LaguzSingleEnemy *lse = [[LaguzSingleEnemy alloc] initToEnemy:aEnemy];
            [sharedGameController.currentScene addObjectToActiveObjects:lse];
            [lse release];
            essence -= 15;
            break;
        case 187:
            queuedRuneNumber = 0;
            HoppatSingleEnemy *hse = [[HoppatSingleEnemy alloc] initToEnemy:aEnemy];
            [sharedGameController.currentScene addObjectToActiveObjects:hse];
            [hse release];
            essence -= 20;
            break;
        case 135:
            queuedRuneNumber = 0;
            SwopazSingleEnemy *sse = [[SwopazSingleEnemy alloc] initToEnemy:aEnemy];
            [sharedGameController.currentScene addObjectToActiveObjects:sse];
            [sse release];
            essence -= 25;
            break;
		default:
			break;
	}
}

- (void)runeWasPlacedOnCharacter:(AbstractBattleCharacter *)aCharacter {
	
	[super runeWasPlacedOnCharacter:aCharacter];
	switch (queuedRuneNumber) {
		case 195:
            queuedRuneNumber = 0;
			[EihwazSingleCharacter grantPoisonElementTo:aCharacter];
            essence -= 18;
			break;
        case 149:
            queuedRuneNumber = 0;
            FehuSingleCharacter *fsc = [[FehuSingleCharacter alloc] initToCharacter:aCharacter];
            [sharedGameController.currentScene addObjectToActiveObjects:fsc];
            [fsc release];
            essence -= 20;
            break;
        case 117:
            queuedRuneNumber = 0;
            UruzSingleCharacter *usc = [[UruzSingleCharacter alloc] initToCharacter:aCharacter];
            [sharedGameController.currentScene addObjectToActiveObjects:usc];
            [usc release];
            essence -= 32;
            break;
        case 175:
            queuedRuneNumber = 0;
            [ThurisazSingleCharacter grantWoodElementTo:aCharacter];
            essence -= 18;
            break;
        case 209:
            queuedRuneNumber = 0;
            AlgizSingleCharacter *asc = [[AlgizSingleCharacter alloc] initToCharacter:aCharacter];
            [sharedGameController.currentScene addObjectToActiveObjects:asc];
            [asc release];
            essence -= 22;
            break;
        case 104:
            queuedRuneNumber = 0;
            LaguzSingleCharacter *lsc = [[LaguzSingleCharacter alloc] initToCharacter:aCharacter];
            [sharedGameController.currentScene addObjectToActiveObjects:lsc];
            [lsc release];
            essence -= 24;
            break;
        case 187:
            queuedRuneNumber = 0;
            HoppatSingleCharacter *hsc = [[HoppatSingleCharacter alloc] initToCharacter:aCharacter];
            [sharedGameController.currentScene addObjectToActiveObjects:hsc];
            [hsc release];
            essence -= 18;
            break;
        case 135:
            queuedRuneNumber = 0;
            SwopazSingleCharacter *ssc = [[SwopazSingleCharacter alloc] initToCharacter:aCharacter];
            [sharedGameController.currentScene addObjectToActiveObjects:ssc];
            [ssc release];
            essence -= 16;
            break;
		default:
			break;
	}
}

- (void)runeAffectedAllEnemies {
	
	[super runeAffectedAllEnemies];
	switch (queuedRuneNumber) {
		case 195:
			queuedRuneNumber = 0;
			EihwazAllEnemies *eae = [[EihwazAllEnemies alloc] init];
			[sharedGameController.currentScene addObjectToActiveObjects:eae];
			[eae release];
            essence -= 14;
			break;
        case 149:
            queuedRuneNumber = 0;
            FehuAllEnemies *fae = [[FehuAllEnemies alloc] init];
            [sharedGameController.currentScene addObjectToActiveObjects:fae];
            [fae release];
            essence -= 24;
            break;
        case 117:
            queuedRuneNumber = 0;
            UruzAllEnemies *uae = [[UruzAllEnemies alloc] init];
            [sharedGameController.currentScene addObjectToActiveObjects:uae];
            [uae release];
            essence -= 42;
            break;
        case 175:
            queuedRuneNumber = 0;
            ThurisazAllEnemies *tae = [[ThurisazAllEnemies alloc] init];
            [sharedGameController.currentScene addObjectToActiveObjects:tae];
            [tae release];
            essence -= 36;
            break;
        case 209:
            queuedRuneNumber = 0;
            AlgizAllEnemies *aae = [[AlgizAllEnemies alloc] init];
            [sharedGameController.currentScene addObjectToActiveObjects:aae];
            [aae release];
            essence -= 23;
            break;
        case 104:
            queuedRuneNumber = 0;
            LaguzAllEnemies *lae = [[LaguzAllEnemies alloc] init];
            [sharedGameController.currentScene addObjectToActiveObjects:lae];
            [lae release];
            essence -= 36;
            break;
        case 187:
            queuedRuneNumber = 0;
            HoppatAllEnemies *hae = [[HoppatAllEnemies alloc] init];
            [sharedGameController.currentScene addObjectToActiveObjects:hae];
            [hae release];
            essence -= 42;
            break;
        case 135:
            queuedRuneNumber = 0;
            SwopazAllEnemies *sae = [[SwopazAllEnemies alloc] init];
            [sharedGameController.currentScene addObjectToActiveObjects:sae];
            [sae release];
            essence -= 34;
            break;
		default:
			break;
	}
}

- (void)runeAffectedAllCharacters {
	
	[super runeAffectedAllCharacters];
	switch (queuedRuneNumber) {
		case 195:
            queuedRuneNumber = 0;
			[EihwazAllCharacters grantPoisonShields];
            essence -= 18;
			break;
        case 149:
            queuedRuneNumber = 0;
            [FehuAllCharacters summonDog];
            essence -= maxEssence;
            break;
        case 117:
            queuedRuneNumber = 0;
            [UruzAllCharacters summonBear];
            essence -= maxEssence;
            break;
        case 175:
            queuedRuneNumber = 0;
            [ThurisazAllCharacters grantWoodShields];
            essence -= 24;
            break;
        case 209:
            queuedRuneNumber = 0;
            [AlgizAllCharacters summonSquirrel];
            essence -= maxEssence;
            break;
        case 104:
            queuedRuneNumber = 0;
            [LaguzAllCharacters healAllCharacters];
            essence -= 48;
            break;
        case 187:
            queuedRuneNumber = 0;
            [HoppatAllCharacters summonFrog];
            essence -= maxEssence;
            break;
        case 135:
            queuedRuneNumber = 0;
            [SwopazAllCharacters summonHawk];
            essence -= maxEssence;
            break;
		default:
			break;
	}
}

- (void)battleLocationIs:(int)aLocation {
	
	[super battleLocationIs:aLocation];
	currentAnimal.renderPoint = CGPointMake(renderPoint.x, renderPoint.y - 30);
}

- (void)gainPriority {
	[super gainPriority];
	targetOn = YES;
    target.renderPoint = CGPointMake(360, 160);
	[sharedGameController.currentScene addImageToDrawingImages:target];
}

- (void)relinquishPriority {
	[super relinquishPriority];
	[sharedGameController.currentScene removeDrawingImages];
	targetOn = NO;
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
            FirstArrowShot *fas = [[FirstArrowShot alloc] initToEnemy:aEnemy waiting:i + 0.5];
            [sharedGameController.currentScene addObjectToActiveObjects:fas];
            [fas release];
            doubleAttack--;
        }
        if (attackAttacksAllEnemies) {
            for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
                if ([enemy isKindOfClass:[AbstractBattleEnemy class]] && enemy.isAlive && enemy != aEnemy) {
                    //Maybe make a fresh object here that's the same for everyone.
                    FirstArrowShot *extraAttack = [[FirstArrowShot alloc] initToEnemy:enemy waiting:0.3];
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
        
        [super youAttackedEnemy:aEnemy];
        FirstArrowShot *fas = [[FirstArrowShot alloc] initToEnemy:aEnemy waiting:i];
        [sharedGameController.currentScene addObjectToActiveObjects:fas];
        [fas release];

    }
        
    int enduranceLost = 12 + (level * 0.2);
    if (enduranceDoesNotDeplete) {
        enduranceLost = 0;
    }
    if (halfEnduranceExpenditure) {
        enduranceLost /= 2;
    }
    endurance -= enduranceLost;
}

- (int)calculateAttackDamageTo:(AbstractBattleEnemy *)aEnemy {
    
    float tempDamage = ((dexterity + dexterityModifier) * 3) - (aEnemy.dexterity + aEnemy.dexterityModifier + aEnemy.agility + aEnemy.agilityModifier);
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
    if (doubleEffect) {
        for (RaidhoSingleCharacter *obj in sharedGameController.currentScene.activeObjects) {
            if ([obj isMemberOfClass:[RaidhoSingleCharacter class]]) {
                [obj enhanceEffectTo:aEnemy];
            }
        }
        tempDamage *= 2;
        doubleEffect = NO;
    }
    if (damageEndurance) {
        aEnemy.endurance -= (int)(tempDamage / 100);
    }
    if (damageEssence) {
        aEnemy.essence -= (int)(tempDamage / 100);
    }
    if (attacksRefillItemTimers) {
        //implement refilling here
    }
    if (essenceDrain) {
        essence += MIN((int)((float)(tempDamage / 10)), maxEssence - essence);
    }
    return (int)tempDamage;

}

- (float)calculateFehuDurationTo:(AbstractBattleEnemy *)aEnemy {
    
    float fehuDuration = ((affinity + affinityModifier + level + levelModifier - aEnemy.level - aEnemy.levelModifier) * (lifeAffinity / aEnemy.lifeAffinity) * (essence / maxEssence));
    if (doubleEffect) {
        for (RaidhoSingleCharacter *obj in sharedGameController.currentScene.activeObjects) {
            if ([obj isMemberOfClass:[RaidhoSingleCharacter class]]) {
                [obj enhanceEffectTo:aEnemy];
            }
        }
        fehuDuration *= 2;
        doubleEffect = NO;
    }
    return fehuDuration;
}

- (float)calculateFehuStatTimeTo:(AbstractBattleEnemy *)aEnemy {
    
    float fehuStatTime = ((affinity + affinityModifier - aEnemy.affinity - aEnemy.affinityModifier) * (lifeAffinity / aEnemy.lifeAffinity) * (essence / maxEssence));
    if (doubleEffect) {
        for (RaidhoSingleCharacter *obj in sharedGameController.currentScene.activeObjects) {
            if ([obj isMemberOfClass:[RaidhoSingleCharacter class]]) {
                [obj enhanceEffectTo:aEnemy];
            }
        }
        fehuStatTime *= 2;
        doubleEffect = NO;
    }
    return fehuStatTime;
}

- (int)calculateUruzDamageTo:(AbstractBattleEnemy *)aEnemy {
    
    float uruzDamage = (((power + powerModifier) * 2 - aEnemy.affinity - aEnemy.affinityModifier) * 8 * (stoneAffinity / aEnemy.stoneAffinity) * (essence / maxEssence));
    if (doubleEffect) {
        for (RaidhoSingleCharacter *obj in sharedGameController.currentScene.activeObjects) {
            if ([obj isMemberOfClass:[RaidhoSingleCharacter class]]) {
                [obj enhanceEffectTo:aEnemy];
            }
        }
        uruzDamage *= 2;
        doubleEffect = NO;
    }
    return uruzDamage;
}

- (float)calculateUruzDurationTo:(AbstractBattleCharacter *)aCharacter {
    
    float uruzDuration = ((affinity + affinityModifier + stoneAffinity + aCharacter.stoneAffinity) + 3) * (essence / maxEssence);
    if (doubleEffect) {
        for (RaidhoSingleCharacter *obj in sharedGameController.currentScene.activeObjects) {
            if ([obj isMemberOfClass:[RaidhoSingleCharacter class]]) {
                [obj enhanceEffectTo:aCharacter];
            }
        }
        uruzDuration *= 2;
        doubleEffect = NO;
    }
    return uruzDuration;
}

- (int)calculateThurisazDamageTo:(AbstractBattleEnemy *)aEnemy {
    
    float thurisazDamage = ((power + powerModifier) * (woodAffinity / aEnemy.woodAffinity) * (essence / maxEssence));
    thurisazDamage *= 0.3;
    if (doubleEffect) {
        for (RaidhoSingleCharacter *obj in sharedGameController.currentScene.activeObjects) {
            if ([obj isMemberOfClass:[RaidhoSingleCharacter class]]) {
                [obj enhanceEffectTo:aEnemy];
            }
        }
        thurisazDamage *= 2;
        doubleEffect = NO;
    }
    return (int)thurisazDamage;
}

- (int)calculateThurisazDamage {
    
    float thurisazDamage = ((power + powerModifier + woodAffinity) / 5 * (essence / maxEssence));
    if (doubleEffect) {
        for (RaidhoSingleCharacter *obj in sharedGameController.currentScene.activeObjects) {
            if ([obj isMemberOfClass:[RaidhoSingleCharacter class]]) {
                [obj enhanceEffectTo:self];
            }
        }
        thurisazDamage *= 2;
        doubleEffect = NO;
    }
    return (int)thurisazDamage;
}

- (float)calculateAlgizDurationTo:(AbstractBattleEnemy *)aEnemy {
    
    float algizDuration = ((affinity + affinityModifier + woodAffinity - aEnemy.affinity - aEnemy.affinityModifier - woodAffinity) * (essence / maxEssence));
    if (doubleEffect) {
        for (RaidhoSingleCharacter *obj in sharedGameController.currentScene.activeObjects) {
            if ([obj isMemberOfClass:[RaidhoSingleCharacter class]]) {
                [obj enhanceEffectTo:aEnemy];
            }
        }
        algizDuration *= 2;
        doubleEffect = NO;
    }
    return algizDuration;
}

- (int)calculateLaguzEnduranceDamageTo:(AbstractBattleEnemy *)aEnemy {
    
    float laguzDamage = ((power + powerModifier) * 3 * (poisonAffinity / aEnemy.poisonAffinity) * (essence / maxEssence));
    if (doubleEffect) {
        for (RaidhoSingleCharacter *obj in sharedGameController.currentScene.activeObjects) {
            if ([obj isMemberOfClass:[RaidhoSingleCharacter class]]) {
                [obj enhanceEffectTo:aEnemy];
            }
        }
        laguzDamage *= 2;
        doubleEffect = NO;
    }
    return (int)laguzDamage;
}

- (int)calculateLaguzDamageTo:(AbstractBattleEnemy *)aEnemy {
    
    float laguzDamage = ((power + powerModifier + poisonAffinity - aEnemy.affinity - aEnemy.affinityModifier - aEnemy.poisonAffinity) * 8 * (essence / maxEssence));
    if (doubleEffect) {
        for (RaidhoSingleCharacter *obj in sharedGameController.currentScene.activeObjects) {
            if ([obj isMemberOfClass:[RaidhoSingleCharacter class]]) {
                [obj enhanceEffectTo:aEnemy];
            }
        }
        laguzDamage *= 2;
        doubleEffect = NO;
    }
    return (int)laguzDamage;
}

- (float)calculateLaguzDuration {
    
    float laguzDuration = ((affinity + affinityModifier + poisonAffinity + level + levelModifier) * (essence / maxEssence));
    if (doubleEffect) {
        for (RaidhoSingleCharacter *obj in sharedGameController.currentScene.activeObjects) {
            if ([obj isMemberOfClass:[RaidhoSingleCharacter class]]) {
                [obj enhanceEffectTo:self];
            }
        }
        laguzDuration *= 2;
        doubleEffect = NO;
    }
    return laguzDuration;
}

- (int)calculateHoppatDurationTo:(AbstractBattleEnemy *)aEnemy {
    
    float hoppatDuration = ((affinity + affinityModifier - aEnemy.affinity - aEnemy.affinityModifier + (RANDOM_0_TO_1() * (luck + luckModifier))) * (poisonAffinity / aEnemy.poisonAffinity) * (essence / maxEssence));
    if (doubleEffect) {
        for (RaidhoSingleCharacter *obj in sharedGameController.currentScene.activeObjects) {
            if ([obj isMemberOfClass:[RaidhoSingleCharacter class]]) {
                [obj enhanceEffectTo:aEnemy];
            }
        }
        hoppatDuration *= 2;
        doubleEffect = NO;
    }
    return (int)hoppatDuration;
}

- (int)calculateHoppatDamageTo:(AbstractBattleEnemy *)aEnemy {
    
    float hoppatDamage = ((power + powerModifier + poisonAffinity - aEnemy.affinity - aEnemy.affinityModifier) * 7 * (poisonAffinity / aEnemy.poisonAffinity) * (essence / maxEssence));
    if (doubleEffect) {
        for (RaidhoSingleCharacter *obj in sharedGameController.currentScene.activeObjects) {
            if ([obj isMemberOfClass:[RaidhoSingleCharacter class]]) {
                [obj enhanceEffectTo:aEnemy];
            }
        }
        hoppatDamage *= 2;
        doubleEffect = NO;
    }
    return (int)hoppatDamage;
}

- (int)calculateSwopazDamageTo:(AbstractBattleEnemy *)aEnemy {
    
    float swopazDamage = ((power + powerModifier - aEnemy.affinity - aEnemy.affinityModifier) * 5 * (woodAffinity / aEnemy.woodAffinity) * (essence / maxEssence));
    if (doubleEffect) {
        for (RaidhoSingleCharacter *obj in sharedGameController.currentScene.activeObjects) {
            if ([obj isMemberOfClass:[RaidhoSingleCharacter class]]) {
                [obj enhanceEffectTo:aEnemy];
            }
        }
        swopazDamage *= 2;
        doubleEffect = NO;
    }
    return (int)swopazDamage;
}

- (float)calculateSwopazDurationTo:(AbstractBattleCharacter *)aCharacter {
    
    float swopazDuration = ((woodAffinity + aCharacter.woodAffinity) * (essence / maxEssence));
    if (doubleEffect) {
        for (RaidhoSingleCharacter *obj in sharedGameController.currentScene.activeObjects) {
            if ([obj isMemberOfClass:[RaidhoSingleCharacter class]]) {
                [obj enhanceEffectTo:aCharacter];
            }
        }
        swopazDuration *= 2;
        doubleEffect = NO;
    }
    return swopazDuration;
}

- (void)unlockGeboPotential {
    
    if (geboPotential) {
        return;
    }
    woodAffinity += 5;
    poisonAffinity += 5;
    [self increaseStrengthModifierBy:5];
    [self increaseAgilityModifierBy:5];
    geboPotential = YES;
}

@end

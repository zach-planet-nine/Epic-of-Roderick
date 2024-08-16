//
//  AbstractBattleCharacter.m
//  TEORBattleTest
//
//  Created by Zach Babb on 5/25/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "AbstractBattleCharacter.h"
#import "AbstractScene.h"
#import "Image.h"
#import "TouchManager.h"
#import "InputManager.h"
#import "OverMind.h"
#import "GameController.h"
#import "Character.h"
#import "RuneObject.h"
#import "AbstractBattleEnemy.h"
#import "Animation.h"
#import "PackedSpriteSheet.h"
#import "HealingAnimation.h"
#import "EssenceAnimation.h"
#import "ElementalShield.h"
#import "WeaponElement.h"
#import "BattleStringAnimation.h"

//For testing
#import "Alfheim.h"



@implementation AbstractBattleCharacter

@synthesize knownRunes;
@synthesize currentTurn;
@synthesize queuedRuneNumber;

- (id)initWithBattleLocation:(int)aLocation {
	return self;
}

- (id)init {
	if (self = [super init]) {
		
		isAlive = YES;
		weaponRuneStones = [[NSMutableArray alloc] init];
		armorRuneStones = [[NSMutableArray alloc] init];
        //currentTurnImage = [sharedGameController.teorPSS imageForKey:@"CurrentTurnImage.png"];
        enduranceMeterImage = [[[sharedGameController.teorPSS imageForKey:@"BattleMeterHorizontal.png"] imageDuplicate] retain];
        essenceMeterImage = [[[sharedGameController.teorPSS imageForKey:@"BattleMeterHorizontal.png"] imageDuplicate] retain];
        hpMeterImage = [[[sharedGameController.teorPSS imageForKey:@"BattleMeterVertical.png"] imageDuplicate] retain];
        enduranceMeter = [[[sharedGameController.teorPSS imageForKey:@"MeterPixels.png"] imageDuplicate] retain];
        essenceMeter = [[[sharedGameController.teorPSS imageForKey:@"MeterPixels.png"] imageDuplicate] retain];
        hpMeter = [[[sharedGameController.teorPSS imageForKey:@"MeterPixels.png"] imageDuplicate] retain];
        hpMeter.color = Color4fMake(0, 0.9, 0, 0.9);
        enduranceMeter.color = Color4fMake(0.7, 0.8, 0.8, 0.9);
	}
	
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	[super updateWithDelta:aDelta];
	[currentAnimation updateWithDelta:aDelta];
	if (currentTurn) {
		if (currentTurnFlashTimer > 0.48 && currentTurnFlashTimer < 0.50) {
			[currentAnimation currentFrameImage].color = Color4fMake(1, 1, 1, 1);
		}
		currentTurnFlashTimer -= aDelta;
		if (currentTurnFlashTimer < 0) {
			[currentAnimation currentFrameImage].color = Color4fMake(1, 1, 0, 1);
			currentTurnFlashTimer = 0.53;
		}
	}
	if (isFlashing) {
		flashTimer -= aDelta;
		if (flashTimer < 0) {
			////NSLog(@"Color alpha is: %f.", [currentAnimation currentFrameImage].color.alpha);
			if ([currentAnimation currentFrameImage].color.alpha < 1) {
				[currentAnimation currentFrameImage].color = Color4fOnes;
				flashes--;
				flashTimer = 0.04;
				if (flashes == 0) {
					isFlashing = NO;
				}
			} else {
				[currentAnimation currentFrameImage].color = flashColor;
				flashTimer = 0.04;
			}
			
		}
	}
    if (rainIsHealingYou) {
        hp += 10 * aDelta;
    }
	if (essence != maxEssence) {
        float essenceAdder = (MAX(1, ((power + powerModifier + affinity + affinityModifier) / 2 * 0.05))) * aDelta + (essenceHelper * aDelta);
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
        float enduranceAdder = (MAX(1, ((stamina + staminaModifier) * 0.05))) * aDelta;
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
	
	[super render];
	[currentAnimation renderCenteredAtPoint:renderPoint];
    if (maxEssence > 0) {
        [essenceMeterImage renderCenteredAtPoint:essenceMeterImage.renderPoint];
        [essenceMeter renderAtPoint:essenceMeter.renderPoint scale:Scale2fMake(MAX(0, (64 * (essence / maxEssence))), 1) rotation:0];
    }
    [enduranceMeterImage renderCenteredAtPoint:enduranceMeterImage.renderPoint];
    [enduranceMeter renderAtPoint:enduranceMeter.renderPoint scale:Scale2fMake(MAX(0, (64 * (endurance / maxEndurance))), 1) rotation:0];
    [hpMeterImage renderCenteredAtPoint:hpMeterImage.renderPoint];
    [hpMeter renderAtPoint:hpMeter.renderPoint scale:Scale2fMake(3, 22 * (hp / maxHP)) rotation:0];

}

- (void)initBattleAttributes {
	
	Character *character;
	
	switch (whichCharacter) {
		case kRoderick:
			character = [sharedGameController.characters objectForKey:@"Roderick"];
			break;
		case kValkyrie:
			character = [sharedGameController.characters objectForKey:@"Valkyrie"];
			break;
		case kWizard:
			character = [sharedGameController.characters objectForKey:@"Wizard"];
			break;
		case kRanger:
			character = [sharedGameController.characters objectForKey:@"Ranger"];
			break;
		case kPriest:
			character = [sharedGameController.characters objectForKey:@"Priest"];
			break;
		case kDwarf:
			character = [sharedGameController.characters objectForKey:@"Dwarf"];
			break;
		default:
			break;
	}
	
	level = character.level;
	hp = character.hp;
	maxHP = character.maxHP;
	essence = character.maxEssence;
	maxEssence = character.maxEssence;
    endurance = character.maxEndurance;
    maxEndurance = character.maxEndurance;
	strength = character.strength;
	agility = character.agility;
	stamina = character.stamina;
	dexterity = character.dexterity;
	power = character.power;
	luck = character.luck;
    affinity = character.affinity;
	isAlive = character.isAlive;
    skyAffinity = character.skyAffinity;
    waterAffinity = character.waterAffinity;
    rageAffinity = character.rageAffinity;
    lifeAffinity = character.lifeAffinity;
    fireAffinity = character.fireAffinity;
    stoneAffinity = character.stoneAffinity;
    woodAffinity = character.woodAffinity;
    poisonAffinity = character.poisonAffinity;
    deathAffinity = character.deathAffinity;
    divineAffinity = character.divineAffinity;
    numberOfAttacks = 1;
    
    //For testing
    if ([sharedGameController.currentScene isMemberOfClass:[Alfheim class]]) {
        autoRaise = YES;
    }
    NSLog(@"Initialization of battle all good until rune stones.");
    for (Image *image in character.weaponRuneStones) {
        if (image.textureOffset.x == [sharedGameController.teorPSS imageForKey:@"IsaRuneStone.png"].textureOffset.x && image.textureOffset.y == [sharedGameController.teorPSS imageForKey:@"IsaRuneStone.png"].textureOffset.y) {
            waterAttackEquipped = YES;
        }
        if (image.textureOffset.x == [sharedGameController.teorPSS imageForKey:@"AnsuzRuneStone.png"].textureOffset.x && image.textureOffset.y == [sharedGameController.teorPSS imageForKey:@"AnsuzRuneStone.png"].textureOffset.y) {
            for (AbstractBattleCharacter *character in sharedGameController.currentScene.activeEntities) {
                if ([character isKindOfClass:[AbstractBattleCharacter class]]) {
                    character.essenceHelper++;
                }
            }
        }
        if (image.textureOffset.x == [sharedGameController.teorPSS imageForKey:@"OthalaRuneStone.png"].textureOffset.x && image.textureOffset.y == [sharedGameController.teorPSS imageForKey:@"OthalaRuneStone.png"].textureOffset.y) {
            //Implement elemental powers increasing here.
        }
        if (image.textureOffset.x == [sharedGameController.teorPSS imageForKey:@"GromanthRuneStone.png"].textureOffset.x && image.textureOffset.y == [sharedGameController.teorPSS imageForKey:@"GromanthRuneStone.png"].textureOffset.y) {
            drauraAttack = YES;
        }
        if (image.textureOffset.x == [sharedGameController.teorPSS imageForKey:@"NordrinRuneStone.png"].textureOffset.x && image.textureOffset.y == [sharedGameController.teorPSS imageForKey:@"NordrinRuneStone.png"].textureOffset.y) {
            numberOfAttacks++;
        }
        if (image.textureOffset.x == [sharedGameController.teorPSS imageForKey:@"SudrinRuneStone.png"].textureOffset.x && image.textureOffset.y == [sharedGameController.teorPSS imageForKey:@"SudrinRuneStone.png"].textureOffset.y) {
            attacksRefillItemTimers = YES;
        }
        if (image.textureOffset.x == [sharedGameController.teorPSS imageForKey:@"AustrinRuneStone.png"].textureOffset.x && image.textureOffset.y == [sharedGameController.teorPSS imageForKey:@"AustrinRuneStone.png"].textureOffset.y) {
            essenceDrain = YES;
        }
        if (image.textureOffset.x == [sharedGameController.teorPSS imageForKey:@"VestrinRuneStone.png"].textureOffset.x && image.textureOffset.y == [sharedGameController.teorPSS imageForKey:@"VestrinRuneStone.png"].textureOffset.y) {
            skyAttackEquipped = YES;
        }
        if (image.textureOffset.x == [sharedGameController.teorPSS imageForKey:@"HagalazRuneStone.png"].textureOffset.x && image.textureOffset.y == [sharedGameController.teorPSS imageForKey:@"HagalazRuneStone.png"].textureOffset.y) {
            waterAttackEquipped = YES;
        }
        if (image.textureOffset.x == [sharedGameController.teorPSS imageForKey:@"JeraRuneStone.png"].textureOffset.x && image.textureOffset.y == [sharedGameController.teorPSS imageForKey:@"JeraRuneStone.png"].textureOffset.y) {
            mayCounterAttack = YES;
        }
        if (image.textureOffset.x == [sharedGameController.teorPSS imageForKey:@"NauthizRuneStone.png"].textureOffset.x && image.textureOffset.y == [sharedGameController.teorPSS imageForKey:@"NauthizRuneStone.png"].textureOffset.y) {
            lifeAttackEquipped = YES;
        }
        if (image.textureOffset.x == [sharedGameController.teorPSS imageForKey:@"BerkanoRuneStone.png"].textureOffset.x && image.textureOffset.y == [sharedGameController.teorPSS imageForKey:@"BerkanoRuneStone.png"].textureOffset.y) {
            deathAttackEquipped = YES;
        }
        if (image.textureOffset.x == [sharedGameController.teorPSS imageForKey:@"PrimazRuneStone.png"].textureOffset.x && image.textureOffset.y == [sharedGameController.teorPSS imageForKey:@"PrimazRuneStone.png"].textureOffset.y) {
            attacksAddToRageMeter = YES;
        }
        if (image.textureOffset.x == [sharedGameController.teorPSS imageForKey:@"AkathRuneStone.png"].textureOffset.x && image.textureOffset.y == [sharedGameController.teorPSS imageForKey:@"AkathRuneStone.png"].textureOffset.y) {
            attacksAddToStatusTimers = YES;
        }
        if (image.textureOffset.x == [sharedGameController.teorPSS imageForKey:@"HolgethRuneStone.png"].textureOffset.x && image.textureOffset.y == [sharedGameController.teorPSS imageForKey:@"HolgethRuneStone.png"].textureOffset.y) {
            rageAttackEquipped = YES;
        }
        if (image.textureOffset.x == [sharedGameController.teorPSS imageForKey:@"RaidhoRuneStone.png"].textureOffset.x && image.textureOffset.y == [sharedGameController.teorPSS imageForKey:@"RaidhoRuneStone.png"].textureOffset.y) {
            luck += 5;
        }
        if (image.textureOffset.x == [sharedGameController.teorPSS imageForKey:@"MannazRuneStone.png"].textureOffset.x && image.textureOffset.y == [sharedGameController.teorPSS imageForKey:@"MannazRuneStone.png"].textureOffset.y) {
            //implement elemental stuff here.
        }
        if (image.textureOffset.x == [sharedGameController.teorPSS imageForKey:@"TiwazRuneStone.png"].textureOffset.x && image.textureOffset.y == [sharedGameController.teorPSS imageForKey:@"TiwazRuneStone.png"].textureOffset.y) {
            enduranceAttack = YES;
        }
        if (image.textureOffset.x == [sharedGameController.teorPSS imageForKey:@"IngwazRuneStone.png"].textureOffset.x && image.textureOffset.y == [sharedGameController.teorPSS imageForKey:@"IngwazRuneStone.png"].textureOffset.y) {
            stoneAttackEquipped = YES;
        }
        if (image.textureOffset.x == [sharedGameController.teorPSS imageForKey:@"FyrazRuneStone.png"].textureOffset.x && image.textureOffset.y == [sharedGameController.teorPSS imageForKey:@"FyrazRuneStone.png"].textureOffset.y) {
            numberOfAttacks++;
        }
        if (image.textureOffset.x == [sharedGameController.teorPSS imageForKey:@"DaleythRuneStone.png"].textureOffset.x && image.textureOffset.y == [sharedGameController.teorPSS imageForKey:@"DaleythRuneStone.png"].textureOffset.y) {
            attackAttacksAllEnemies = YES;
        }
        if (image.textureOffset.x == [sharedGameController.teorPSS imageForKey:@"EkwazRuneStone.png"].textureOffset.x && image.textureOffset.y == [sharedGameController.teorPSS imageForKey:@"EkwazRuneStone.png"].textureOffset.y) {
            fatigueAttack = YES;
        }
        if (image.textureOffset.x == [sharedGameController.teorPSS imageForKey:@"FehuRuneStone.png"].textureOffset.x && image.textureOffset.y == [sharedGameController.teorPSS imageForKey:@"FehuRuneStone.png"].textureOffset.y) {
            luck += 3;
        }
        if (image.textureOffset.x == [sharedGameController.teorPSS imageForKey:@"UruzRuneStone.png"].textureOffset.x && image.textureOffset.y == [sharedGameController.teorPSS imageForKey:@"UruzRuneStone.png"].textureOffset.y) {
            for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
                if ([enemy isKindOfClass:[AbstractBattleEnemy class]]) {
                    enemy.enhanceBleederDamage = YES;
                }
            }
        }
        if (image.textureOffset.x == [sharedGameController.teorPSS imageForKey:@"ThurisazRuneStone.png"].textureOffset.x && image.textureOffset.y == [sharedGameController.teorPSS imageForKey:@"ThurisazRuneStone.png"].textureOffset.y) {
            woodAttackEquipped = YES;
        }
        if (image.textureOffset.x == [sharedGameController.teorPSS imageForKey:@"AlgizRuneStone.png"].textureOffset.x && image.textureOffset.y == [sharedGameController.teorPSS imageForKey:@"AlgizRuneStone.png"].textureOffset.y) {
            damageEssence = YES;
        }
        if (image.textureOffset.x == [sharedGameController.teorPSS imageForKey:@"LaguzRuneStone.png"].textureOffset.x && image.textureOffset.y == [sharedGameController.teorPSS imageForKey:@"LaguzRuneStone.png"].textureOffset.y) {
            damageEndurance = YES;
        }
        if (image.textureOffset.x == [sharedGameController.teorPSS imageForKey:@"HoppatRuneStone.png"].textureOffset.x && image.textureOffset.y == [sharedGameController.teorPSS imageForKey:@"HoppatRuneStone.png"].textureOffset.y) {
            slothAttack = YES;
        }
        if (image.textureOffset.x == [sharedGameController.teorPSS imageForKey:@"SwopazRuneStone.png"].textureOffset.x && image.textureOffset.y == [sharedGameController.teorPSS imageForKey:@"SwopazRuneStone.png"].textureOffset.y) {
            numberOfAttacks++;
        }
        if (image.textureOffset.x == [sharedGameController.teorPSS imageForKey:@"GeboRuneStone.png"].textureOffset.x && image.textureOffset.y == [sharedGameController.teorPSS imageForKey:@"GeboRuneStone.png"].textureOffset.y) {
            //Implement after item timers.
        }
        if (image.textureOffset.x == [sharedGameController.teorPSS imageForKey:@"EhwazRuneStone.png"].textureOffset.x && image.textureOffset.y == [sharedGameController.teorPSS imageForKey:@"EhwazRuneStone.png"].textureOffset.y) {
            halfEnduranceExpenditure = YES;
        }
        if (image.textureOffset.x == [sharedGameController.teorPSS imageForKey:@"DagazRuneStone.png"].textureOffset.x && image.textureOffset.y == [sharedGameController.teorPSS imageForKey:@"DagazRuneStone.png"].textureOffset.y) {
            hexAttack = YES;
        }
        if (image.textureOffset.x == [sharedGameController.teorPSS imageForKey:@"IngrethRuneStone.png"].textureOffset.x && image.textureOffset.y == [sharedGameController.teorPSS imageForKey:@"IngrethRuneStone.png"].textureOffset.y) {
            divineAttackEquipped = YES;
        }
        if (image.textureOffset.x == [sharedGameController.teorPSS imageForKey:@"HelazRuneStone.png"].textureOffset.x && image.textureOffset.y == [sharedGameController.teorPSS imageForKey:@"HelazRuneStone.png"].textureOffset.y) {
            attackEnhancesFavor = YES;
        }
        if (image.textureOffset.x == [sharedGameController.teorPSS imageForKey:@"EpelthRuneStone.png"].textureOffset.x && image.textureOffset.y == [sharedGameController.teorPSS imageForKey:@"EpelthRuneStone.png"].textureOffset.y) {
            hpAttack = YES;
        }
        if (image.textureOffset.x == [sharedGameController.teorPSS imageForKey:@"SmeazRuneStone.png"].textureOffset.x && image.textureOffset.y == [sharedGameController.teorPSS imageForKey:@"SmeazRuneStone.png"].textureOffset.y) {
            drainAttackEquipped = YES;
        }
    }
    for (Image *image in character.armorRuneStones) {
        if (image.textureOffset.x == [sharedGameController.teorPSS imageForKey:@"IsaRuneStone.png"].textureOffset.x && image.textureOffset.y == [sharedGameController.teorPSS imageForKey:@"IsaRuneStone.png"].textureOffset.y) {
            waterProtectionEquipped = YES;
        }
        if (image.textureOffset.x == [sharedGameController.teorPSS imageForKey:@"AnsuzRuneStone.png"].textureOffset.x && image.textureOffset.y == [sharedGameController.teorPSS imageForKey:@"AnsuzRuneStone.png"].textureOffset.y) {
            power += 5;
        }
        if (image.textureOffset.x == [sharedGameController.teorPSS imageForKey:@"OthalaRuneStone.png"].textureOffset.x && image.textureOffset.y == [sharedGameController.teorPSS imageForKey:@"OthalaRuneStone.png"].textureOffset.y) {
            [self unlockOthalaEquippedPotential];
        }
        if (image.textureOffset.x == [sharedGameController.teorPSS imageForKey:@"GromanthRuneStone.png"].textureOffset.x && image.textureOffset.y == [sharedGameController.teorPSS imageForKey:@"GromanthRuneStone.png"].textureOffset.y) {
            drauraProtection = YES;
        }
        if (image.textureOffset.x == [sharedGameController.teorPSS imageForKey:@"NordrinRuneStone.png"].textureOffset.x && image.textureOffset.y == [sharedGameController.teorPSS imageForKey:@"NordrinRuneStone.png"].textureOffset.y) {
            agility += 5;
        }
        if (image.textureOffset.x == [sharedGameController.teorPSS imageForKey:@"SudrinRuneStone.png"].textureOffset.x && image.textureOffset.y == [sharedGameController.teorPSS imageForKey:@"SudrinRuneStone.png"].textureOffset.y) {
            isAuraed = YES;
            auraTimer = -1;
            isMotivated = YES;
            motivatedTimer = -1;
        }
        if (image.textureOffset.x == [sharedGameController.teorPSS imageForKey:@"AustrinRuneStone.png"].textureOffset.x && image.textureOffset.y == [sharedGameController.teorPSS imageForKey:@"AustrinRuneStone.png"].textureOffset.y) {
            affinity += 5;
        }
        if (image.textureOffset.x == [sharedGameController.teorPSS imageForKey:@"VestrinRuneStone.png"].textureOffset.x && image.textureOffset.y == [sharedGameController.teorPSS imageForKey:@"VestrinRuneStone.png"].textureOffset.y) {
            skyAffinity += 5;
        }
        if (image.textureOffset.x == [sharedGameController.teorPSS imageForKey:@"HagalazRuneStone.png"].textureOffset.x && image.textureOffset.y == [sharedGameController.teorPSS imageForKey:@"HagalazRuneStone.png"].textureOffset.y) {
            drauraProtection = fatigueProtection = slothProtection = hexProtection = disorientedProtection = YES;
        }
        if (image.textureOffset.x == [sharedGameController.teorPSS imageForKey:@"JeraRuneStone.png"].textureOffset.x && image.textureOffset.y == [sharedGameController.teorPSS imageForKey:@"JeraRuneStone.png"].textureOffset.y) {
            level += 1;
        }
        if (image.textureOffset.x == [sharedGameController.teorPSS imageForKey:@"NauthizRuneStone.png"].textureOffset.x && image.textureOffset.y == [sharedGameController.teorPSS imageForKey:@"NauthizRuneStone.png"].textureOffset.y) {
            doubleHealingGiven = YES;
        }
        if (image.textureOffset.x == [sharedGameController.teorPSS imageForKey:@"BerkanoRuneStone.png"].textureOffset.x && image.textureOffset.y == [sharedGameController.teorPSS imageForKey:@"BerkanoRuneStone.png"].textureOffset.y) {
            deathAffinity += 5;
        }
        if (image.textureOffset.x == [sharedGameController.teorPSS imageForKey:@"PrimazRuneStone.png"].textureOffset.x && image.textureOffset.y == [sharedGameController.teorPSS imageForKey:@"PrimazRuneStone.png"].textureOffset.y) {
            rageAffinity += 5;
        }
        if (image.textureOffset.x == [sharedGameController.teorPSS imageForKey:@"AkathRuneStone.png"].textureOffset.x && image.textureOffset.y == [sharedGameController.teorPSS imageForKey:@"AkathRuneStone.png"].textureOffset.y) {
            lifeAffinity += 5;
        }
        if (image.textureOffset.x == [sharedGameController.teorPSS imageForKey:@"HolgethRuneStone.png"].textureOffset.x && image.textureOffset.y == [sharedGameController.teorPSS imageForKey:@"HolgethRuneStone.png"].textureOffset.y) {
            protectedFromBleeders = YES;
        }
        if (image.textureOffset.x == [sharedGameController.teorPSS imageForKey:@"RaidhoRuneStone.png"].textureOffset.x && image.textureOffset.y == [sharedGameController.teorPSS imageForKey:@"RaidhoRuneStone.png"].textureOffset.y) {
            slothProtection = YES;
        }
        if (image.textureOffset.x == [sharedGameController.teorPSS imageForKey:@"MannazRuneStone.png"].textureOffset.x && image.textureOffset.y == [sharedGameController.teorPSS imageForKey:@"MannazRuneStone.png"].textureOffset.y) {
            fireAffinity += 5;
        }
        if (image.textureOffset.x == [sharedGameController.teorPSS imageForKey:@"TiwazRuneStone.png"].textureOffset.x && image.textureOffset.y == [sharedGameController.teorPSS imageForKey:@"TiwazRuneStone.png"].textureOffset.y) {
            isMotivated = YES;
            motivatedTimer = -1;
        }
        if (image.textureOffset.x == [sharedGameController.teorPSS imageForKey:@"IngwazRuneStone.png"].textureOffset.x && image.textureOffset.y == [sharedGameController.teorPSS imageForKey:@"IngwazRuneStone.png"].textureOffset.y) {
            stoneAffinity += 5;
        }
        if (image.textureOffset.x == [sharedGameController.teorPSS imageForKey:@"FyrazRuneStone.png"].textureOffset.x && image.textureOffset.y == [sharedGameController.teorPSS imageForKey:@"FyrazRuneStone.png"].textureOffset.y) {
            drauraProtection = fatigueProtection = disorientedProtection = hexProtection = slothProtection = YES;
        }
        if (image.textureOffset.x == [sharedGameController.teorPSS imageForKey:@"DaleythRuneStone.png"].textureOffset.x && image.textureOffset.y == [sharedGameController.teorPSS imageForKey:@"DaleythRuneStone.png"].textureOffset.y) {
            power += 5;
            affinity += 5;
        }
        if (image.textureOffset.x == [sharedGameController.teorPSS imageForKey:@"EkwazRuneStone.png"].textureOffset.x && image.textureOffset.y == [sharedGameController.teorPSS imageForKey:@"EkwazRuneStone.png"].textureOffset.y) {
            stamina += 5;
        }
        if (image.textureOffset.x == [sharedGameController.teorPSS imageForKey:@"FehuRuneStone.png"].textureOffset.x && image.textureOffset.y == [sharedGameController.teorPSS imageForKey:@"FehuRuneStone.png"].textureOffset.y) {
            //Implement animal raising stats here.
        }
        if (image.textureOffset.x == [sharedGameController.teorPSS imageForKey:@"UruzRuneStone.png"].textureOffset.x && image.textureOffset.y == [sharedGameController.teorPSS imageForKey:@"UruzRuneStone.png"].textureOffset.y) {
            //implement bear raising stats here.
        }
        if (image.textureOffset.x == [sharedGameController.teorPSS imageForKey:@"ThurisazRuneStone.png"].textureOffset.x && image.textureOffset.y == [sharedGameController.teorPSS imageForKey:@"ThurisazRuneStone.png"].textureOffset.y) {
            woodAffinity += 5;
        }
        if (image.textureOffset.x == [sharedGameController.teorPSS imageForKey:@"AlgizRuneStone.png"].textureOffset.x && image.textureOffset.y == [sharedGameController.teorPSS imageForKey:@"AlgizRuneStone.png"].textureOffset.y) {
            //implement squirrel raising stats here.
        }
        if (image.textureOffset.x == [sharedGameController.teorPSS imageForKey:@"LaguzRuneStone.png"].textureOffset.x && image.textureOffset.y == [sharedGameController.teorPSS imageForKey:@"LaguzRuneStone.png"].textureOffset.y) {
            rainIsHealingYou = YES;
        }
        if (image.textureOffset.x == [sharedGameController.teorPSS imageForKey:@"HoppatRuneStone.png"].textureOffset.x && image.textureOffset.y == [sharedGameController.teorPSS imageForKey:@"HoppatRuneStone.png"].textureOffset.y) {
            //implement frog raising stats here.
        }
        if (image.textureOffset.x == [sharedGameController.teorPSS imageForKey:@"SwopazRuneStone.png"].textureOffset.x && image.textureOffset.y == [sharedGameController.teorPSS imageForKey:@"SwopazRuneStone.png"].textureOffset.y) {
            //Implement hawk raising stats here.
        }
        if (image.textureOffset.x == [sharedGameController.teorPSS imageForKey:@"GeboRuneStone.png"].textureOffset.x && image.textureOffset.y == [sharedGameController.teorPSS imageForKey:@"GeboRuneStone.png"].textureOffset.y) {
            waterAffinity += 1;
            skyAffinity += 1;
            rageAffinity += 1;
            lifeAffinity += 1;
            stoneAffinity += 1;
            fireAffinity += 1;
            woodAffinity += 1;
            poisonAffinity += 1;
            divineAffinity += 1;
            deathAffinity += 1;
        }
        if (image.textureOffset.x == [sharedGameController.teorPSS imageForKey:@"EhwazRuneStone.png"].textureOffset.x && image.textureOffset.y == [sharedGameController.teorPSS imageForKey:@"EhwazRuneStone.png"].textureOffset.y) {
            fatigueProtection = YES;
        }
        if (image.textureOffset.x == [sharedGameController.teorPSS imageForKey:@"DagazRuneStone.png"].textureOffset.x && image.textureOffset.y == [sharedGameController.teorPSS imageForKey:@"DagazRuneStone.png"].textureOffset.y) {
            hexProtection = YES;
        }
        if (image.textureOffset.x == [sharedGameController.teorPSS imageForKey:@"IngrethRuneStone.png"].textureOffset.x && image.textureOffset.y == [sharedGameController.teorPSS imageForKey:@"IngrethRuneStone.png"].textureOffset.y) {
            divineAffinity += 5;
        }
        if (image.textureOffset.x == [sharedGameController.teorPSS imageForKey:@"HelazRuneStone.png"].textureOffset.x && image.textureOffset.y == [sharedGameController.teorPSS imageForKey:@"HelazRuneStone.png"].textureOffset.y) {
            //Implement after god timers
        }
        if (image.textureOffset.x == [sharedGameController.teorPSS imageForKey:@"EpelthRuneStone.png"].textureOffset.x && image.textureOffset.y == [sharedGameController.teorPSS imageForKey:@"EpelthRuneStone.png"].textureOffset.y) {
            power += 5;
        }
        if (image.textureOffset.x == [sharedGameController.teorPSS imageForKey:@"SmeazRuneStone.png"].textureOffset.x && image.textureOffset.y == [sharedGameController.teorPSS imageForKey:@"SmeazRuneStone.png"].textureOffset.y) {
            autoRaise = YES;
        }
    }
    NSLog(@"It's not the runestones.");
    
}
	
- (void)battleLocationIs:(int)aLocation {
	
	switch (aLocation) {
		case 0:
			//rect = CGRectMake(20, 240, 60, 120);
			renderPoint = CGPointMake(45, 270);
            enduranceMeterImage.renderPoint = CGPointMake(45, 230);
            enduranceMeter.renderPoint = CGPointMake(12, 229);
            essenceMeterImage.renderPoint = CGPointMake(45, 222);
            essenceMeter.renderPoint = CGPointMake(12, 221);
            hpMeterImage.renderPoint = CGPointMake(10, 270);
            hpMeter.renderPoint = CGPointMake(9, 237);
			break;
		case 1:
			//rect = CGRectMake(20, 120, 60, 120);
			renderPoint = CGPointMake(45, 165);
            enduranceMeterImage.renderPoint = CGPointMake(45, 125);
            enduranceMeter.renderPoint = CGPointMake(12, 124);
            essenceMeterImage.renderPoint = CGPointMake(45, 117);
            essenceMeter.renderPoint = CGPointMake(12, 116);
            hpMeterImage.renderPoint = CGPointMake(10, 165);
            hpMeter.renderPoint = CGPointMake(9, 132);
			break;
		case 2:
			//rect = CGRectMake(20, 0, 60, 120);
			renderPoint = CGPointMake(45, 60);
            enduranceMeterImage.renderPoint = CGPointMake(45, 20);
            enduranceMeter.renderPoint = CGPointMake(12, 19);
            essenceMeterImage.renderPoint = CGPointMake(45, 12);
            essenceMeter.renderPoint = CGPointMake(12, 11);
            hpMeterImage.renderPoint = CGPointMake(10, 60);
            hpMeter.renderPoint = CGPointMake(9, 27);
			break;
		default:
			break;
	}
	
	battleLocation = aLocation;
}

- (void)relinquishPriority {
	currentTurn = NO;
	[currentAnimation currentFrameImage].color = Color4fMake(1, 1, 1, 1);
}

- (void)gainPriority {
    
    for (AbstractBattleCharacter *character in sharedGameController.currentScene.activeEntities) {
        [character relinquishPriority];
    }
    currentTurn = YES;
    [sharedInputManager setState:whichCharacter];
	
	
}

- (void)updateRuneLocationTo:(CGPoint)aLocation {
	[queuedRune setRenderPoint:aLocation];
}
	
- (void)queueRune:(int)aRune {
	RuneObject *rune = [[RuneObject alloc] initWithTypeOfRune:aRune];
	queuedRune = rune;
	queuedRuneNumber = aRune;
	[sharedGameController.currentScene addObjectToActiveObjects:rune];
	[rune release];
}

//Override for attacks.
- (void)youAttackedEnemy:(AbstractBattleEnemy *)aEnemy {
	//NSLog(@"Attack!");
}

//Override these for specific runes
- (void)runeWasPlacedOnEnemy:(AbstractBattleEnemy *)aEnemy {
	int runeObjectIndex;
	for (int runeIndex = 0; runeIndex < [sharedGameController.currentScene.activeObjects count]; runeIndex++) {
		if ([[sharedGameController.currentScene.activeObjects objectAtIndex:runeIndex] isMemberOfClass:[RuneObject class]]) {
			runeObjectIndex = runeIndex;
		}
	}
	[sharedGameController.currentScene.activeObjects removeObjectAtIndex:runeObjectIndex];
}

- (void)runeWasPlacedOnCharacter:(AbstractBattleCharacter *)aCharacter {
	int runeObjectIndex;
	for (int runeIndex = 0; runeIndex < [sharedGameController.currentScene.activeObjects count]; runeIndex++) {
		if ([[sharedGameController.currentScene.activeObjects objectAtIndex:runeIndex] isMemberOfClass:[RuneObject class]]) {
			runeObjectIndex = runeIndex;
		}
	}
	[sharedGameController.currentScene.activeObjects removeObjectAtIndex:runeObjectIndex];
}

- (void)runeAffectedAllCharacters {
	int runeObjectIndex;
	for (int runeIndex = 0; runeIndex < [sharedGameController.currentScene.activeObjects count]; runeIndex++) {
		if ([[sharedGameController.currentScene.activeObjects objectAtIndex:runeIndex] isMemberOfClass:[RuneObject class]]) {
			runeObjectIndex = runeIndex;
		}
	}
	[sharedGameController.currentScene.activeObjects removeObjectAtIndex:runeObjectIndex];
}

- (void)runeAffectedAllEnemies {
	int runeObjectIndex;
	for (int runeIndex = 0; runeIndex < [sharedGameController.currentScene.activeObjects count]; runeIndex++) {
		if ([[sharedGameController.currentScene.activeObjects objectAtIndex:runeIndex] isMemberOfClass:[RuneObject class]]) {
			runeObjectIndex = runeIndex;
		}
	}
	[sharedGameController.currentScene.activeObjects removeObjectAtIndex:runeObjectIndex];
}

- (void)resetBattleTimer {
	
	[super resetBattleTimer];
	currentTurn = NO;
}

- (void)youTookDamage:(int)aDamage {
	//renderDamage = YES;
	//damageRenderPoint = CGPointMake(renderPoint.x + 30, renderPoint.y - 20);
	//damage = aDamage;
    if (aDamage < 0) {
        aDamage = 0;
    }
    if (willTakeDoubleDamage) {
        aDamage *= 2;
        willTakeDoubleDamage = NO;
    }
    if (mayCounterAttack) {
        if (arc4random() % 100 > 80 - luck - luckModifier) {
            if (enduranceDoesNotDeplete == NO) {
                enduranceDoesNotDeplete = YES;
                [self youAttackedEnemy:[[OverMind sharedOverMind] anyEnemy]];
                enduranceDoesNotDeplete = NO;
            }
            else {
                [self youAttackedEnemy:[[OverMind sharedOverMind] anyEnemy]];
            }
        }
    }
    BattleStringAnimation *bsa = [[BattleStringAnimation alloc] initDamageString:[NSString stringWithFormat:@"%d", aDamage] from:renderPoint];
    [sharedGameController.currentScene addObjectToActiveObjects:bsa];
    [bsa release];
	[super youTookDamage:aDamage];
}

- (void)youWereHealed:(int)aHealing {
    
    if (receiveDoubleHealing) {
        aHealing *= 2;
    }
    if (doubleHealingGiven) {
        aHealing *= 2;
    }
    if (!cannotBeHealed) {
        //renderHealing = YES;
        int hpToGain = maxHP - hp;
        ////NSLog(@"Hp to gain is %d.", hpToGain);
        hpToGain = MIN(aHealing, hpToGain);
        hp += hpToGain;
        //healingRenderPoint = CGPointMake(renderPoint.x + 40, renderPoint.y - 20);
        HealingAnimation *ha = [[HealingAnimation alloc] initAtPosition:CGPointMake(renderPoint.x, renderPoint.y)];
        [sharedGameController.currentScene addObjectToActiveObjects:ha];
        [ha release];
        [super youWereHealed:hpToGain];
    } else {
        
        BattleStringAnimation *ineffective = [[BattleStringAnimation alloc] initIneffectiveStringFrom:renderPoint];
        [sharedGameController.currentScene addObjectToActiveObjects:ineffective];
        [ineffective release];
    }
	
}

- (void)youWereGivenEssence:(int)aEssence {
	
	int essenceToGain = maxEssence - essence;
	essenceToGain = MIN(aEssence, essenceToGain);
	essence += essenceToGain;
    BattleStringAnimation *essenceGained = [[BattleStringAnimation alloc] initEssenceString:[NSString stringWithFormat:@"%d", essenceToGain] from:renderPoint withColor:essenceColor];
    [sharedGameController.currentScene addObjectToActiveObjects:essenceGained];
    [essenceGained release];
	EssenceAnimation *ea = [[EssenceAnimation alloc] initWithEntity:self];
	[sharedGameController.currentScene addObjectToActiveObjects:ea];
	[ea release];
	[super youWereGivenEssence:aEssence];
}

- (void)youReceivedShield:(int)aElement {
	
	//Add elemental shield mechanics here.
	[super gainElementalProtection:aElement];
	ElementalShield *es = [[ElementalShield alloc] initFromCharacter:self withElement:aElement];
	[sharedGameController.currentScene addObjectToActiveObjects:es];
	[es release];
}

- (void)youReceivedWeaponElement:(int)aElement {
	
    [super gainElementalAttack:aElement];
	WeaponElement *we = [[WeaponElement alloc] initFromCharacter:self withElement:aElement];
	[sharedGameController.currentScene addObjectToActiveObjects:we];
	[we release];
}

- (void)youHaveDied {
    
    if (autoRaise) {
        [self youWereHealed:(int)((level + levelModifier) * 10)];
        return;
    }
    [[OverMind sharedOverMind] removeCharacter:self];
    currentAnimation.currentFrameImage.rotation = 270;
    currentAnimation.state = kAnimationState_Stopped;
    isAlive = NO;
    bleeders = 0;
}

- (void)youHaveBeenRevived {
    
    hp = 1;
    currentAnimation.currentFrameImage.rotation = 0;
    currentAnimation.currentFrameImage.color = Color4fOnes;
    isAlive = YES;
}

- (void)gainDoubleAttack:(int)aNumber {
    
    doubleAttack += aNumber;
}


@end

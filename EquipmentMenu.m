//
//  EquipmentMenu.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/7/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "EquipmentMenu.h"
#import "GameController.h"
#import "Image.h"
#import "FontManager.h"
#import "BitmapFont.h"
#import "Character.h"
#import "SpriteSheet.h"
#import "PackedSpriteSheet.h"


@implementation EquipmentMenu

- (void)dealloc {
	[abilitiesString release];
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
		availableRunes = [GameController sharedGameController].runeStones;
		for (int i = 0; i < 40; i++) {
			runeRects[i] = CGRectMake(15 + (i * 23) - (465 * (i / 20)), 260 - (30 * (i / 20)), 22, 22);
		}
		backgroundImage = [[Image alloc] initWithImageNamed:@"EquipmentMenuBackground.png" filter:GL_LINEAR];
		int imagePointIndex = 0;
		for (Image *image in availableRunes) {
			image.renderPoint = CGPointMake(runeRects[imagePointIndex].origin.x + 10, runeRects[imagePointIndex].origin.y + 10);
			imagePointIndex++;
		}
		currentCharacter = [[GameController sharedGameController].party objectAtIndex:0];
        [self getAbilitiesString];
		currentWeaponRunes = currentCharacter.weaponRuneStones;
		currentArmorRunes = currentCharacter.armorRuneStones;
		for (Image *image in currentWeaponRunes) {
			image.renderPoint = CGPointMake(200, 100);
		}
		for (Image *image in currentArmorRunes) {
			image.renderPoint = CGPointMake(200, 60);
		}
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {
}

- (void)render {
	
	[backgroundImage renderCenteredAtPoint:CGPointMake(240, 160)];
	[currentCharacter.characterImage renderCenteredAtPoint:CGPointMake(100, 160)];
	for (Image *image in availableRunes) {
		[image renderCenteredAtPoint:image.renderPoint];
		[[[FontManager sharedFontManager] getFontWithKey:@"menuFont"] renderStringAt:CGPointMake(image.renderPoint.x - 10, image.renderPoint.y - 10) text:[NSString stringWithFormat:@"%d", [availableRunes countForObject:image] - 1]];
	}
    [[[FontManager sharedFontManager] getFontWithKey:@"menuFont"] renderStringAt:CGPointMake(100, 100) text:[NSString stringWithFormat:@"%@",abilitiesString]];
	for (Image *image in currentWeaponRunes) {
		[image renderCenteredAtPoint:image.renderPoint];
	}
	for (Image *image in currentArmorRunes) {
		[image renderCenteredAtPoint:image.renderPoint];
	}
	if (currentSelectedRuneStone) {
		[csrsImage renderCenteredAtPoint:csrsImage.renderPoint];
	}
	[leftArrow renderCenteredAtPoint:CGPointMake(15, 15)];
	[rightArrow renderCenteredAtPoint:CGPointMake(465, 15)];
}
	 
- (void)fingerIsDownAt:(CGPoint)aTouchLocation {
	
	if (!currentSelectedRuneStone) {
		for (int i = 0; i < 40; i++) {
			if (CGRectContainsPoint(runeRects[i], aTouchLocation)) {
				for (Image *image in availableRunes) {
					if (CGRectContainsPoint(runeRects[i], image.renderPoint) && [availableRunes countForObject:image] > 1) {
						currentSelectedRuneStone = [image retain];
						csrsImage = [[image imageDuplicate] retain];
						csrsImage.renderPoint = originalPoint = image.renderPoint;
						[availableRunes removeObject:image];
						break;
					}
				}
			} 
		}
		for (Image *image in currentWeaponRunes) {
			if (CGRectContainsPoint(CGRectMake(image.renderPoint.x - 10, image.renderPoint.y - 10, 20, 20), aTouchLocation)) {
				currentSelectedRuneStone = [image retain];
				csrsImage = [[image imageDuplicate] retain];
				csrsImage.renderPoint = originalPoint = image.renderPoint;
				[currentWeaponRunes removeObject:image];
				break;
			}
		}
		for (Image *image in currentArmorRunes) {
			if (CGRectContainsPoint(CGRectMake(image.renderPoint.x - 10, image.renderPoint.y - 10, 20, 20), aTouchLocation)) {
				currentSelectedRuneStone = [image retain];
				csrsImage = [[image imageDuplicate] retain];
				csrsImage.renderPoint = originalPoint = image.renderPoint;
				[currentArmorRunes removeObject:image];
				break;
			}					
		}

	} else {
		csrsImage.renderPoint = aTouchLocation;
	}

}

- (void)youWereTappedAt:(CGPoint)aTapLocation {
	
	if (currentSelectedRuneStone && CGRectContainsPoint(CGRectMake(0, 130, 480, 190), aTapLocation)) {
		for (Image *image in availableRunes) {
			if (image.textureOffset.x == currentSelectedRuneStone.textureOffset.x && image.textureOffset.y == currentSelectedRuneStone.textureOffset.y) {
				[availableRunes addObject:image];
				[currentSelectedRuneStone release];
				currentSelectedRuneStone = nil;
				[csrsImage release];
				csrsImage = nil;
				return;
			}

		}
	currentSelectedRuneStone.renderPoint = CGPointMake(25 + ([availableRunes count] * 23) - (420 * ([availableRunes count] / 20)), 270 - (30 * ([availableRunes count] / 20)));
	[availableRunes addObject:currentSelectedRuneStone];
	[currentSelectedRuneStone release];
	currentSelectedRuneStone = nil;
	return;
	
		
		//currentSelectedRuneStone.renderPoint = originalPoint;
		//[availableRunes addObject:currentSelectedRuneStone];
		
		
	} else if (currentSelectedRuneStone && CGRectContainsPoint(CGRectMake(0, 100, 480, 29), aTapLocation)) {
		csrsImage.renderPoint = CGPointMake(200, 100); 
		if ([currentWeaponRunes count] > 0) {
			[self addRuneToAvailableRunes:[currentWeaponRunes objectAtIndex:0]];
			[currentWeaponRunes removeObjectAtIndex:0];
		}
		[currentWeaponRunes addObject:csrsImage];
		[currentSelectedRuneStone release];
		currentSelectedRuneStone = nil;
		[csrsImage release];
		csrsImage = nil;
	} else if (currentSelectedRuneStone && CGRectContainsPoint(CGRectMake(0, 40, 480, 99), aTapLocation)) {
		csrsImage.renderPoint = CGPointMake(200, 60);
		if ([currentArmorRunes count] > 0) {
			[self addRuneToAvailableRunes:[currentArmorRunes objectAtIndex:0]];
			[currentArmorRunes removeObjectAtIndex:0];
		}
		[currentArmorRunes addObject:csrsImage];
		[currentSelectedRuneStone release];
		currentSelectedRuneStone = nil;
		[csrsImage release];
		csrsImage = nil;
	}
	if (CGRectContainsPoint(CGRectMake(0, 0, 40, 40), aTapLocation)) {
		if ([[GameController sharedGameController].party indexOfObject:currentCharacter] != 0) {
			currentCharacter = [[GameController sharedGameController].party objectAtIndex:([[GameController sharedGameController].party indexOfObject:currentCharacter] - 1)];
		} else {
			currentCharacter = [[GameController sharedGameController].party lastObject];
		}
		currentWeaponRunes = currentCharacter.weaponRuneStones;
		currentArmorRunes = currentCharacter.armorRuneStones;
		for (Image *image in currentWeaponRunes) {
			image.renderPoint = CGPointMake(200, 100);
		}
		for (Image *image in currentArmorRunes) {
			image.renderPoint = CGPointMake(200, 60);
		}
		
	}
	if (CGRectContainsPoint(CGRectMake(440, 0, 40, 40), aTapLocation)) {
		if ([[GameController sharedGameController].party indexOfObject:currentCharacter] != [[GameController sharedGameController].party count] - 1) {
			currentCharacter = [[GameController sharedGameController].party objectAtIndex:([[GameController sharedGameController].party indexOfObject:currentCharacter] + 1)];
		} else {
			currentCharacter = [[GameController sharedGameController].party objectAtIndex:0];
		}
		currentWeaponRunes = currentCharacter.weaponRuneStones;
		currentArmorRunes = currentCharacter.armorRuneStones;
		for (Image *image in currentWeaponRunes) {
			image.renderPoint = CGPointMake(200, 100);
		}
		for (Image *image in currentArmorRunes) {
			image.renderPoint = CGPointMake(200, 60);
		}
	}
	

}

- (void)addRuneToAvailableRunes:(Image *)aRune {
	for (Image *image in availableRunes) {
		if (image.textureOffset.x == aRune.textureOffset.x && image.textureOffset.y == aRune.textureOffset.y) {
			[availableRunes addObject:image];
			return;
		}
	}
}

- (void)setCurrentCharacter:(int)aCharacter {
	currentCharacter = [[GameController sharedGameController].party objectAtIndex:aCharacter];
	currentWeaponRunes = currentCharacter.weaponRuneStones;
	currentArmorRunes = currentCharacter.armorRuneStones;
}

- (void)getAbilitiesString {
    
    abilitiesString = [NSMutableString stringWithString:@"This is a string\n"];
    [abilitiesString appendString:@"Heyooo"];
    [abilitiesString retain];
    //NSLog(@"%@",abilitiesString);
    //abilitiesString = [abilitiesString stringByAppendingString:@"And another line!"];
    /*for (Image *image in currentCharacter.weaponRuneStones) {
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
    }*/

}



@end

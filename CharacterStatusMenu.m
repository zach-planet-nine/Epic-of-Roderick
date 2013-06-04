//
//  CharacterStatusMenu.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/19/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "CharacterStatusMenu.h"
#import "GameController.h"
#import "Image.h"
#import "Character.h"
#import "BitmapFont.h"

@implementation CharacterStatusMenu

- (id)init
{
    self = [super init];
    if (self) {
        currentCharacter = [sharedGameController.party objectAtIndex:0];
    }
    
    return self;
}

- (void)updateWithDelta:(float)aDelta {
    
}

- (void)render {
	[backgroundImage renderCenteredAtPoint:CGPointMake(240, 160)];
	[currentCharacter.characterImage renderCenteredAtPoint:CGPointMake(140, 220)];
    [menuFont renderStringAt:CGPointMake(140, 180) text:[NSString stringWithFormat:@"%d/%d", currentCharacter.hp, currentCharacter.maxHP]];
    [menuFont renderStringAt:CGPointMake(140, 160) text:[NSString stringWithFormat:@"%d/%d", currentCharacter.endurance, currentCharacter.maxEndurance]];
    if (currentCharacter.essence > 0) {
        [menuFont renderStringAt:CGPointMake(60, 140) text:@"Essence:"];
        [menuFont renderStringAt:CGPointMake(140, 140) text:[NSString stringWithFormat:@"%d/%d", currentCharacter.essence, currentCharacter.maxEssence]];
    }
    [menuFont renderStringAt:CGPointMake(140, 120) text:[NSString stringWithFormat:@"%d", currentCharacter.strength]];
    [menuFont renderStringAt:CGPointMake(140, 100) text:[NSString stringWithFormat:@"%d", currentCharacter.agility]];
    [menuFont renderStringAt:CGPointMake(140, 80) text:[NSString stringWithFormat:@"%d", currentCharacter.dexterity]];
    [menuFont renderStringAt:CGPointMake(140, 60) text:[NSString stringWithFormat:@"%d", currentCharacter.stamina]];
    [menuFont renderStringAt:CGPointMake(140, 40) text:[NSString stringWithFormat:@"%d", currentCharacter.power]];
    [menuFont renderStringAt:CGPointMake(140, 20) text:[NSString stringWithFormat:@"%d", currentCharacter.affinity]];
    [menuFont renderStringAt:CGPointMake(60, 180) text:@"Health:"];
    [menuFont renderStringAt:CGPointMake(60, 160) text:@"Endurance:"];
    [menuFont renderStringAt:CGPointMake(60, 120) text:@"Strength:"];
    [menuFont renderStringAt:CGPointMake(60, 100) text:@"Agility:"];
    [menuFont renderStringAt:CGPointMake(60, 80) text:@"Dexterity:"];
    [menuFont renderStringAt:CGPointMake(60, 60) text:@"Stamina:"];
    [menuFont renderStringAt:CGPointMake(60, 40) text:@"Power:"];
    [menuFont renderStringAt:CGPointMake(60, 20) text:@"Affinity:"];
    [menuFont renderStringAt:CGPointMake(300, 260) text:@"Level:"];
    [menuFont renderStringAt:CGPointMake(300, 240) text:@"Experience:"];
    [menuFont renderStringAt:CGPointMake(300, 200) text:@"Death:"];
    [menuFont renderStringAt:CGPointMake(300, 180) text:@"Divine:"];
    [menuFont renderStringAt:CGPointMake(300, 160) text:@"Fire:"];
    [menuFont renderStringAt:CGPointMake(300, 140) text:@"Life:"];
    [menuFont renderStringAt:CGPointMake(300, 120) text:@"Poison:"];
    [menuFont renderStringAt:CGPointMake(300, 100) text:@"Rage:"];
    [menuFont renderStringAt:CGPointMake(300, 80) text:@"Sky:"];
    [menuFont renderStringAt:CGPointMake(300, 60) text:@"Stone:"];
    [menuFont renderStringAt:CGPointMake(300, 40) text:@"Water:"];
    [menuFont renderStringAt:CGPointMake(300, 20) text:@"Wood:"];
    [menuFont renderStringAt:CGPointMake(360, 260) text:[NSString stringWithFormat:@"%d", currentCharacter.level]];
    [menuFont renderStringAt:CGPointMake(360, 240) text:[NSString stringWithFormat:@"%d/%d", currentCharacter.experience, currentCharacter.toNextLevel]];
    [menuFont renderStringAt:CGPointMake(360, 200) text:[NSString stringWithFormat:@"%d", currentCharacter.deathAffinity]];
    [menuFont renderStringAt:CGPointMake(360, 180) text:[NSString stringWithFormat:@"%d", currentCharacter.divineAffinity]];
    [menuFont renderStringAt:CGPointMake(360, 160) text:[NSString stringWithFormat:@"%d", currentCharacter.fireAffinity]];
    [menuFont renderStringAt:CGPointMake(360, 140) text:[NSString stringWithFormat:@"%d", currentCharacter.lifeAffinity]];
    [menuFont renderStringAt:CGPointMake(360, 120) text:[NSString stringWithFormat:@"%d", currentCharacter.poisonAffinity]];
    [menuFont renderStringAt:CGPointMake(360, 100) text:[NSString stringWithFormat:@"%d", currentCharacter.rageAffinity]];
    [menuFont renderStringAt:CGPointMake(360, 80) text:[NSString stringWithFormat:@"%d", currentCharacter.skyAffinity]];
    [menuFont renderStringAt:CGPointMake(360, 60) text:[NSString stringWithFormat:@"%d", currentCharacter.stoneAffinity]];
    [menuFont renderStringAt:CGPointMake(360, 40) text:[NSString stringWithFormat:@"%d", currentCharacter.waterAffinity]];
    [menuFont renderStringAt:CGPointMake(360, 20) text:[NSString stringWithFormat:@"%d", currentCharacter.woodAffinity]];
	[leftArrow renderCenteredAtPoint:CGPointMake(15, 15)];
	[rightArrow renderCenteredAtPoint:CGPointMake(465, 15)];
}

- (void)youWereTappedAt:(CGPoint)aTapLocation {
	
	if (CGRectContainsPoint(CGRectMake(0, 0, 40, 40), aTapLocation)) {
		if ([[GameController sharedGameController].party indexOfObject:currentCharacter] != 0) {
			currentCharacter = [[GameController sharedGameController].party objectAtIndex:([[GameController sharedGameController].party indexOfObject:currentCharacter] - 1)];
		} else {
			currentCharacter = [[GameController sharedGameController].party lastObject];
		}
		
	}
	if (CGRectContainsPoint(CGRectMake(440, 0, 40, 40), aTapLocation)) {
		if ([[GameController sharedGameController].party indexOfObject:currentCharacter] != [[GameController sharedGameController].party count] - 1) {
			currentCharacter = [[GameController sharedGameController].party objectAtIndex:([[GameController sharedGameController].party indexOfObject:currentCharacter] + 1)];
		} else {
			currentCharacter = [[GameController sharedGameController].party objectAtIndex:0];
		}
		
	}
}

- (void)setCurrentCharacter:(int)aCharacter {
	
	currentCharacter = [[GameController sharedGameController].party objectAtIndex:aCharacter];
}


@end

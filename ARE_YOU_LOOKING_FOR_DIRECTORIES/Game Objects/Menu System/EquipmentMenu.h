//
//  EquipmentMenu.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/7/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractSubMenu.h"

@class Character;
@class Image;

@interface EquipmentMenu : AbstractSubMenu {

	Character *currentCharacter;
	NSMutableArray *currentWeaponRunes;
	NSMutableArray *currentArmorRunes;
	NSCountedSet *availableRunes;
	CGRect runeRects[40];
	Image *currentSelectedRuneStone;
	Image *csrsImage;
	CGPoint originalPoint;
    NSMutableString *abilitiesString;
}

- (void)addRuneToAvailableRunes:(Image *)aRune;

- (void)setCurrentCharacter:(int)aCharacter;

- (void)getAbilitiesString;


@end

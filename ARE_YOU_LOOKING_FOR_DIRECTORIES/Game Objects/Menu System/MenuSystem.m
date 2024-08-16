//
//  MenuSystem.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/3/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "MenuSystem.h"
#import "FontManager.h"
#import "InputManager.h"
#import "Character.h"
#import "Image.h"
#import "Animation.h"
#import "AbstractSubMenu.h"
#import "MainStatusMenu.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "BitmapFont.h"
#import "CharacterStatusMenu.h"
#import "ItemsMenu.h"
#import "PartyMenu.h"
#import "SystemMenu.h"
#import "SettingsMenu.h"
#import "RunesMenu.h"
#import "SkillsMenu.h"
#import "EquipmentMenu.h"
#import "BattleExampleEnemyForMenus.h"


@implementation MenuSystem

@synthesize characters;
@synthesize exampleEnemy;

- (void)dealloc {
	
	if (exampleEnemy) {
		[exampleEnemy release];
	}
	if (menus) {
		[menus release];
	}
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
		sharedGameController = [GameController sharedGameController];
		characters = [[NSMutableArray alloc] initWithCapacity:[sharedGameController.party count]];
		for (Character *character in sharedGameController.party) {
			[characters addObject:character];
		}	
		////NSLog(@"characters count: %d", [characters count]);
		//Character *charac = [characters objectAtIndex:3];
		////NSLog(@"%d", charac.whichCharacter);
		menus = [[NSMutableArray alloc] initWithCapacity:8];
		MainStatusMenu *msm = [[MainStatusMenu alloc] init];
		[menus addObject:msm];
		msm.currentMenu = self;
		[msm release];
		ItemsMenu *im = [[ItemsMenu alloc] init];
		[menus addObject:im];
		im.currentMenu = self;
		[im release];
		PartyMenu *pm = [[PartyMenu alloc] init];
		[menus addObject:pm];
		pm.currentMenu = self;
		[pm release];
		SystemMenu *sm = [[SystemMenu alloc] init];
		[menus addObject:sm];
		sm.currentMenu = self;
		[sm release];
		SettingsMenu *setm = [[SettingsMenu alloc] init];
		[menus addObject:setm];
		setm.currentMenu = self;
		[setm release];
		RunesMenu *rm = [[RunesMenu alloc] init];
		[menus addObject:rm];
		rm.currentMenu = self;
		[rm release];
		SkillsMenu *skm = [[SkillsMenu alloc] init];
		[menus addObject:skm];
		skm.currentMenu = self;
		[skm release];
		EquipmentMenu *em = [[EquipmentMenu alloc] init];
		[menus addObject:em];
		em.currentMenu = self;
		[em release];
        CharacterStatusMenu *csm = [[CharacterStatusMenu alloc] init];
        [menus addObject:csm];
        csm.currentMenu = self;
        [csm release];
		if ([menus objectAtIndex:2]) {
			//NSLog(@"There is a party menu.");
		}
		currentMenu = 0;
		mainColor = itemsColor = partyColor = systemColor = settingsColor = Color4fMake(1, 1, 1, 1);
		menuFont = [[FontManager sharedFontManager] getFontWithKey:@"menuFont"];
		exampleEnemy = [[BattleExampleEnemyForMenus alloc] init];
		////NSLog(@"String width is: %d.", [menuFont getWidthForString:@"This is the width for this string."]);
		active = YES;
		
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	if (active) {
		[[menus objectAtIndex:currentMenu] updateWithDelta:aDelta];
	}
}

- (void)render {
	if (active) {
		[[menus objectAtIndex:currentMenu] render];
		[menuFont renderStringAt:CGPointMake(15, 295) withText:@"Main" withColor:mainColor];
		[menuFont renderStringAt:CGPointMake(107, 295) withText:@"Tutorials" withColor:itemsColor];
		[menuFont renderStringAt:CGPointMake(199, 295) withText:@"Party" withColor:partyColor];
		[menuFont renderStringAt:CGPointMake(291, 295) withText:@"System" withColor:systemColor];
		[menuFont renderStringAt:CGPointMake(383, 295) withText:@"Settings" withColor:settingsColor];
	}
}

- (void)youWereTappedAt:(CGPoint)aTouchLocation {
	//NSLog(@"Tap received at: (%f, %f).", aTouchLocation.x, aTouchLocation.y);
	if (CGRectContainsPoint(CGRectMake(15, 290, 91, 30), aTouchLocation)) {
		mainColor = Color4fMake(1, 1, 0, 1);
		itemsColor = partyColor = systemColor = settingsColor = Color4fMake(1, 1, 1, 1);
		[sharedGameController.currentScene removeDrawingImages];
		MainStatusMenu *msm = [menus objectAtIndex:0];
		msm.currentTopCharacter = 0;
		currentMenu = 0;
	} else if (CGRectContainsPoint(CGRectMake(107, 290, 91, 30), aTouchLocation)) {
		itemsColor = Color4fMake(1, 1, 0, 1);
		mainColor = partyColor = systemColor = settingsColor = Color4fMake(1, 1, 1, 1);
		[sharedGameController.currentScene removeDrawingImages];
		currentMenu = 1;
	} else if (CGRectContainsPoint(CGRectMake(199, 290, 91, 30), aTouchLocation)) {
		partyColor = Color4fMake(1, 1, 0, 1);
		itemsColor = mainColor = systemColor = settingsColor = Color4fMake(1, 1, 1, 1);	
		[sharedGameController.currentScene removeDrawingImages];
		currentMenu = 2;
	} else if (CGRectContainsPoint(CGRectMake(291, 290, 91, 30), aTouchLocation)) {
		systemColor = Color4fMake(1, 1, 0, 1);
		itemsColor = partyColor = mainColor = settingsColor = Color4fMake(1, 1, 1, 1);
		[sharedGameController.currentScene removeDrawingImages];
		currentMenu = 3;
	} else if (CGRectContainsPoint(CGRectMake(383, 290, 91, 30), aTouchLocation)) {
		settingsColor = Color4fMake(1, 1, 0, 1);
		itemsColor = partyColor = systemColor = mainColor = Color4fMake(1, 1, 1, 1);
		[sharedGameController.currentScene removeDrawingImages];
		currentMenu = 4;
	} else {
		[[menus objectAtIndex:currentMenu] youWereTappedAt:aTouchLocation];
	}
}

- (void)fingerIsDownAt:(CGPoint)aTouchLocation {
	if (CGRectContainsPoint(CGRectMake(15, 290, 91, 30), aTouchLocation)) {
		mainColor = Color4fMake(1, 1, 0, 1);
		itemsColor = partyColor = systemColor = settingsColor = Color4fMake(1, 1, 1, 1);
	} else if (CGRectContainsPoint(CGRectMake(107, 290, 91, 30), aTouchLocation)) {
		itemsColor = Color4fMake(1, 1, 0, 1);
		mainColor = partyColor = systemColor = settingsColor = Color4fMake(1, 1, 1, 1);
	} else if (CGRectContainsPoint(CGRectMake(199, 290, 91, 30), aTouchLocation)) {
		partyColor = Color4fMake(1, 1, 0, 1);
		itemsColor = mainColor = systemColor = settingsColor = Color4fMake(1, 1, 1, 1);
	} else if (CGRectContainsPoint(CGRectMake(291, 290, 91, 30), aTouchLocation)) {
		systemColor = Color4fMake(1, 1, 0, 1);
		itemsColor = partyColor = mainColor = settingsColor = Color4fMake(1, 1, 1, 1);
	} else if (CGRectContainsPoint(CGRectMake(383, 290, 91, 30), aTouchLocation)) {
		settingsColor = Color4fMake(1, 1, 0, 1);
		itemsColor = partyColor = systemColor = mainColor = Color4fMake(1, 1, 1, 1);
	} else {
	[[menus objectAtIndex:currentMenu] fingerIsDownAt:aTouchLocation];
	}
}

- (void)openMenu {
	
	active = YES;
}

- (void)closeMenu {
	
	[sharedGameController.currentScene removeDrawingImages];
	active = NO;
}

- (void)updateCharacters {

	characters = sharedGameController.party;
}

- (void)loadRuneMenuForCharacter:(int)aCharacter {
	
	RunesMenu *rm = [menus objectAtIndex:5];
	[rm setCurrentCharacter:aCharacter];
	currentMenu = 5;
}

- (void)loadSkillsMenuForCharacter:(int)aCharacter {
	
	SkillsMenu *skm = [menus objectAtIndex:6];
	[skm setCurrentCharacter:aCharacter];
	currentMenu = 6;
}

- (void)loadEquipmentMenuForCharacter:(int)aCharacter {
	
	EquipmentMenu *em = [menus objectAtIndex:7];
	[em setCurrentCharacter:aCharacter];
	currentMenu = 7;
}

- (void)loadStatusMenuForCharacter:(int)aCharacter {
    
    CharacterStatusMenu *csm = [menus objectAtIndex:8];
    [csm setCurrentCharacter:aCharacter];
    currentMenu = 8;
}
	

@end

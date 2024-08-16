//
//  MenuSystem.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/3/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractGameObject.h"
#import "Global.h"

@class GameController;
@class AbstractSubMenu;
@class BitmapFont;
@class AbstractBattleEnemy;

@interface MenuSystem : AbstractGameObject {

	GameController *sharedGameController;
	NSMutableArray *menus;
	NSMutableArray *characters;
	int currentMenu;
	BitmapFont *menuFont;
	AbstractBattleEnemy *exampleEnemy;
	
	
	Color4f mainColor;
	Color4f itemsColor;
	Color4f partyColor;
	Color4f systemColor;
	Color4f settingsColor;
	
}

@property (nonatomic, retain) NSMutableArray *characters;
@property (nonatomic, retain) AbstractBattleEnemy *exampleEnemy;

- (void)openMenu;

- (void)closeMenu;

- (void)updateWithDelta:(float)aDelta;

- (void)render;

- (void)youWereTappedAt:(CGPoint)aTouchLocation;

- (void)fingerIsDownAt:(CGPoint)aTouchLocation;

- (void)updateCharacters;

- (void)loadRuneMenuForCharacter:(int)aCharacter;

- (void)loadEquipmentMenuForCharacter:(int)aCharacter;

- (void)loadSkillsMenuForCharacter:(int)aCharacter;

- (void)loadStatusMenuForCharacter:(int)aCharacter;


@end

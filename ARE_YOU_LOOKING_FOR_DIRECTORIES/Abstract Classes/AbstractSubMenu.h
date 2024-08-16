//
//  AbstractSubMenu.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/3/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractGameObject.h"

@class FontManager;
@class GameController;
@class InputManager;
@class Image;
@class PackedSpriteSheet;
@class BitmapFont;
@class MenuSystem;

@interface AbstractSubMenu : AbstractGameObject {

	
	FontManager *sharedFontManager;
	GameController *sharedGameController;
	InputManager *sharedInputManager;
	Image *backgroundImage;
	Image *leftArrow;
	Image *upArrow;
	Image *rightArrow;
	Image *downArrow;
	PackedSpriteSheet *menuSprites;
	BitmapFont *menuFont;
	MenuSystem *currentMenu;
	
}

@property (nonatomic, retain) MenuSystem *currentMenu;

- (void)updateWithDelta:(float)aDelta;

- (void)render;

- (void)youWereTappedAt:(CGPoint)aTapLocation;

- (void)fingerIsDownAt:(CGPoint)aTouchLocation;

@end

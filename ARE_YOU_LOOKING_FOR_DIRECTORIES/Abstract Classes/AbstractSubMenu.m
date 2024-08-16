//
//  AbstractSubMenu.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/3/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "AbstractSubMenu.h"
#import "GameController.h"
#import "FontManager.h"
#import "PackedSpriteSheet.h"
#import "Image.h"
#import "InputManager.h"
#import "MenuSystem.h"


@implementation AbstractSubMenu

@synthesize currentMenu;

- (void)dealloc {
	
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
		sharedGameController = [GameController sharedGameController];
		sharedFontManager = [FontManager sharedFontManager];
		sharedInputManager = [InputManager sharedInputManager];
		menuSprites = sharedGameController.teorPSS;
		backgroundImage = [menuSprites imageForKey:@"MainMenu480x320.png"];
		leftArrow = [menuSprites imageForKey:@"LeftArrow.png"];
		upArrow = [menuSprites imageForKey:@"UpArrow.png"];
		rightArrow = [menuSprites imageForKey:@"RightArrow.png"];
		downArrow = [menuSprites imageForKey:@"DownArrow.png"];
		menuFont = [sharedFontManager getFontWithKey:@"menuFont"];
	}
	return self;
}

- (void)youWereTappedAt:(CGPoint)aTapLocation {}

- (void)fingerIsDownAt:(CGPoint)aTouchLocation {}

@end

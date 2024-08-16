//
//  Textbox.h
//  TEORCutSceneTest
//
//  Created by Zach Babb on 5/22/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractGameObject.h"
#import "Global.h"

@class Image;
@class InputManager;
@class FontManager;
@class GameController;
@class BitmapFont;

@interface Textbox : AbstractGameObject {

	InputManager *sharedInputManager;
	FontManager *sharedFontManager;
	GameController *sharedGameController;
    BitmapFont *textboxFont;
	CGRect rect;
	Color4f color;
	BOOL animating;
	NSString *text;
	Image *windowPixel;
	float animationScale;
    float letters;
    int maxLetters;
}

@property (nonatomic, retain) NSString *text;
@property (nonatomic, assign) CGRect rect;

+ (void)textboxWithText:(NSString *)aText;

+ (void)centerTextboxWithText:(NSString *)aText;

+ (void)timedTextboxWithText:(NSString *)aText andDuration:(float)aDuration;

+ (void)updateTextboxText:(NSString *)aText;

+ (void)updateCenterTextboxText:(NSString *)aText;

- (void)resetLetters;

- (id)initWithRect:(CGRect)aRect color:(Color4f)aColor duration:(float)aDuration
		 animating:(BOOL)aAnimating text:(NSString *)aText;

- (void)updateWithDelta:(float)aDelta;

- (void)render;

- (void)resetAnimatingWithDuration:(float)aDuration;

- (void)doNotScroll;

@end

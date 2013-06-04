//
//  Textbox.m
//  TEORCutSceneTest
//
//  Created by Zach Babb on 5/22/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "Textbox.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "TouchManager.h"
#import "FontManager.h"
#import "InputManager.h"
#import "BitmapFont.h"
#import "Image.h"
#import "GameController.h"


@implementation Textbox

@synthesize text;
@synthesize rect;

- (void)dealloc {
	
	if (text) {
		[text release];
	}
	
	[super dealloc];
}

+ (void)textboxWithText:(NSString *)aText {
    
    Textbox *tb = [[Textbox alloc] initWithRect:CGRectMake(0, 240, 480, 80) color:Color4fMake(0.3, 0.3, 0.3, 0.9) duration:-1 animating:NO text:aText];
    [[GameController sharedGameController].currentScene addObjectToActiveObjects:tb];
    [tb release];
}

+ (void)centerTextboxWithText:(NSString *)aText {
    
    Textbox *tb = [[Textbox alloc] initWithRect:CGRectMake(100, 80, 280, 160) color:Color4fMake(0.3, 0.3, 0.3, 0.9) duration:-1 animating:NO text:aText];
    [tb doNotScroll];
    [[GameController sharedGameController].currentScene addObjectToActiveObjects:tb];
    [tb release];
}

+ (void)timedTextboxWithText:(NSString *)aText andDuration:(float)aDuration {
    
    Textbox *tb = [[Textbox alloc] initWithRect:CGRectMake(0, 240, 480, 80) color:Color4fMake(0.3, 0.3, 0.3, 0.9) duration:aDuration animating:YES text:aText];
    [[GameController sharedGameController].currentScene addObjectToActiveObjects:tb];
    [tb release];
}

+ (void)updateTextboxText:(NSString *)aText {
    
    for (Textbox *ago in [GameController sharedGameController].currentScene.activeObjects) {
        if ([ago isKindOfClass:[Textbox class]]) {
            if (ago.rect.origin.x != 0 && ago.active) {
                [[GameController sharedGameController].currentScene removeTextbox];
                NSLog(@"Should have a textbox.");
                [Textbox textboxWithText:aText];
                return;
            } else if (ago.active) {
                //[ago.text release];
                ago.text = aText;
                [ago resetLetters];
                return;
            }
        }
    }
    NSLog(@"Should have a textbox.");
    [Textbox textboxWithText:aText];
}

+ (void)updateCenterTextboxText:(NSString *)aText {
    
    for (Textbox *ago in [GameController sharedGameController].currentScene.activeObjects) {
        if ([ago isKindOfClass:[Textbox class]]) {
            if (ago.rect.origin.x == 0 && ago.active) {
                ago.active = NO;    
                NSLog(@"Should change the textbox.");
                [Textbox centerTextboxWithText:aText];
                return;
            } else if (ago.active) {
                //[ago.text release];
                ago.text = aText;
                [ago resetLetters];
                return;
            }
        }
    }
    NSLog(@"Should have a new textbox.");
    [Textbox centerTextboxWithText:aText];
}

- (id)init {
    
    if (self = [super init]) {
        sharedFontManager = [FontManager sharedFontManager];
		sharedInputManager = [InputManager sharedInputManager];
		sharedGameController = [GameController sharedGameController];
        textboxFont = [sharedFontManager getFontWithKey:@"textboxFont"];
        rect = CGRectMake(0, 0, 100, 100);
        color = Color4fMake(0.3, 0.3, 0.3, 0.9);
        duration = -1;
        animating = NO;
        text = nil;
        windowPixel = [[Image alloc] initWithImageNamed:@"WhitePixel.png" filter:GL_LINEAR];
		windowPixel.color = color;
        windowPixel.renderPoint = CGPointMake(240, 160);
        active = YES;
    }
    return self;
}

- (id)initWithRect:(CGRect)aRect color:(Color4f)aColor duration:(float)aDuration animating:(BOOL)aAnimating text:(NSString *)aText {
	
	if (self = [super init]) {
		
		sharedFontManager = [FontManager sharedFontManager];
		sharedInputManager = [InputManager sharedInputManager];
		sharedGameController = [GameController sharedGameController];
        textboxFont = [sharedFontManager getFontWithKey:@"textboxFont"];
		rect = aRect;
		color = aColor;
		duration = aDuration;
		animating = aAnimating;
        letters = 1;
        maxLetters = [aText length];
        while (letters < maxLetters) {
            if ([aText characterAtIndex:letters] == [@":" characterAtIndex:0])  {
                break;
            }
            letters++;
        }
		text = aText;
		active = YES;
		windowPixel = [[Image alloc] initWithImageNamed:@"WhitePixel.png" filter:GL_LINEAR];
		windowPixel.color = color;
		windowPixel.renderPoint = CGPointMake(((rect.size.width + rect.origin.x) + rect.origin.x) / 2, ((rect.size.height + rect.origin.y) + rect.origin.y) / 2);
		if (animating) {
			windowPixel.scale = Scale2fMake(rect.size.width, 1);
			animationScale = 1;
		}
		else {
			windowPixel.scale = Scale2fMake(rect.size.width, rect.size.height);
		}

		/*if (duration < 0 && sharedGameController.state == kCutScene) {
			[sharedTouchManager setState:kTextboxOnScreen];
		}
		if (duration > 0 && sharedGameController.state == kCutScene) {
			[sharedTouchManager setState:kNoTouchesAllowed];
		}
		if (sharedGameController.state == kWalkingAround) {
			[sharedTouchManager setState:kWalkingAround_TextboxOnScreen];
		}*/
		
	}
	
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	if (active) {
        if (letters < maxLetters) {
            letters += 0.75;
        }
		if (animating) {
			animationScale += aDelta * 280;
			windowPixel.scale = Scale2fMake(rect.size.width, animationScale);
		}
		if (animationScale > (float)(rect.size.height)) {
			windowPixel.scale = Scale2fMake(rect.size.width, rect.size.height);
			animating = NO;
		}
		if (animating == NO && duration > 0) {
			duration -= aDelta;
		}
		if (animating == NO && duration < 0 && duration != -1) {
            active = NO;
        }
	}
	
}

- (void)render {
	
	if (active) {
		if (animating == YES || duration > 0 || duration == -1) {
			[windowPixel renderCenteredAtPoint:windowPixel.renderPoint];
		}
		
		if (animating == NO && (duration > 0 || duration == -1)) {
			[textboxFont renderStringWrappedInRect:rect withText:[text substringToIndex:(int)letters]];
		}
	}
	
}

- (void)resetAnimatingWithDuration:(float)aDuration {
	
	duration = aDuration;
	animating = YES;
	active = YES;
	windowPixel.scale = Scale2fMake(rect.size.width, 1);
	animationScale = 1;
}

- (void)resetLetters {
    letters = 1;
    maxLetters = [text length];
    while (letters < maxLetters) {
        if ([text characterAtIndex:letters] == [@":" characterAtIndex:0])  {
            break;
        }
        letters++;
    }

}

- (void)doNotScroll {
    
    letters = maxLetters;
}

@end

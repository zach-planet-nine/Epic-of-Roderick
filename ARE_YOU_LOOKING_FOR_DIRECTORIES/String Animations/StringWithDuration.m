//
//  StringWithDuration.m
//  TEORCutSceneTest
//
//  Created by Zach Babb on 5/22/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "StringWithDuration.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "FontManager.h"
#import "BitmapFont.h"


@implementation StringWithDuration

- (void)dealloc {
	
	if (fontKey) {
		[fontKey release];
	}
	if (text) {
		[text release];
	}
	[super dealloc];
}

+ (void)narrativeString:(NSString *)aText withDuration:(float)aDuration {
    
    StringWithDuration *swd = [[StringWithDuration alloc] initNarrativeStringWithDuration:aDuration withText:aText];
    [[GameController sharedGameController].currentScene addObjectToActiveObjects:swd];
    [swd release];
}

- (id)initNarrativeStringWithDuration:(float)aDuration withText:(NSString *)aText {
    
    self = [super init];
    if (self) {
        
        fontKey = @"textboxFont";
        duration = aDuration;
        text = aText;
        renderPoint = CGPointMake(240, 200);
        sharedFontManager = [FontManager sharedFontManager];
        fadeAlpha = 0;
        fadingIn = YES;
        fadingOut = NO;
        active = YES;
    }
    return self;
}

- (id)initWithDuration:(float)aDuration atPoint:(CGPoint)aPoint withText:(NSString *)aText withFont:(NSString *)aFont {
	
	if (self = [super init]) {
		fontKey = aFont;
		duration = aDuration;
		text = aText;
		renderPoint = aPoint;
		sharedFontManager = [FontManager sharedFontManager];
        fadeAlpha = 1;
		active = YES;
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {
    
    if (active) {
        duration -= aDelta;
        if (duration < 0.0) {
            fadingOut = YES;
        }
        if (fadingIn) {
            fadeAlpha += aDelta;
            if (fadeAlpha > 1) {
                fadeAlpha = 1;
                fadingIn = NO;
            }
        }
        if (fadingOut) {
            fadeAlpha -= aDelta * 2;
            if (fadeAlpha < 0) {
                fadeAlpha = 0;
                fadingOut = NO;
                active = NO;
            }
        }
    }
}

- (void)render {
	
	if (active) {
		BitmapFont *font = [sharedFontManager getFontWithKey:fontKey];
		//[font renderStringAt:renderPoint text:text];
        //[font renderStringAt:renderPoint withText:text withColor:Color4fMake(1, 1, 1, fadeAlpha)];
        //[font renderStringWrappedInRect:CGRectMake(100, 100, 280, 120) withText:text withColor:Color4fMake(1, 1, 0, fadeAlpha)];
        [font renderNarrativeString:text inRect:CGRectMake(100, 100, 280, 120) withColor:Color4fMake(1, 1, 0, fadeAlpha)];
	}
}


@end

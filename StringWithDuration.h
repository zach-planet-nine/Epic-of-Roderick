//
//  StringWithDuration.h
//  TEORCutSceneTest
//
//  Created by Zach Babb on 5/22/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractGameObject.h"

@class FontManager;

@interface StringWithDuration : AbstractGameObject {

	FontManager *sharedFontManager;
	NSString *fontKey;
	CGPoint renderPoint;
	NSString *text;
    float fadeAlpha;
    BOOL fadingIn;
    BOOL fadingOut;
}

+ (void)narrativeString:(NSString *)aText withDuration:(float)aDuration;

- (id)initNarrativeStringWithDuration:(float)aDuration withText:(NSString *)aText;

- (id)initWithDuration:(float)aDuration atPoint:(CGPoint)aPoint withText:(NSString *)aText withFont:(NSString *)aFont;

- (void)updateWithDelta:(float)aDelta;

- (void)render;

@end

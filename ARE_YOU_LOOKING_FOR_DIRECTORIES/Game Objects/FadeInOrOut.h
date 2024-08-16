//
//  FadeInOrOut.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/10/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractGameObject.h"

@class Image;

@interface FadeInOrOut : AbstractGameObject {
    
    BOOL isFadingIn;
    BOOL isFadingOut;
    BOOL isDarkeningScreen;
    float fadeAlpha;
    float elapsedTime;
    float modifier;
    float fadeOutStop;
    float fadeInStop;
    Image *fadeInPixel;
}

+ (void)fadeInWithDuration:(float)aDuration;

+ (void)fadeOutWithDuration:(float)aDuration;

- (id)initFadeInWithDuration:(float)aDuration;

- (id)initFadeOutWithDuration:(float)aDuration;

- (id)initFadeOutToAlpha:(float)aAlpha withDuration:(float)aDuration;

- (void)updateWithDelta:(float)aDelta;

- (void)render;

@end

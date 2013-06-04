//
//  FadeInOrOut.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/10/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "FadeInOrOut.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "Image.h"

@implementation FadeInOrOut

- (void)dealloc {
    
    if (fadeInPixel) {
        [fadeInPixel release];
    }
    [super dealloc];
}

+ (void)fadeInWithDuration:(float)aDuration {
    
    FadeInOrOut *fadeIn = [[FadeInOrOut alloc] initFadeInWithDuration:aDuration];
    [[GameController sharedGameController].currentScene addObjectToActiveObjects:fadeIn];
    [fadeIn release];
}

+ (void)fadeOutWithDuration:(float)aDuration {
    
    FadeInOrOut *fadeOut = [[FadeInOrOut alloc] initFadeOutWithDuration:aDuration];
    [[GameController sharedGameController].currentScene addObjectToActiveObjects:fadeOut];
    [fadeOut release];
}

- (id)initFadeInWithDuration:(float)aDuration {
    
    self = [super init];
    if (self) {
        fadeInPixel = [[Image alloc] initWithImageNamed:@"FadeInPixel.png" filter:GL_NEAREST];
        fadeInPixel.scale = Scale2fMake(480, 320);
        fadeInPixel.color = Color4fMake(1, 1, 1, 1);
        fadeOutStop = 1;
        fadeInStop = 0;
        fadeAlpha = 1;
        duration = aDuration;
        modifier = 1;
        elapsedTime = 0;
        isFadingIn = YES;
        isFadingOut = NO;
        active = YES;
    }
    return self;
}

- (id)initFadeOutWithDuration:(float)aDuration {
    
    if (self = [super init]) {
        fadeInPixel = [[Image alloc] initWithImageNamed:@"FadeInPixel.png" filter:GL_NEAREST];
        fadeInPixel.scale = Scale2fMake(480, 320);
        fadeInPixel.color = Color4fMake(1, 1, 1, 0);
        fadeOutStop = 1;
        fadeInStop = 0;
        fadeAlpha = 0;
        duration = aDuration;
        modifier = 1;
        elapsedTime = 0;
        isFadingIn = NO;
        isFadingOut = YES;
        active = YES;

    }
    return self;
}

- (id)initFadeOutToAlpha:(float)aAlpha withDuration:(float)aDuration {
    
    self = [super init];
    if (self) {
        fadeInPixel = [[Image alloc] initWithImageNamed:@"FadeInPixel.png" filter:GL_NEAREST];
        fadeInPixel.scale = Scale2fMake(480, 320);
        fadeInPixel.color = Color4fMake(1, 1, 1, 0);
        fadeOutStop = aAlpha;
        fadeInStop = 0;
        fadeAlpha = 0;
        duration = aDuration;
        modifier = 1 / aAlpha;
        NSLog(@"%f",modifier);
        elapsedTime = 0;
        isFadingIn = NO;
        isFadingOut = YES;
        isDarkeningScreen = YES;
        active = YES;
    }
    return self;
}

- (void)updateWithDelta:(float)aDelta {
    
    if (isDarkeningScreen && fadeAlpha < fadeOutStop) {
        return;
    }
    if (active && isFadingOut) {
        elapsedTime += aDelta;
        fadeAlpha = elapsedTime / (duration * modifier);
    } else if (active && isFadingIn) {
        elapsedTime += aDelta;
        fadeAlpha = 1 - (elapsedTime / duration);
    }
    fadeInPixel.color = Color4fMake(1, 1, 1, fadeAlpha);
    if (fadeAlpha > fadeOutStop || fadeAlpha < fadeInStop) {
        active = NO;
        if (isDarkeningScreen) {
            active = YES;
        }
    }
}

- (void)render {
    
    if (active) {
        [fadeInPixel renderCenteredAtPoint:CGPointMake(240, 160)];
    }
}

@end

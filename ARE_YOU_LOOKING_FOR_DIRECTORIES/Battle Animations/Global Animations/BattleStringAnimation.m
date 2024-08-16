//
//  BattleStringAnimation.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/15/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "BattleStringAnimation.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "BitmapFont.h"
#import "FontManager.h"

@implementation BattleStringAnimation

- (void)dealloc {
    
    if (stringToRender) {
        [stringToRender release];
    }
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (id)initDamageString:(NSString *)aDamage from:(CGPoint)aStartPoint {
    
    if (self = [super init]) {
        
        battleFont = [[FontManager sharedFontManager] getFontWithKey:@"battleFont"];
        renderColor = Color4fMake(1, 1, 1, 1);
        renderPoint = aStartPoint;
        float angle = RANDOM_0_TO_1() * 3.14159265;
        velocity = Vector2fMultiply(Vector2fMake(cosf(angle), (sinf(angle)) * 2), 100);
        gravity = Vector2fMake(-(velocity.x), -250);
        stringToRender = aDamage;
        [stringToRender retain];
        active = YES;
        stage = 1;
        duration = 1;
        renderScale = Scale2fMake(0.7, 0.7);
    }
    return self;
}

- (id)initCriticalDamageString:(NSString *)aDamage from:(CGPoint)aStartPoint {
    
    if (self = [super init]) {
        
        battleFont = [[FontManager sharedFontManager] getFontWithKey:@"battleFont"];
        renderColor = Color4fMake(1, 1, 1, 1);
        renderPoint = aStartPoint;
        float angle = RANDOM_0_TO_1() * 3.14159265;
        velocity = Vector2fMultiply(Vector2fMake(cosf(angle), (sinf(angle)) * 2), 100);
        gravity = Vector2fMake(-(velocity.x), -250);
        stringToRender = aDamage;
        [stringToRender retain];
        active = YES;
        stage = 1;
        duration = 1;
        renderScale = Scale2fMake(1, 1);
    }
    return self;

}

- (id)initHealingString:(NSString *)aHealing from:(CGPoint)aStartPoint {
    
    if (self = [super init]) {
        battleFont = [[FontManager sharedFontManager] getFontWithKey:@"battleFont"];
        renderColor = Color4fMake(0, 1, 0, 1);
        renderPoint = aStartPoint;
        float angle = RANDOM_0_TO_1() * 3.14159265;
        velocity = Vector2fMultiply(Vector2fMake(cosf(angle), (sinf(angle)) * 2), 100);
        gravity = Vector2fMake(-(velocity.x), -250);
        stringToRender = aHealing;
        [stringToRender retain];
        active = YES;
        stage = 1;
        duration = 1;
        renderScale = Scale2fMake(0.7, 0.7);
    }
    return self;
}

- (id)initIneffectiveStringFrom:(CGPoint)aStartPoint {
    if (self = [super init]) {
        battleFont = [[FontManager sharedFontManager] getFontWithKey:@"battleFont"];
        renderColor = Color4fMake(0, 1, 0, 1);
        renderPoint = aStartPoint;
        float angle = RANDOM_0_TO_1() * 3.14159265;
        velocity = Vector2fMultiply(Vector2fMake(cosf(angle), (sinf(angle)) * 2), 100);
        gravity = Vector2fMake(-(velocity.x), -250);
        stringToRender = @"ineffective";
        [stringToRender retain];
        active = YES;
        stage = 1;
        duration = 1;
        renderScale = Scale2fMake(0.7, 0.7);
    }

    return self;
}

- (id)initStatusString:(NSString *)aStatus from:(CGPoint)aStartPoint {
    
    if (self = [super init]) {
        battleFont = [[FontManager sharedFontManager] getFontWithKey:@"battleFont"];
        renderColor = Color4fMake(1, 0, 0, 1);
        renderPoint = aStartPoint;
        float angle = RANDOM_0_TO_1() * 3.14159265;
        velocity = Vector2fMultiply(Vector2fMake(cosf(angle), (sinf(angle)) * 2), 100);
        gravity = Vector2fMake(-(velocity.x), -250);
        stringToRender = aStatus;
        [stringToRender retain];
        active = YES;
        stage = 1;
        duration = 1;
        renderScale = Scale2fMake(0.7, 0.7);
    }

    return self; 
}

- (id)initEssenceString:(NSString *)aEssence from:(CGPoint)aStartPoint withColor:(Color4f)aColor {
    
    if (self = [super init]) {
        battleFont = [[FontManager sharedFontManager] getFontWithKey:@"battleFont"];
        renderColor = aColor;
        renderPoint = aStartPoint;
        float angle = RANDOM_0_TO_1() * 3.14159265;
        velocity = Vector2fMultiply(Vector2fMake(cosf(angle), (sinf(angle)) * 2), 100);
        gravity = Vector2fMake(-(velocity.x), -250);
        stringToRender = aEssence;
        [stringToRender retain];
        active = YES;
        stage = 1;
        duration = 1;
        renderScale = Scale2fMake(0.7, 0.7);
    }
    return self;
}

+ (void)makeIneffectiveStringAt:(CGPoint)aPoint {
    
    BattleStringAnimation *bsa = [[BattleStringAnimation alloc] initIneffectiveStringFrom:aPoint];
    if (bsa) {
        //NSLog(@"Should have string");
    }
    [[GameController sharedGameController].currentScene addObjectToActiveObjects:bsa];
    [bsa release];
}

+ (void)makeStatusString:(NSString *)aString at:(CGPoint)aPoint {
    
    BattleStringAnimation *bsa = [[BattleStringAnimation alloc] initStatusString:aString from:aPoint];
    [[GameController sharedGameController].currentScene addObjectToActiveObjects:bsa];
    [bsa release];
}

- (void)updateWithDelta:(float)aDelta {
    
    if (active) {
        duration -= aDelta;
        if (duration < 0 && stage == 1) {
            stage = 2;
            duration = 0.4;
            return;
        } else if (duration < 0) {
            active = NO;
            return;
        }
        if (stage != 2) {
            Vector2f gravityWithDelta = Vector2fMultiply(gravity, aDelta);
            velocity = Vector2fAdd(velocity, gravityWithDelta);
            Vector2f velocityWithDelta = Vector2fMultiply(velocity, aDelta);
            renderPoint = CGPointMake(renderPoint.x + velocityWithDelta.x, renderPoint.y + velocityWithDelta.y);
            if (renderPoint.x < 5) {
                renderPoint = CGPointMake(5, renderPoint.y);
            }
            if (renderPoint.y > 310) {
                renderPoint = CGPointMake(renderPoint.x, 310);
            }
        }
    }
}

- (void)render {
    
    if (active && stage == 1) {
        [battleFont renderStringAt:renderPoint withText:stringToRender withColor:renderColor withScale:renderScale];
        //[battleFont renderStringAt:renderPoint text:@"Hello World."];
    }
}

@end

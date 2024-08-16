//
//  BattleStringAnimation.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/15/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"
#import "Global.h"

@class BitmapFont;

@interface BattleStringAnimation : AbstractBattleAnimation {
    
    NSString *stringToRender;
    BitmapFont *battleFont;
    CGPoint renderPoint;
    Color4f renderColor;
    Scale2f renderScale;
    Vector2f velocity;
    Vector2f gravity;
}

- (id)initDamageString:(NSString *)aDamage from:(CGPoint)aStartPoint;

- (id)initCriticalDamageString:(NSString *)aDamage from:(CGPoint)aStartPoint;

- (id)initHealingString:(NSString *)aHealing from:(CGPoint)aStartPoint;

- (id)initIneffectiveStringFrom:(CGPoint)aStartPoint;

- (id)initStatusString:(NSString *)aStatus from:(CGPoint)aStartPoint;

- (id)initEssenceString:(NSString *)aEssence from:(CGPoint)aStartPoint withColor:(Color4f)aColor;

+ (void)makeIneffectiveStringAt:(CGPoint)aPoint;

+ (void)makeStatusString:(NSString *)aString at:(CGPoint)aPoint;

@end

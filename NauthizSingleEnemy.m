//
//  NauthizSingleEnemy.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/25/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "NauthizSingleEnemy.h"
#import "GameController.h"
#import "AbstractBattleEnemy.h"
#import "BattleValkyrie.h"
#import "Projectile.h"
#import "Image.h"
#import "FadeInOrOut.h"
#import "PackedSpriteSheet.h"

@implementation NauthizSingleEnemy

- (void)dealloc {
    
    if (nauthizGhost) {
        [nauthizGhost release];
    }
    if (ghostProjectile) {
        [ghostProjectile release];
    }
    [super dealloc];
}

- (id)initToEnemy:(AbstractBattleEnemy *)aEnemy
{
    self = [super init];
    if (self) {
       
        BattleValkyrie *valk = [sharedGameController.battleCharacters objectForKey:@"BattleValkyrie"];
        essenceDamage = [valk calculateNauthizDamageTo:aEnemy];
        target1 = aEnemy;
        nauthizGhost = [[Image alloc] initWithImageNamed:@"Ghost.png" filter:GL_NEAREST];
        nauthizGhost.renderPoint = CGPointMake(140, 160);
        nauthizGhost.color = Color4fMake(1, 1, 1, 0);
        dimWorld = [[FadeInOrOut alloc] initFadeOutToAlpha:0.28 withDuration:1.05];
        stage = 0;
        duration = 1;
        active = YES;
    }
    
    return self;
}

- (void)updateWithDelta:(float)aDelta {
    
    if (active) {
        duration -= aDelta;
        if (duration < 0) {
            switch (stage) {
                case 0:
                    stage++;
                    ghostProjectile = [[Projectile alloc] initProjectileFrom:Vector2fMake(140, 160) to:Vector2fMake(target1.renderPoint.x - 50, target1.renderPoint.y) withImageFromSpriteSheet:[sharedGameController.teorPSS imageForKey:@"Frog40x40.png"] lasting:0.3 withStartAngle:0 withStartSize:Scale2fMake(1, 1) toFinishSize:Scale2fMake(1, 1)];
                    duration = 0.3;
                    break;
                case 1:
                    stage++;
                    [ghostProjectile release];
                    ghostProjectile = [[Projectile alloc] initProjectileFrom:Vector2fMake(target1.renderPoint.x - 50, target1.renderPoint.y) to:Vector2fMake(target1.renderPoint.x + 50, target1.renderPoint.y - 30) withImageFromSpriteSheet:[sharedGameController.teorPSS imageForKey:@"Frog40x40.png"] lasting:0.2 withStartAngle:345 withStartSize:Scale2fMake(1, 1) toFinishSize:Scale2fMake(1, 1)];
                    ghostProjectile.isBoomerang = YES;
                    duration = 0.4;
                    break;
                case 2:
                    stage++;
                    [ghostProjectile release];
                    ghostProjectile = [[Projectile alloc] initProjectileFrom:Vector2fMake(target1.renderPoint.x - 50, target1.renderPoint.y) to:Vector2fMake(target1.renderPoint.x + 50, target1.renderPoint.y + 30) withImageFromSpriteSheet:[sharedGameController.teorPSS imageForKey:@"Frog40x40.png"] lasting:0.2 withStartAngle:15 withStartSize:Scale2fMake(1, 1) toFinishSize:Scale2fMake(1, 1)];
                    ghostProjectile.isBoomerang = YES;
                    duration = 0.4;
                    break;
                case 3:
                    stage++;
                    [ghostProjectile release];
                    ghostProjectile = [[Projectile alloc] initProjectileFrom:Vector2fMake(target1.renderPoint.x - 50, target1.renderPoint.y) to:Vector2fMake(target1.renderPoint.x + 50, target1.renderPoint.y - 10) withImageFromSpriteSheet:[sharedGameController.teorPSS imageForKey:@"Frog40x40.png"] lasting:0.2 withStartAngle:0 withStartSize:Scale2fMake(1, 1) toFinishSize:Scale2fMake(1, 1)];
                    duration = 0.2;
                    break;
                case 4:
                    stage++;
                    [ghostProjectile release];
                    ghostProjectile = [[Projectile alloc] initProjectileFrom:Vector2fMake(target1.renderPoint.x + 50, target1.renderPoint.y - 10) to:Vector2fMake(180, 400) withImageFromSpriteSheet:[sharedGameController.teorPSS imageForKey:@"Frog40x40.png"] lasting:0.4 withStartAngle:0 withStartSize:Scale2fMake(1, 1) toFinishSize:Scale2fMake(0.2, 0.2)];
                    [target1 youTookEssenceDamage:essenceDamage];
                    duration = 0.4;
                    break;
                case 5:
                    stage++;
                    active = NO;
                    break;
                default:
                    break;
            }
        }
        switch (stage) {
            case 0:
                [dimWorld updateWithDelta:aDelta];
                nauthizGhost.color = Color4fMake(1, 1, 1, nauthizGhost.color.alpha + aDelta);
                break;
            case 1:
                [ghostProjectile updateWithDelta:aDelta];
                break;
            case 2:
                [ghostProjectile updateWithDelta:aDelta];
                break;
            case 3:
                [ghostProjectile updateWithDelta:aDelta];
                break;
            case 4:
                [ghostProjectile updateWithDelta:aDelta];
                break;
            case 5:
                [ghostProjectile updateWithDelta:aDelta];
            default:
                break;
        }
    }
}

- (void)render {
    
    if (active) {
        if (stage == 0) {
            
            [dimWorld render];
            [nauthizGhost renderCenteredAtPoint:nauthizGhost.renderPoint];
        } else if (stage < 6) {
            
            [dimWorld render];
            [ghostProjectile renderProjectiles];
        }
    }
}

@end

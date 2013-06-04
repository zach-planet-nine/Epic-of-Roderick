//
//  SwopazSingleEnemy.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/7/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "SwopazSingleEnemy.h"
#import "GameController.h"
#import "AbstractBattleEnemy.h"
#import "BattleRanger.h"
#import "Projectile.h"

@implementation SwopazSingleEnemy

- (void)dealloc {
    
    if (flyingLog) {
        [flyingLog release];
    }
    [super dealloc];
}

- (id)initToEnemy:(AbstractBattleEnemy *)aEnemy
{
    self = [super init];
    if (self) {
        
        BattleRanger *ranger = [sharedGameController.battleCharacters objectForKey:@"BattleRanger"];
        target1 = aEnemy;
        damage = [ranger calculateSwopazDamageTo:aEnemy];
        flyingLog = [[Projectile alloc] initProjectileFrom:Vector2fMake(50, 460) to:Vector2fMake(aEnemy.renderPoint.x, aEnemy.renderPoint.y) withImage:@"Log.png" lasting:1 withStartAngle:290 withStartSize:Scale2fMake(1, 1) toFinishSize:Scale2fMake(1, 1)];
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
                    [target1 flashColor:Color4fMake(0.4, 0.2, 0, 1)];
                    [target1 youTookDamage:damage];
                    duration = 1;
                    break;
                case 1:
                    stage++;
                    active = NO;
                    break;
                    
                default:
                    break;
            }
        }
        if (stage == 0) {
            [flyingLog updateWithDelta:aDelta];
        }
    }
}

- (void)render {
    
    if (active && stage == 0) {
        [flyingLog renderProjectiles];
    }
}

@end

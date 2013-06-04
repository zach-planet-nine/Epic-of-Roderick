//
//  ThurisazSingleEnemy.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/6/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "ThurisazSingleEnemy.h"
#import "GameController.h"
#import "AbstractBattleEnemy.h"
#import "BattleRanger.h"
#import "Projectile.h"

@implementation ThurisazSingleEnemy

- (void)dealloc {
    
    if (thorns) {
        [thorns release];
    }
    [super dealloc];
}

- (id)initToEnemy:(AbstractBattleEnemy *)aEnemy
{
    self = [super init];
    if (self) {
        
        BattleRanger *ranger = [sharedGameController.battleCharacters objectForKey:@"BattleRanger"];
        target1 = aEnemy;
        float possibleThorns = ((ranger.power + ranger.powerModifier + ranger.woodAffinity) / 4) * (ranger.essence / ranger.maxEssence);
        possibleThorns = MIN(20, possibleThorns);
        if (possibleThorns > 0) {
            thorns = [[NSMutableArray alloc] init];
        }
        for (int i = 0; i < possibleThorns; i++) {
            if (RANDOM_0_TO_1() < 0.8) {
                Vector2f fromPoint = Vector2fMake(240 + (RANDOM_MINUS_1_TO_1() * 1000), (160 + (RANDOM_MINUS_1_TO_1() * 1000)));
                Vector2f vector = Vector2fMake(aEnemy.renderPoint.x - fromPoint.x, aEnemy.renderPoint.y - fromPoint.y);
                if (vector.x == 0) {
                    vector.x = 1;
                }
                if (vector.y == 0) {
                    vector.y = 1;
                }
                float angle = atanf((vector.y / vector.x)) * 57.2957795;
                if (angle < 0 && vector.x < 0) {
                    angle += 180;
                } else if (angle < 0 && vector.y < 0) {
                    angle += 360;
                } else if (vector.x < 0 && vector.y < 0) {
                    angle += 180;
                }

                                                   
                Projectile *thorn = [[Projectile alloc] initProjectileFrom:fromPoint to:Vector2fMake(aEnemy.renderPoint.x, aEnemy.renderPoint.y) withImage:@"Thorn.png" lasting:(sqrtf(powf(fromPoint.x - aEnemy.renderPoint.x, 2) + powf(fromPoint.y - aEnemy.renderPoint.y, 2)) / 1000) withStartAngle:angle withStartSize:Scale2fMake(1, 1) toFinishSize:Scale2fMake(1, 1)];
                [thorns addObject:thorn];
                [thorn release];
                hasDamaged[i] = NO;
            }
        }
        damage = [ranger calculateThurisazDamageTo:aEnemy];
        stage = 0;
        duration = 2;
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
                    active = NO;
                    break;
                default:
                    break;
            }
        }
        for (Projectile *thorn in thorns) {
            [thorn updateWithDelta:aDelta];
            if (fabsf(thorn.currentPoint.x - target1.renderPoint.x) < 10 && fabsf(thorn.currentPoint.y - target1.renderPoint.y) < 10 && !hasDamaged[[thorns indexOfObject:thorn]]) {
                [target1 flashColor:Color4fMake(0, 1, 0, 1)];
                [target1 youTookDamage:(int)(((float)damage * RANDOM_0_TO_1()) + ((float)damage * RANDOM_0_TO_1()))];
                hasDamaged[[thorns indexOfObject:thorn]] = YES;
            }
        }
    }
}

- (void)render {
    
    if (active) {
        for (Projectile *thorn in thorns) {
            [thorn renderProjectiles];
        }
    }
}

@end

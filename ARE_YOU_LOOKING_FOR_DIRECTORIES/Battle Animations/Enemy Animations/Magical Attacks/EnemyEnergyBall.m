//
//  EnemyEnergyBall.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/13/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "EnemyEnergyBall.h"
#import "AbstractBattleEnemy.h"
#import "AbstractBattleCharacter.h"
#import "Projectile.h"
#import "Image.h"

@implementation EnemyEnergyBall

- (void)dealloc {
    
    if (energyBall) {
        [energyBall release];
    }
    [super dealloc];
}

- (id)initFromEnemy:(AbstractBattleEnemy *)aEnemy toCharacter:(AbstractBattleCharacter *)aCharacter
{
    self = [super init];
    if (self) {
        
        target1 = aCharacter;
        energyBall = [[Projectile alloc] initProjectileFrom:Vector2fMake(aEnemy.renderPoint.x - 30, aEnemy.renderPoint.y + 20) to:Vector2fMake(aCharacter.renderPoint.x, aCharacter.renderPoint.y) withImage:@"EnergyBall.png" lasting:0.5 withStartAngle:180 withStartSize:Scale2fMake(0.9, 0.9) toFinishSize:Scale2fMake(1, 1)];
        energyBall.image.color = Yellow;
        damage = [aEnemy calculateEnergyBallDamageToCharacter:aCharacter];
        stage = 10;
        duration = 0.3;
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
                    [target1 flashColor:Yellow];
                    [target1 youTookDamage:damage];
                    duration = 1;
                    break;
                case 1:
                    stage++;
                    active = NO;
                    break;
                case 10:
                    stage = 0;
                    duration = 0.5;
                    break;
                default:
                    break;
            }
        }
        if (stage == 0) {
            [energyBall updateWithDelta:aDelta];
        }
    }
}

- (void)render {
    
    if (active && stage == 0) {
        [energyBall renderProjectiles];
    }
}

@end

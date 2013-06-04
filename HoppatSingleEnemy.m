//
//  HoppatSingleEnemy.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/7/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "HoppatSingleEnemy.h"
#import "GameController.h"
#import "AbstractBattleEnemy.h"
#import "BattleRanger.h"
#import "Projectile.h"
#import "BattleStringAnimation.h"

@implementation HoppatSingleEnemy

- (void)dealloc {
    
    if (sloth) {
        [sloth release];
    }
    [super dealloc];
}

- (id)initToEnemy:(AbstractBattleEnemy *)aEnemy
{
    self = [super init];
    if (self) {
        
        BattleRanger *ranger = [sharedGameController.battleCharacters objectForKey:@"BattleRanger"];
        target1 = aEnemy;
        hoppatDuration = [ranger calculateHoppatDurationTo:aEnemy];
        if (hoppatDuration > 0) {
            sloth = [[Projectile alloc] initProjectileFrom:Vector2fMake(240, 160) to:Vector2fMake(aEnemy.renderPoint.x, aEnemy.renderPoint.y) withImage:@"Sloth.png" lasting:1 withStartAngle:0 withStartSize:Scale2fMake(1, 1) toFinishSize:Scale2fMake(0.1, 0.1)];
            stage = 0;
            duration = 1;
            active = YES;
        } else {
            [BattleStringAnimation makeIneffectiveStringAt:aEnemy.renderPoint];
            stage = 2;
            active = NO;
        }
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
                    [target1 youWereSlothed:hoppatDuration];
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
            [sloth updateWithDelta:aDelta];
        }
    }
}

- (void)render {
    
    if (active && stage == 0) {
        [sloth renderProjectiles];
    }
}

@end

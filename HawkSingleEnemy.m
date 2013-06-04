//
//  HawkSingleEnemy.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 8/10/11.
//  Copyright (c) 2011 InstantLazer. All rights reserved.
//

#import "HawkSingleEnemy.h"
#import "Hawk.h"
#import "AbstractBattleEntity.h"
#import "AbstractBattleEnemy.h"


@implementation HawkSingleEnemy 

- (void)dealloc {
    [super dealloc];
}

- (id)initToEnemy:(AbstractBattleEnemy *)aEnemy fromHawk:(Hawk *)aHawk {
    
    self = [super init];
    if (self) {
        target1 = aEnemy;
        hawk = aHawk;
        hawkVelocity = Vector2fMake((target1.renderPoint.x - hawk.renderPoint.x) * 2, (target1.renderPoint.y + 40 - hawk.renderPoint.y) * 2);
        originalEnemyRenderPoint = target1.renderPoint;
        originalHawkRenderPoint = hawk.renderPoint;
        stage = 0;
        duration = 0.5;
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
                    hawkVelocity = Vector2fMake(75, 600);
                    duration = 0.5;
                    break;
                case 1:
                    stage++;
                    target1.wait = YES;
                    target1.waitTimer = 0.9;
                    target1.renderPoint = CGPointMake(originalEnemyRenderPoint.x, originalEnemyRenderPoint.y + 500);
                    enemyVelocity = Vector2fMake(0, -500);
                    hawkVelocity = Vector2fMake(originalHawkRenderPoint.x - hawk.renderPoint.x, originalHawkRenderPoint.y - hawk.renderPoint.y);
                    duration = 1;
                    break;
                case 2:
                    stage++;
                    hawk.renderPoint = originalHawkRenderPoint;
                    target1.renderPoint = originalEnemyRenderPoint;
                    [target1 youTookDamage:[hawk calculateHawkDropDamageTo:target1]];
                    [target1 flashColor:Red];
                    duration = 1;
                    break;
                case 3:
                    stage++;
                    active = NO;
                    break;
                    
                default:
                    break;
            }
        }
        switch (stage) {
            case 0:
                aDelta = aDelta;
                Vector2f temp = Vector2fMultiply(hawkVelocity, aDelta);
                hawk.renderPoint = CGPointMake(hawk.renderPoint.x + temp.x, hawk.renderPoint.y + temp.y);
                break;
            case 1:
                aDelta = aDelta;
                Vector2f temp1 = Vector2fMultiply(hawkVelocity, aDelta);
                hawk.renderPoint = CGPointMake(hawk.renderPoint.x + temp1.x, hawk.renderPoint.y + temp1.y);
                target1.renderPoint = CGPointMake(target1.renderPoint.x + temp1.x, target1.renderPoint.y + temp1.y);
                break;
            case 2:
                aDelta = aDelta;
                Vector2f hawkTemp = Vector2fMultiply(hawkVelocity, aDelta);
                Vector2f enemyTemp = Vector2fMultiply(enemyVelocity, aDelta);
                target1.renderPoint = CGPointMake(target1.renderPoint.x + enemyTemp.x, target1.renderPoint.y + enemyTemp.y);
                hawk.renderPoint = CGPointMake(hawk.renderPoint.x + hawkTemp.x, hawk.renderPoint.y + hawkTemp.y);
                break;
                
            default:
                break;
        }
    }
}

@end

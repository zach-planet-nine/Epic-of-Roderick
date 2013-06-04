//
//  EhwazAllEnemies.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/8/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "EhwazAllEnemies.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleEnemy.h"
#import "BattlePriest.h"
#import "Projectile.h"

@implementation EhwazAllEnemies

- (id)init
{
    self = [super init];
    if (self) {
        
        BattlePriest *poet = [sharedGameController.battleCharacters objectForKey:@"BattlePriest"];
        int enemyIndex = 0;
        for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
            if ([enemy isKindOfClass:[AbstractBattleEnemy class]]) {
                float tempDamage = (float)[poet calculateEhwazDamageTo:enemy];
                tempDamage *= 0.6;
                damages[enemyIndex] = (int)tempDamage;
                enemyIndex++;
            }
        }
        sleipnir = [[Projectile alloc] initProjectileFrom:Vector2fMake(240, -100) to:Vector2fMake(480, 420) withImage:@"Sleipnir.png" lasting:0.5 withStartAngle:45 withStartSize:Scale2fMake(1, 1) toFinishSize:Scale2fMake(1, 1)];
        stage = 0;
        duration = 0.6;
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
                    [sleipnir release];
                    sleipnir = [[Projectile alloc] initProjectileFrom:Vector2fMake(240, 420) to:Vector2fMake(480, -100) withImage:@"Sleipnir.png" lasting:0.4 withStartAngle:315 withStartSize:Scale2fMake(1, 1) toFinishSize:Scale2fMake(1, 1)];
                    duration = 0.5;
                    break;
                case 1:
                    stage++;
                    [sleipnir release];
                    sleipnir = [[Projectile alloc] initProjectileFrom:Vector2fMake(-100, 160) to:Vector2fMake(540, 160) withImage:@"Sleipnir.png" lasting:0.5 withStartAngle:0 withStartSize:Scale2fMake(1, 1) toFinishSize:Scale2fMake(1, 1)];
                    duration = 0.5;
                    break;
                case 2:
                    stage++;
                    int enemyIndex = 0;
                    for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
                        if ([enemy isKindOfClass:[AbstractBattleEnemy class]]) {
                            [enemy youTookDamage:damages[enemyIndex]];
                            if (enemy.isAlive) {
                                [enemy flashColor:Color4fMake(1, 0, 0, 1)];
                            }
                            enemyIndex++;
                        }
                    }
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
        if (sleipnir) {
            [sleipnir updateWithDelta:aDelta];
        }
    }
}

- (void)render {
    
    if (active && sleipnir) {
        [sleipnir renderProjectiles];
    }
}

@end

//
//  LaguzAllEnemies.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/7/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "LaguzAllEnemies.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleEnemy.h"
#import "BattleRanger.h"
#import "ParticleEmitter.h"

@implementation LaguzAllEnemies

- (void)dealloc {
    
    if (snakeEmitter) {
        [snakeEmitter release];
    }
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        
        BattleRanger *ranger = [sharedGameController.battleCharacters objectForKey:@"BattleRanger"];
        int enemyIndex = 0;
        for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
            if ([enemy isKindOfClass:[AbstractBattleEnemy class]]) {
                damages[enemyIndex] = [ranger calculateLaguzDamageTo:enemy];
                enemyIndex++;
            }
        }
        snakeEmitter = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"SnakeEmitter.pex"];
        snakeEmitter.sourcePosition = Vector2fMake(-60, 160);
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
                    int enemyIndex = 0;
                    for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
                        if ([enemy isKindOfClass:[AbstractBattleEnemy class]]) {
                            [enemy youTookDamage:damages[enemyIndex]];
                            if (enemy.isAlive) {
                                [enemy flashColor:Color4fMake(0, 1, 0, 1)];
                                enemy.poisonAffinity -= 2;
                            }
                            enemyIndex++;
                        }
                    }
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
        [snakeEmitter updateWithDelta:aDelta];
    }
}

- (void)render {
    
    if (active) {
        [snakeEmitter renderParticles];
    }
}

@end

//
//  EpelthAllEnemies.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/10/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "EpelthAllEnemies.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleEnemy.h"
#import "BattlePriest.h"
#import "ParticleEmitter.h"

@implementation EpelthAllEnemies

- (void)dealloc {
    
    if (epelthEmitter) {
        [epelthEmitter release];
    }
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        
        BattlePriest *poet = [sharedGameController.battleCharacters objectForKey:@"BattlePriest"];
        int enemyIndex = 0;
        for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
            if ([enemy isKindOfClass:[AbstractBattleEnemy class]]) {
                damages[enemyIndex] = [poet calculateEpelthDamageTo:enemy];
                enemyIndex++;
            }
        }
        epelthEmitter = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"EpelthEmitter.pex"];
        epelthEmitter.sourcePosition = Vector2fMake(280, 40);
        xDirection = 1;
        yDirection = 1;
        stage = 0;
        duration = 1.5;
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
                                [enemy flashColor:Color4fMake(0.4, 0, 0.4, 1)];
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
        if (stage == 0) {
            epelthEmitter.sourcePosition = Vector2fMake(epelthEmitter.sourcePosition.x + (aDelta * 200 * xDirection), epelthEmitter.sourcePosition.y + (aDelta * 400 * yDirection));
            if (epelthEmitter.sourcePosition.x > 460 || epelthEmitter.sourcePosition.x < 280) {
                xDirection *= -1;
            }
            if (epelthEmitter.sourcePosition.y > 300 || epelthEmitter.sourcePosition.y < 20) {
                yDirection *= -1;
            }
            [epelthEmitter updateWithDelta:aDelta];
        }
    }
}

- (void)render {
    
    if (active && stage == 0) {
        [epelthEmitter renderParticles];
    }
}

@end

//
//  AlgizAllEnemies.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/7/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "AlgizAllEnemies.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleEnemy.h"
#import "BattleRanger.h"
#import "ParticleEmitter.h"
#import "BattleStringAnimation.h"

@implementation AlgizAllEnemies

- (void)dealloc {
    
    if (essenceEmitter) {
        [essenceEmitter release];
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
                if (enemy.isAlive && (RANDOM_0_TO_1() * 100) < ([ranger calculateAlgizDurationTo:enemy] * 2)) {
                    emitterPoints[enemyIndex] = Vector2fMake(enemy.renderPoint.x, enemy.renderPoint.y + 20);
                    algizDurations[enemyIndex] = [ranger calculateAlgizDurationTo:enemy];
                    enemyIndex++;
                } else {
                    emitterPoints[enemyIndex] = Vector2fMake(0, 0);
                    algizDurations[enemyIndex] = 0;
                    if (enemy.isAlive) {
                        [BattleStringAnimation makeIneffectiveStringAt:enemy.renderPoint];
                    }
                    enemyIndex++;
                }
            }
        }
        essenceEmitter = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"EssenceEmitter.pex"];
        essenceEmitter.startColor = Color4fMake(0, 0, 0, 1);
        essenceEmitter.gravity = Vector2fMake(0, -500);
        essenceEmitter.speed = 0;
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
                            if (algizDurations[enemyIndex] > 0) {
                                [enemy youWereDrauraed:(int)algizDurations[enemyIndex]];
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
        for (int i = 0; i < 4; i++) {
            if (emitterPoints[i].x != 0) {
                essenceEmitter.sourcePosition = emitterPoints[i];
                [essenceEmitter updateWithDelta:aDelta];
            }
        }
    }
}

- (void)render {
    
    if (active && stage == 0) {
        [essenceEmitter renderParticles];
    }
}

@end

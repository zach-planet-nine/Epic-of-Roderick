//
//  GromanthAllEnemies.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/21/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "GromanthAllEnemies.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleEnemy.h"
#import "AbstractBattleEntity.h"
#import "ParticleEmitter.h"
#import "BattleRoderick.h"
#import "BattleStringAnimation.h"


@implementation GromanthAllEnemies

- (void)dealloc {
    
    if (statEmitters) {
        [statEmitters release];
    }
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        int timerIndex = 0;
        statEmitters = [[NSMutableArray alloc] init];
        BattleRoderick *roderick = [sharedGameController.battleCharacters objectForKey:@"BattleRoderick"];
        for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
            if ([enemy isKindOfClass:[AbstractBattleEnemy class]] && enemy.isAlive) {
                timers[timerIndex] = [roderick calculateGromanthAffinityTimeTo:enemy];
                timerIndex++;
                ParticleEmitter *statModifier = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"StatModifierEmitter.pex"];
                statModifier.startColor = Color4fMake(0, 0.4, 0.6, 1);
                statModifier.sourcePosition = Vector2fMake(enemy.renderPoint.x, enemy.renderPoint.y);
                [statEmitters addObject:statModifier];
                [statModifier release];
            }
        }
        stage = 0;
        active = YES;
        duration = 2;
        
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
                    int timerIndex = 0;
                    BattleRoderick *roderick = [sharedGameController.battleCharacters objectForKey:@"BattleRoderick"];
                    for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
                        if ([enemy isKindOfClass:[AbstractBattleEnemy class]] && enemy.isAlive) {
                            if (timers[timerIndex] > 0) {
                                if (roderick.level + roderick.levelModifier - enemy.level - enemy.levelModifier + 5 > 0) {
                                    [enemy decreaseAffinityModifierBy:(int)(roderick.level + roderick.levelModifier - enemy.level - enemy.levelModifier + 5)];
                                } else {
                                    BattleStringAnimation *ineffective = [[BattleStringAnimation alloc] initIneffectiveStringFrom:enemy.renderPoint];
                                    [sharedGameController.currentScene addObjectToActiveObjects:ineffective];
                                    [ineffective release];
                                }
                            }
                            enemies[timerIndex] = CGPointMake((float)[sharedGameController.currentScene.activeEntities indexOfObject:enemy], MAX(0, roderick.level + roderick.levelModifier - enemy.level - enemy.levelModifier + 5));
                            timerIndex++;
                        }
                    }
                    duration = 1;
                    break;
                case 1:
                    stage++;
                    duration = MAX(timers[0], timers[1]);
                    duration = MAX(duration, timers[2]);
                    duration = MAX(duration, timers[3]);
                    duration += 1;
                    break;
                case 2:
                    stage++;
                    active = NO;
                    break;
                default:
                    break;
            }
        }
        switch (stage) {
            case 0:
                for (ParticleEmitter *pe in statEmitters) {
                    [pe updateWithDelta:aDelta];
                }
                break;
            case 1:
                for (ParticleEmitter *pe in statEmitters) {
                    [pe updateWithDelta:aDelta];
                }
                for (int i = 0; i < 4; i++) {
                    if (timers[i] > 0) {
                        timers[i] -= aDelta;
                        if (timers[i] < 0) {
                            timers[i] = 0;
                            [[sharedGameController.currentScene.activeEntities objectAtIndex:(int)enemies[i].x] increaseAffinityModifierBy:enemies[i].y];
                        }
                    }
                }
                break;
            case 2:
                for (int i = 0; i < 4; i++) {
                    if (timers[i] > 0) {
                        timers[i] -= aDelta;
                        if (timers[i] < 0) {
                            timers[i] = 0;
                            [[sharedGameController.currentScene.activeEntities objectAtIndex:(int)enemies[i].x] increaseAffinityModifierBy:enemies[i].y];
                        }
                    }
                }
                break;
                
            default:
                break;
        }
    }
}

- (void)render {
    
    if (active && stage < 2) {
        for (ParticleEmitter *pe in statEmitters) {
            [pe renderParticles];
        }
    }
}

@end

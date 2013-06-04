//
//  FehuAllEnemies.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/6/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "FehuAllEnemies.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleEnemy.h"
#import "BattleRanger.h"
#import "ParticleEmitter.h"
#import "BattleStringAnimation.h"

@implementation FehuAllEnemies

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
        BattleRanger *ranger = [sharedGameController.battleCharacters objectForKey:@"BattleRanger"];
        for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
            if ([enemy isKindOfClass:[AbstractBattleEnemy class]] && enemy.isAlive) {
                timers[timerIndex] = [ranger calculateFehuStatTimeTo:enemy];
                timerIndex++;
                ParticleEmitter *statModifier = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"StatModifierEmitter.pex"];
                statModifier.startColor = Color4fMake(0, 0.8, 0.1, 1);
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
                    BattleRanger *ranger = [sharedGameController.battleCharacters objectForKey:@"BattleRanger"];
                    for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
                        if ([enemy isKindOfClass:[AbstractBattleEnemy class]] && enemy.isAlive) {
                            if (timers[timerIndex] > 0) {
                                if (ranger.level + ranger.levelModifier - enemy.level - enemy.levelModifier + 5 > 0) {
                                    [enemy decreaseAgilityModifierBy:(int)(ranger.level + ranger.levelModifier - enemy.level - enemy.levelModifier + 2)];
                                    [enemy decreaseDexterityModifierBy:(int)(ranger.level + ranger.levelModifier - enemy.level - enemy.levelModifier + 2)];
                                } else {
                                    BattleStringAnimation *ineffective = [[BattleStringAnimation alloc] initIneffectiveStringFrom:enemy.renderPoint];
                                    [sharedGameController.currentScene addObjectToActiveObjects:ineffective];
                                    [ineffective release];
                                }
                            }
                            enemies[timerIndex] = CGPointMake((float)[sharedGameController.currentScene.activeEntities indexOfObject:enemy], MAX(0, ranger.level + ranger.levelModifier - enemy.level - enemy.levelModifier + 2));
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
                            [[sharedGameController.currentScene.activeEntities objectAtIndex:(int)enemies[i].x] increaseAgilityModifierBy:enemies[i].y];
                            [[sharedGameController.currentScene.activeEntities objectAtIndex:(int)enemies[i].x] increaseDexterityModifierBy:enemies[i].y];
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
                            [[sharedGameController.currentScene.activeEntities objectAtIndex:(int)enemies[i].x] increaseAgilityModifierBy:enemies[i].y];
                            [[sharedGameController.currentScene.activeEntities objectAtIndex:(int)enemies[i].x] increaseDexterityModifierBy:enemies[i].y];
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

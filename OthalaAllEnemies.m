//
//  OthalaAllEnemies.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/21/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "OthalaAllEnemies.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleEnemy.h"
#import "BattleRoderick.h"
#import "ParticleEmitter.h"
#import "FadeInOrOut.h"

@implementation OthalaAllEnemies

- (id)init
{
    self = [super init];
    if (self) {
        
        BattleRoderick *roderick = [sharedGameController.battleCharacters objectForKey:@"BattleRoderick"];
        damage = [roderick calculateOthalaDamageTo:nil];
        othalaEmitters = [[NSMutableArray alloc] init];
        CGPoint emitterPoint = roderick.renderPoint;
        for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
            if ([enemy isKindOfClass:[AbstractBattleEnemy class]] && enemy.isAlive) {
                if (emitterPoint.x == enemy.renderPoint.x) {
                    emitterPoint = CGPointMake(emitterPoint.x - 5, emitterPoint.y);
                }
                ParticleEmitter *othalaEmitter = [[ParticleEmitter alloc] initSinWaveEmitterWithFile:@"LightningSinWaveTest.pex" fromPoint:emitterPoint toPoint:enemy.renderPoint];
                emitterPoint = enemy.renderPoint;
                othalaEmitter.active = NO;
                [othalaEmitters addObject:othalaEmitter];
                [othalaEmitter release];
            }
        }
        
        dimWorld = [[FadeInOrOut alloc] initFadeOutToAlpha:0.3 withDuration:1.5];
        stage = 0;
        active = YES;
        duration = 1.5;
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
                    duration = 0.5;
                    break;
                case 1:
                    stage++;
                    duration = 0.5;
                    dimWorld.active = YES;
                    ParticleEmitter *oe = [othalaEmitters objectAtIndex:0];
                    oe.active = YES;
                    break;
                case 2:
                    stage++;
                    if ([othalaEmitters count] > 1) {
                        ParticleEmitter *oe = [othalaEmitters objectAtIndex:1];
                        oe.active = YES;
                        duration = 0.5;
                    } else {
                        stage = 5;
                    }
                    break;
                case 3:
                    stage++;
                    if ([othalaEmitters count] > 2) {
                        ParticleEmitter *oe = [othalaEmitters objectAtIndex:2];
                        oe.active = YES;
                        duration = 0.5;
                    } else {
                        stage = 5;
                    }
                    break;
                case 4:
                    stage++;
                    if ([othalaEmitters count] > 3) {
                        ParticleEmitter *oe = [othalaEmitters objectAtIndex:3];
                        oe.active = YES;
                        duration = 0.5;
                    } else {
                        stage = 5;
                    }
                    break;
                case 5:
                    stage++;
                    for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
                        if ([enemy isKindOfClass:[AbstractBattleEnemy class]] && enemy.isAlive) {
                            [enemy flashColor:Color4fMake(0.8, 0.8, 0.1, 1)];
                            [enemy youTookDamage:damage];
                        }
                    }
                    duration = 1;
                    break;
                case 6:
                    stage++;
                    active = NO;
                    break;
                    
                default:
                    break;
            }

        }
        switch (stage) {
            case 0:
                [dimWorld updateWithDelta:aDelta];
                break;
            case 1:
                for (ParticleEmitter *pe in othalaEmitters) {
                    [pe updateWithDelta:aDelta];
                }
                break;
            case 2:
                for (ParticleEmitter *pe in othalaEmitters) {
                    [pe updateWithDelta:aDelta];
                }
                break;
            case 3:
                for (ParticleEmitter *pe in othalaEmitters) {
                    [pe updateWithDelta:aDelta];
                }
                break;
            case 4:
                for (ParticleEmitter *pe in othalaEmitters) {
                    [pe updateWithDelta:aDelta];
                }
                break;
            default:
                break;
        }
    }
}

- (void)render {
    
    if (active) {
        [dimWorld render];
        for (ParticleEmitter *pe in othalaEmitters) {
            [pe renderParticles];
        }
    }
}

@end

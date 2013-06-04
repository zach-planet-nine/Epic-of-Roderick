//
//  PrimazAllEnemies.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/26/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "PrimazAllEnemies.h"
#import "ImageRenderManager.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleEnemy.h"
#import "BattleValkyrie.h"
#import "ParticleEmitter.h"
#import "FadeInOrOut.h"

@implementation PrimazAllEnemies

- (void)dealloc {
    
    if (rageExplosion) {
        [rageExplosion release];
    }
    if (dimWorld) {
        [dimWorld release];
    }
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        
        BattleValkyrie *valk = [sharedGameController.battleCharacters objectForKey:@"BattleValkyrie"];
        enemyIndex = 0;
        for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
            if ([enemy isKindOfClass:[AbstractBattleEnemy class]]) {
                if (enemy.isAlive) {
                    damages[enemyIndex] = [valk calculatePrimazDamageTo:enemy];
                    affinities[enemyIndex] = (int)(((valk.rageAffinity - enemy.rageAffinity) / 2) * (valk.essence / valk.maxEssence));
                }
                enemyIndex++;
            }
        }
        rageExplosion = rageExplosion = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"WizardBallExplosion.pex"];
        rageExplosion.startColor = valk.essenceColor;
        rageExplosion.finishColor = Color4fMake(valk.essenceColor.red, valk.essenceColor.green, valk.essenceColor.blue, 0);
        rageExplosion.active = NO;
        dimWorld = [[FadeInOrOut alloc] initFadeOutWithDuration:1.55];
        enemyIndex = 0;
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
                    for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
                        if ([enemy isKindOfClass:[AbstractBattleEnemy class]]) {
                            if (enemy.isAlive) {
                                rageExplosion.sourcePosition = Vector2fMake(enemy.renderPoint.x, enemy.renderPoint.y);
                                [enemy youTookDamage:damages[enemyIndex]];
                                rageExplosion.sourcePosition = Vector2fMake(enemy.renderPoint.x, enemy.renderPoint.y);
                                rageExplosion.active = YES;
                                enemyIndex++;
                                duration = 0.5;
                                break;
                            } else {
                                enemyIndex++;
                            }
                        }
                        if (enemyIndex > 3) {
                            stage = 4;
                            duration = 0;
                        }
                    }
                    if (damages[enemyIndex] == 0 && damages[enemyIndex + 1] == 0 && damages[enemyIndex + 2] == 0) {
                        stage = 4;
                        duration = 0;
                    }
                    break;
                case 1:
                    stage++;
                    int index = 0;
                    for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
                        if ([enemy isKindOfClass:[AbstractBattleEnemy class]]) {
                            if (index >= enemyIndex && enemy.isAlive) {
                                enemyIndex = index;
                                rageExplosion.sourcePosition = Vector2fMake(enemy.renderPoint.x, enemy.renderPoint.y);
                                [enemy youTookDamage:damages[enemyIndex]];
                                rageExplosion.sourcePosition = Vector2fMake(enemy.renderPoint.x, enemy.renderPoint.y);
                                rageExplosion.active = YES;

                                enemyIndex++;
                                duration = 0.5;
                                break;
                            }
                            index++;
                            if (index > 3) {
                                stage = 4;
                                duration = 0;
                            }
                        }
                    }
                    break;
                case 2:
                    stage++;
                    int index1 = 0;
                    for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
                        if ([enemy isKindOfClass:[AbstractBattleEnemy class]]) {
                            if (index1 >= enemyIndex && enemy.isAlive) {
                                enemyIndex = index1;
                                rageExplosion.sourcePosition = Vector2fMake(enemy.renderPoint.x, enemy.renderPoint.y);
                                [enemy youTookDamage:damages[enemyIndex]];
                                rageExplosion.sourcePosition = Vector2fMake(enemy.renderPoint.x, enemy.renderPoint.y);
                                rageExplosion.active = YES;

                                enemyIndex++;
                                duration = 0.5;
                                break;
                            }
                            index1++;
                            if (index1 > 3) {
                                stage = 4;
                                duration = 0;
                            }
                        }
                    }
                    break;
                case 3:
                    stage++;
                    int index2 = 0;
                    for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
                        if ([enemy isKindOfClass:[AbstractBattleEnemy class]]) {
                            if (index2 >= enemyIndex && enemy.isAlive) {
                                enemyIndex = index2;
                                rageExplosion.sourcePosition = Vector2fMake(enemy.renderPoint.x, enemy.renderPoint.y);
                                [enemy youTookDamage:damages[enemyIndex]];
                                rageExplosion.sourcePosition = Vector2fMake(enemy.renderPoint.x, enemy.renderPoint.y);
                                rageExplosion.active = YES;

                                enemyIndex++;
                                duration = 0.5;
                                break;
                            }
                            index2++;
                            if (index2 > 3) {
                                stage = 4;
                                duration = 0;
                            }
                        }
                    }
                    break;
                case 4:
                    stage++;
                    active = NO;
                    break;
                default:
                    break;
            }
        }
        if (stage == 0) {
            [dimWorld updateWithDelta:aDelta];
        }
        [rageExplosion updateWithDelta:aDelta];
    }
}

- (void)render {
    
    if (active && stage < 4) {
        [dimWorld render];
        [[ImageRenderManager sharedImageRenderManager] renderImages];
        [rageExplosion renderParticles];
    }
}

@end

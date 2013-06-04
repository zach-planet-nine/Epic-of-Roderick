//
//  JeraAllEnemies.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/24/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "JeraAllEnemies.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleEnemy.h"
#import "BattleValkyrie.h"
#import "Image.h"
#import "ParticleEmitter.h"

@implementation JeraAllEnemies

- (void)dealloc {
    
    if (norn) {
        [norn release];
    }
    if (rageExplosion) {
        [rageExplosion release];
    }
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
       
        BattleValkyrie *valk = [sharedGameController.battleCharacters objectForKey:@"BattleValkyrie"];
        valkLevel = valk.level + valk.levelModifier;
        int enemyIndex = 0;
        for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
            if ([enemy isKindOfClass:[AbstractBattleEnemy class]] && enemy.isAlive) {
                damage += (int)(enemy.damageDealt * (valk.rageAffinity / enemy.rageAffinity));
                renderPoints[enemyIndex] = enemy.renderPoint;
                enemyIndex++;
            }
        }
        norn = [[Image alloc] initWithImageNamed:@"Norn.png" filter:GL_LINEAR];
        norn.color = Color4fMake(1, 1, 1, 0);
        norn.renderPoint = CGPointMake(renderPoints[0].x - 50, renderPoints[0].y);
        float tempDamage = MAX(40000, damage);
        tempDamage *= (valk.essence / valk.maxEssence);
        tempDamage /= (enemyIndex + 1);
        tempDamage = MAX(0, tempDamage);
        damage = (int)tempDamage;
        rageExplosion = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"WizardBallExplosion.pex"];
        rageExplosion.startColor = valk.essenceColor;
        rageExplosion.finishColor = Color4fMake(valk.essenceColor.red, valk.essenceColor.green, valk.essenceColor.blue, 0);
        rageExplosion.sourcePosition = Vector2fMake(renderPoints[0].x, renderPoints[0].y);
        alphaDirection = 2;
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
                    for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
                        if (enemy.renderPoint.x == rageExplosion.sourcePosition.x && enemy.renderPoint.y == rageExplosion.sourcePosition.y) {
                            [enemy youTookDamage:(int)(damage + (RANDOM_0_TO_1() * (10 * valkLevel)))];
                            [enemy flashColor:Color4fMake(1, 0, 0, 1)];
                            rageExplosion.active = YES;
                        }
                    }
                    alphaDirection *= -1;
                    duration = 0.5;
                    break;
                case 1:
                    stage++;
                    duration = 0.5;
                    alphaDirection *= -1;
                    norn.renderPoint = CGPointMake(renderPoints[1].x - 50, renderPoints[1].y);
                    if (norn.renderPoint.y == 0) {
                        stage = 7;
                        duration = 0;
                    }
                    break;
                case 2:
                    stage++;
                    rageExplosion.sourcePosition = Vector2fMake(renderPoints[1].x, renderPoints[1].y);
                    for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
                        if (enemy.renderPoint.x == rageExplosion.sourcePosition.x && enemy.renderPoint.y == rageExplosion.sourcePosition.y) {
                            [enemy youTookDamage:(int)(damage + (RANDOM_0_TO_1() * (10 * valkLevel)))];
                            [enemy flashColor:Color4fMake(1, 0, 0, 1)];
                            rageExplosion.active = YES;
                        }
                    }
                    alphaDirection *= -1;
                    duration = 0.5;
                    break;
                case 3:
                    stage++;
                    duration = 0.5;
                    alphaDirection *= -1;
                    norn.renderPoint = CGPointMake(renderPoints[2].x - 50, renderPoints[2].y);
                    if (norn.renderPoint.y == 0) {
                        stage = 7;
                        duration = 0;
                    }
                    break;
                case 4:
                    stage++;
                    rageExplosion.sourcePosition = Vector2fMake(renderPoints[2].x, renderPoints[2].y);
                    for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
                        if (enemy.renderPoint.x == rageExplosion.sourcePosition.x && enemy.renderPoint.y == rageExplosion.sourcePosition.y) {
                            [enemy youTookDamage:(int)(damage + (RANDOM_0_TO_1() * (10 * valkLevel)))];
                            [enemy flashColor:Color4fMake(1, 0, 0, 1)];
                            rageExplosion.active = YES;
                        }
                    }
                    alphaDirection *= -1;
                    duration = 0.5;
                    break;
                case 5:
                    stage++;
                    duration = 0.5;
                    alphaDirection *= -1;
                    norn.renderPoint = CGPointMake(renderPoints[3].x - 50, renderPoints[3].y);
                    if (norn.renderPoint.y == 0) {
                        stage = 7;
                        duration = 0;
                    }
                    break;
                case 6:
                    stage++;
                    rageExplosion.sourcePosition = Vector2fMake(renderPoints[3].x, renderPoints[3].y);
                    for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
                        if (enemy.renderPoint.x == rageExplosion.sourcePosition.x && enemy.renderPoint.y == rageExplosion.sourcePosition.y) {
                            [enemy youTookDamage:(int)(damage + (RANDOM_0_TO_1() * (10 * valkLevel)))];
                            [enemy flashColor:Color4fMake(1, 0, 0, 1)];
                            rageExplosion.active = YES;
                        }
                    }
                    alphaDirection *= -1;
                    duration = 0.5;
                    break;
                case 7:
                    stage++;
                    duration = 1;
                    break;
                case 8:
                    stage++;
                    active = NO;    
                    break;
                default:
                    break;
            }
        }
        if (stage > 0) {
            [rageExplosion updateWithDelta:aDelta];
        }
        norn.color = Color4fMake(1, 1, 1, norn.color.alpha + (aDelta * alphaDirection));
    }
}

- (void)render {
    
    if (active) {
        [norn renderCenteredAtPoint:norn.renderPoint];
        [rageExplosion renderParticles];
    }
}

@end

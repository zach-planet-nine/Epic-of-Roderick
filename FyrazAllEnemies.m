//
//  FyrazAllEnemies.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/29/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "FyrazAllEnemies.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleEnemy.h"
#import "BattleWizard.h"
#import "ParticleEmitter.h"
#import "Image.h"

@implementation FyrazAllEnemies

- (void)dealloc {
    
    if (fyrazEmitters) {
        [fyrazEmitters release];
    }
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        
        BattleWizard *wizard = [sharedGameController.battleCharacters objectForKey:@"BattleWizard"];
        fyrazEmitters = [[NSMutableArray alloc] init];
        int enemyIndex = 0;
        for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
            if ([enemy isKindOfClass:[AbstractBattleEnemy class]]) {
                float tempDamage = (float)[wizard calculateFyrazDamageTo:enemy];
                tempDamage *= 0.5;
                damages[enemyIndex] = (int)tempDamage;
                enemy.fireAffinity -= 2;
                enemy.fireAffinity = MAX(1, enemy.fireAffinity);
                ParticleEmitter *fyrazEmitter = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"FyrazEmitter.pex"];
                [fyrazEmitters addObject:fyrazEmitter];
                [fyrazEmitter release];
                enemyIndex++;
            }
        }
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
                            ParticleEmitter *pe = [fyrazEmitters objectAtIndex:enemyIndex];
                            if (enemy.isAlive) {
                                [pe particlesBecomeProjectilesTo:enemy.renderPoint withDuration:0.5];
                            } else {
                                [pe particlesBecomeProjectilesTo:CGPointMake(560, 160) withDuration:0.6];
                            }
                            enemyIndex++;
                        }
                    }
                    duration = 0.5;
                    break;
                case 1:
                    stage++;
                    int damageIndex = 0;
                    for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
                        if ([enemy isKindOfClass:[AbstractBattleEnemy class]]) {
                            if (enemy.isAlive) {
                                [enemy flashColor:Color4fMake(1, 0, 0, 1)];
                            }
                            [enemy youTookDamage:damages[damageIndex]];
                            damageIndex++;
                        }
                    }
                    sharedGameController.currentScene.battleImage.color = Color4fOnes;
                    duration = 1;
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
                sharedGameController.currentScene.battleImage.color = Color4fMake(1, sharedGameController.currentScene.battleImage.color.green - aDelta, sharedGameController.currentScene.battleImage.color.blue - aDelta, 1);
                for (ParticleEmitter *pe in fyrazEmitters) {
                    [pe updateWithDelta:aDelta];
                }
                break;
            case 1:
                for (ParticleEmitter *pe in fyrazEmitters) {
                    [pe updateWithDelta:aDelta];
                }
                break;
                
            default:
                break;
        }
    }
}

- (void)render {
    
    if (active && stage < 2) {
        for (ParticleEmitter *pe in fyrazEmitters) {
            [pe renderParticles];
        }
    }
}

@end

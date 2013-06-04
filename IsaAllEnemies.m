//
//  IsaAllEnemies.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/19/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "IsaAllEnemies.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleEnemy.h"
#import "BattleRoderick.h"
#import "ParticleEmitter.h"
#import "WorldFlashColor.h"

@implementation IsaAllEnemies

- (id)init
{
    self = [super init];
    if (self) {
        BattleRoderick *roderick = [sharedGameController.battleCharacters objectForKey:@"BattleRoderick"];
        baseDamage = ((roderick.power + roderick.powerModifier) * 2) * (roderick.essence / roderick.maxEssence);
        iceEmitters = [[NSMutableArray alloc] init];
        for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
            if ([enemy isKindOfClass:[AbstractBattleEnemy class]] && enemy.isAlive) {
                ParticleEmitter *iceEmitter = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"IsaEmitter.pex"];
                [iceEmitters addObject:iceEmitter];
                [iceEmitter release];
            }
        }
        duration = 0.4;
        active = YES;
        stage = 0;
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
                    duration = 0.4;
                    WorldFlashColor *wfc = [[WorldFlashColor alloc] initColorFlashWithColor:Color4fMake(0, 0, 1, 0.3)];
                    [sharedGameController.currentScene addObjectToActiveObjects:wfc];
                    [wfc release];
                    break;
                case 1:
                    stage++;
                    duration = 0.6;
                    int i = 0;
                    for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
                        if ([enemy isKindOfClass:[AbstractBattleEnemy class]] && enemy.isAlive) {
                            [[iceEmitters objectAtIndex:i] particlesBecomeProjectilesTo:enemy.renderPoint withDuration:0.4];
                            i++;
                        }
                    }
                    break;
                case 2:
                    stage++;
                    active = NO;
                    BattleRoderick *roderick = [sharedGameController.battleCharacters objectForKey:@"BattleRoderick"];
                    for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
                        if ([enemy isKindOfClass:[AbstractBattleEnemy class]] && enemy.isAlive) {
                            float damage = baseDamage - (enemy.affinity + enemy.affinityModifier);
                            damage += (roderick.waterAffinity - enemy.waterAffinity) * 3;
                            damage += (arc4random() % 10) * (((roderick.level + roderick.levelModifier) / 10) + 1);
                            [enemy youTookDamage:(int)damage];
                        }
                    }
                    break;

                default:
                    break;
            }
        }
        switch (stage) {
            case 0:
                for (ParticleEmitter *pe in iceEmitters) {
                    [pe updateWithDelta:aDelta];
                }
                break;
            case 1:
                break;
            case 2:
                for (ParticleEmitter *pe in iceEmitters) {
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
        for (ParticleEmitter *pe in iceEmitters) {
            [pe renderParticles];
        }
    }
}

@end

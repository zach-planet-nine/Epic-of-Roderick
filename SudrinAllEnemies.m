//
//  SudrinAllEnemies.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/22/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "SudrinAllEnemies.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleEnemy.h"
#import "BattleRoderick.h"
#import "ParticleEmitter.h"
#import "BattleStringAnimation.h"

@implementation SudrinAllEnemies

- (void)dealloc {
    
    if (sudrinEmitter) {
        [sudrinEmitter release];
    }
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        
        BattleRoderick *roderick = [sharedGameController.battleCharacters objectForKey:@"BattleRoderick"];
        for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
            if ([enemy isKindOfClass:[AbstractBattleEnemy class]]) {
                if (roderick.skyAffinity > enemy.skyAffinity) {
                    enemy.waterAffinity -= 2;
                    enemy.skyAffinity -= 2;
                    enemy.rageAffinity -= 2;
                    enemy.lifeAffinity -= 2;
                    enemy.stoneAffinity -= 2;
                    enemy.fireAffinity -= 2;
                    enemy.woodAffinity -= 2;
                    enemy.poisonAffinity -= 2;
                    enemy.divineAffinity -= 2;
                    enemy.deathAffinity -= 2;
                }
                enemy.waterAffinity -= 1 + ((roderick.level + roderick.levelModifier) / 10) * (roderick.essence / roderick.maxEssence);
                enemy.skyAffinity -= 1 + ((roderick.level + roderick.levelModifier) / 10) * (roderick.essence / roderick.maxEssence);
                enemy.rageAffinity -= 1 + ((roderick.level + roderick.levelModifier) / 10) * (roderick.essence / roderick.maxEssence);
                enemy.lifeAffinity -= 1 + ((roderick.level + roderick.levelModifier) / 10) * (roderick.essence / roderick.maxEssence);
                enemy.stoneAffinity -= 1 + ((roderick.level + roderick.levelModifier) / 10) * (roderick.essence / roderick.maxEssence);
                enemy.fireAffinity -= 1 + ((roderick.level + roderick.levelModifier) / 10) * (roderick.essence / roderick.maxEssence);
                enemy.woodAffinity -= 1 + ((roderick.level + roderick.levelModifier) / 10) * (roderick.essence / roderick.maxEssence);
                enemy.poisonAffinity -= 1 + ((roderick.level + roderick.levelModifier) / 10) * (roderick.essence / roderick.maxEssence);
                enemy.divineAffinity -= 1 + ((roderick.level + roderick.levelModifier) / 10) * (roderick.essence / roderick.maxEssence);
                enemy.deathAffinity -= 1 + ((roderick.level + roderick.levelModifier) / 10) * (roderick.essence / roderick.maxEssence);
                enemy.waterAffinity = MAX(1, enemy.waterAffinity);
                enemy.skyAffinity = MAX(1, enemy.skyAffinity);
                enemy.rageAffinity = MAX(1, enemy.rageAffinity);
                enemy.lifeAffinity = MAX(1, enemy.lifeAffinity);
                enemy.stoneAffinity = MAX(1, enemy.stoneAffinity);
                enemy.fireAffinity = MAX(1, enemy.fireAffinity);
                enemy.woodAffinity = MAX(1, enemy.woodAffinity);
                enemy.poisonAffinity = MAX(1, enemy.poisonAffinity);
                enemy.divineAffinity = MAX(1, enemy.divineAffinity);
                enemy.deathAffinity = MAX(1, enemy.deathAffinity);

            }
        }
        sudrinEmitter = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"SudrinEmitter.pex"];
        stage = 0;
        duration = 2;
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
                    duration = 1;
                    for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
                        if ([enemy isKindOfClass:[AbstractBattleEnemy class]] && enemy.isAlive) {
                            BattleStringAnimation *bsa = [[BattleStringAnimation alloc] initStatusString:@"Affinities!" from:enemy.renderPoint];
                            [sharedGameController.currentScene addObjectToActiveObjects:bsa];
                            [bsa release];
                        }
                    }
                    break;
                    
                default:
                    break;
            }

        }
        switch (stage) {
            case 0:
                [sudrinEmitter updateWithDelta:aDelta];
                break;
                
            default:
                break;
        }
    }
}

- (void)render {
    
    if (active && stage == 0) {
        [sudrinEmitter renderParticles];
    }
}

@end

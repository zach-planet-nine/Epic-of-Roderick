//
//  SmeazAllEnemies.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/10/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "SmeazAllEnemies.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleCharacter.h"
#import "AbstractBattleEnemy.h"
#import "BattlePriest.h"
#import "ParticleEmitter.h"

@implementation SmeazAllEnemies

- (void)dealloc {
    
    if (smeazEmitters) {
        [smeazEmitters release];
    }
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        
        BattlePriest *poet = [sharedGameController.battleCharacters objectForKey:@"BattlePriest"];
        damage = 0;
        numberOfEnemies = 0;
        smeazEmitters = [[NSMutableArray alloc] init];
        for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
            if ([enemy isKindOfClass:[AbstractBattleEnemy class]] && enemy.isAlive) {
                damage += [poet calculateSmeazDamageTo:enemy];
                numberOfEnemies++;
            }
        }
        numberOfCharacters = 0;
        for (AbstractBattleCharacter *character in sharedGameController.currentScene.activeEntities) {
            if ([character isKindOfClass:[AbstractBattleCharacter class]] && character.isAlive) {
                ParticleEmitter *pe = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"BloodSplatter.pex"];
                [smeazEmitters addObject:pe];
                [pe release];
                numberOfCharacters++;
            }
        }
        stage = 0;
        duration = 0.3;
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
                    int peIndex = 0;
                    for (AbstractBattleCharacter *character in sharedGameController.currentScene.activeEntities) {
                        if ([character isKindOfClass:[AbstractBattleCharacter class]] && character.isAlive) {
                            if ([smeazEmitters objectAtIndex:peIndex]) {
                                ParticleEmitter *pe = [smeazEmitters objectAtIndex:peIndex];
                                [pe particlesBecomeProjectilesTo:character.renderPoint withDuration:0.5];
                            }
                            peIndex++;
                        }
                    }
                    for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
                        if ([enemy isKindOfClass:[AbstractBattleEnemy class]]) {
                            [enemy youTookDamage:(int)((float)damage / numberOfEnemies)];
                        }
                    }
                    duration = 0.5;
                    break;
                case 1:
                    stage++;
                    for (AbstractBattleCharacter *character in sharedGameController.currentScene.activeEntities) {
                        if ([character isKindOfClass:[AbstractBattleCharacter class]]) {
                            [character youWereHealed:(int)((float)damage / numberOfCharacters)];
                        }
                    }
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
        if (stage == 0) {
            for (ParticleEmitter *pe in smeazEmitters) {
                for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
                    if ([enemy isKindOfClass:[AbstractBattleEnemy class]] && enemy.isAlive) {
                        pe.sourcePosition = Vector2fMake(enemy.renderPoint.x, enemy.renderPoint.y);
                        [pe updateWithDelta:aDelta];
                    }
                }
            }
        }
        if (stage == 1) {
            for (ParticleEmitter *pe in smeazEmitters) {
                [pe updateWithDelta:aDelta];
            }
        }
    }
}

- (void)render {
    
    if (active && stage < 2) {
        for (ParticleEmitter *pe in smeazEmitters) {
            [pe renderParticles];
        }
    }
}

@end

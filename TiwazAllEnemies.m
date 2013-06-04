//
//  TiwazAllEnemies.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/28/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "TiwazAllEnemies.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleEnemy.h"
#import "BattleWizard.h"
#import "ParticleEmitter.h"

@implementation TiwazAllEnemies

- (void)dealloc {
    
    if (comets) {
        [comets release];
    }
    if (explosions) {
        [explosions release];
    }
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        
        BattleWizard *wizard = [sharedGameController.battleCharacters objectForKey:@"BattleWizard"];
        int enemyIndex = 0;
        for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
            if ([enemy isKindOfClass:[AbstractBattleEnemy class]]) {
                float tempDamage = (float)[wizard calculateTiwazDamageTo:enemy];
                tempDamage *= 0.7;
                damages[enemyIndex] = (int)tempDamage;
                enemyIndex++;
            }
        }
        comets = [[NSMutableArray alloc] init];
        explosions = [[NSMutableArray alloc] init];
        for (int i = 0; i < 8; i++) {
            float timer = (0.5 + (RANDOM_0_TO_1() * 0.5));
            Vector2f sourcePosition = Vector2fMake(240 - (RANDOM_0_TO_1() * 240), 360 + (RANDOM_0_TO_1() * 100));
            Vector2f destination = Vector2fMake(300 + (RANDOM_0_TO_1() * 180), RANDOM_0_TO_1() * 320);
            ParticleEmitter *comet = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"Comet.pex"];
            comet.sourcePosition = sourcePosition;
            velocities[i] = Vector2fMake((destination.x - sourcePosition.x) / timer, (destination.y - sourcePosition.y) / timer);
            cometDurations[i] = timer;
            [comets addObject:comet];
            [comet release];
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
                    duration = 0.05;
                    break;
                case 1:
                    stage++;
                    int enemyIndex = 0;
                    for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
                        if ([enemy isKindOfClass:[AbstractBattleEnemy class]]) {
                            [enemy youTookDamage:damages[enemyIndex]];
                            if (enemy.isAlive) {
                                [enemy flashColor:Color4fMake(1, 0.3, 0, 1)];
                            }
                            enemyIndex++;
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
        BOOL stillGoing = NO;
        for (int i = 0; i < 8; i++) {
            ParticleEmitter *comet = [comets objectAtIndex:i];
            comet.sourcePosition = Vector2fMake(comet.sourcePosition.x + (velocities[i].x * aDelta), comet.sourcePosition.y + (velocities[i].y * aDelta));
            [comet updateWithDelta:aDelta];
            if (cometDurations[i] > 0) {
                stillGoing = YES;
                cometDurations[i] -= aDelta;
                if (cometDurations[i] <= 0) {
                    cometDurations[i] = 0;
                    ParticleEmitter *explosion = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"Explosion.pex"];
                    explosion.sourcePosition = comet.sourcePosition;
                    [explosions addObject:explosion];
                    [explosion release];
                }
            }
        }
        for (ParticleEmitter *explo in explosions) {
            [explo updateWithDelta:aDelta];
        }
        if (stillGoing) {
            duration += aDelta;
        }
    }
}

- (void)render {
    
    if (active) {
        for (int i = 0; i < 8; i++) {
            if (cometDurations[i] > 0) {
                ParticleEmitter *comet = [comets objectAtIndex:i];
                [comet renderParticles];
            }
        }
        for (ParticleEmitter *explosion in explosions) {
            [explosion renderParticles];
        }
    }
}

@end

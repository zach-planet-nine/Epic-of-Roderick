//
//  HagalazAllEnemies.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/24/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "HagalazAllEnemies.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleEnemy.h"
#import "BattleValkyrie.h"
#import "ParticleEmitter.h"
#import "FadeInOrOut.h"

@implementation HagalazAllEnemies

- (void)dealloc {
    
    if (dimWorld) {
        [dimWorld release];
    }
    if (statEmitters) {
        [statEmitters release];
    }
    if (hailEmitter) {
        [hailEmitter release];
    }
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        BattleValkyrie *valk = [sharedGameController.battleCharacters objectForKey:@"BattleValkyrie"];
        statEmitters = [[NSMutableArray alloc] init];
        int enemyIndex = 0;
        for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
            if ([enemy isKindOfClass:[AbstractBattleEnemy class]]) {
                float hagalazDuration = [valk calculateHagalazDurationTo:enemy];
                hagalazDuration *= 0.7;
                hagalazDurations[enemyIndex] = hagalazDuration;
                float modifier = ((valk.affinity + valk.affinityModifier + valk.level + valk.levelModifier) * (valk.waterAffinity / enemy.waterAffinity) + 1);
                modifier /= 2.3;
                [enemy decreaseAgilityModifierBy:(int)(modifier)];
                [enemy decreaseDexterityModifierBy:(int)(modifier)];
                mods[enemyIndex] = CGPointMake(modifier, [sharedGameController.currentScene.activeEntities indexOfObject:enemy]);
                ParticleEmitter *statEmitter = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"StatModifierEmitter.pex"];
                statEmitter.startColor = Color4fMake(0, 0.8, 0.2, 0.9);
                statEmitter.finishColor = Color4fMake(0, 0.4, 0.05, 0);
                statEmitter.sourcePosition = Vector2fMake(enemy.renderPoint.x, enemy.renderPoint.y);
                [statEmitters addObject:statEmitter];
                enemyIndex++;
            }
        }
        hailEmitter = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"RainEmitter.pex"];
        dimWorld = [[FadeInOrOut alloc] initFadeOutToAlpha:0.3 withDuration:1];
        stage = 0;
        active = YES;
        duration = 1;

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
                    duration = 0.8;
                    break;
                case 1:
                    stage++;
                    duration = 1;
                    break;
                case 2:
                    stage++;
                    duration = MAX(hagalazDurations[0], hagalazDurations[1]);
                    duration = MAX(duration, hagalazDurations[2]);
                    duration = MAX(duration, hagalazDurations[3]);
                    break;
                case 3:
                    stage++;
                    active = NO;
                    
                default:
                    break;
            }
        }
        switch (stage) {
            case 0:
                [dimWorld updateWithDelta:aDelta];
                break;
            case 1:
                [hailEmitter updateWithDelta:aDelta];
                break;
            case 2:
                [hailEmitter updateWithDelta:aDelta];
                for (ParticleEmitter *pe in statEmitters) {
                    [pe updateWithDelta:aDelta];
                }
                break;
            case 3:
                for (int i = 0; i < 4; i++) {
                    if (hagalazDurations[i] > 0) {
                        hagalazDurations[i] -= aDelta;
                        if (hagalazDurations[i] <= 0) {
                            AbstractBattleEnemy *enemy = [sharedGameController.currentScene.activeEntities objectAtIndex:mods[i].y];
                            [enemy increaseAgilityModifierBy:(int)(mods[i].x)];
                            [enemy increaseDexterityModifierBy:(int)(mods[i].x)];
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
    
    if (active) {
        switch (stage) {
            case 0:
                [dimWorld render];
                break;
            case 1:
                [dimWorld render];
                [hailEmitter renderParticles];
                break;
            case 2:
                [dimWorld render];
                for (ParticleEmitter *pe in statEmitters) {
                    [pe renderParticles];
                }
                [hailEmitter renderParticles];
                break;
                
            default:
                break;
        }

    }
}

@end

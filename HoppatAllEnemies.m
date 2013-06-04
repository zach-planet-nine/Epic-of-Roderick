//
//  HoppatAllEnemies.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/7/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "HoppatAllEnemies.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleEnemy.h"
#import "BattleRanger.h"
#import "FadeInOrOut.h"
#import "ParticleEmitter.h"

@implementation HoppatAllEnemies

- (void)dealloc {
    
    if (dimWorld) {
        [dimWorld release];
    }
    if (frogEmitter) {
        [frogEmitter release];
    }
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        
        BattleRanger *ranger = [sharedGameController.battleCharacters objectForKey:@"BattleRanger"];
        int enemyIndex = 0;
        for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
            if ([enemy isKindOfClass:[AbstractBattleEnemy class]]) {
                damages[enemyIndex] = [ranger calculateHoppatDamageTo:enemy];
                enemyIndex++;
            }
        }
        dimWorld = [[FadeInOrOut alloc] initFadeOutToAlpha:0.3 withDuration:1.1];
        frogEmitter = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"FrogEmitter.pex"];
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
                    duration = 1;
                    break;
                case 1:
                    stage++;
                    int enemyIndex = 0;
                    for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
                        if ([enemy isKindOfClass:[AbstractBattleEnemy class]]) {
                            [enemy youTookDamage:damages[enemyIndex]];
                            if (enemy.isAlive) {
                                [enemy flashColor:Color4fMake(0, 1, 0, 1)];
                            }
                            enemyIndex++;
                        }
                    }
                    duration = 0.5;
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
                [dimWorld updateWithDelta:aDelta];
                break;
            case 1:
                [frogEmitter updateWithDelta:aDelta];
                break;
            default:
                break;
        }
    }
}

- (void) render {
    
    if (active) {
        if (stage < 2) {
            [dimWorld render];
        }
        if (stage == 1) {
            [frogEmitter renderParticles];
        }
    }
}

@end

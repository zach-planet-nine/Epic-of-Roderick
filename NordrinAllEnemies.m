//
//  NordrinAllEnemies.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/22/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "NordrinAllEnemies.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "BattleRoderick.h"
#import "AbstractBattleEnemy.h"
#import "ParticleEmitter.h"

@implementation NordrinAllEnemies

- (void)dealloc {
    
    if (nordrinEmitter) {
        [nordrinEmitter release];
    }
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        BattleRoderick *roderick = [sharedGameController.battleCharacters objectForKey:@"BattleRoderick"];
        int damageIndex = 0;
        for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
            if ([enemy isKindOfClass:[AbstractBattleEnemy class]]) {
                int tmpDamage = [roderick calculateNordrinDamageTo:enemy];
                tmpDamage = (int)((float)tmpDamage * 0.8);
                damage[damageIndex] = tmpDamage;
                damageIndex++;
            }
        }
        nordrinEmitter = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"NordrinEmitter.pex"];
        nordrinEmitter.sourcePosition = Vector2fMake(240, 360);
        nordrinEmitter.gravity = Vector2fMake(1500, 50
                                              );
        stage = 0;
        active = YES;
        duration = 2;
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
                    int damageIndex = 0;
                    for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
                        if ([enemy isKindOfClass:[AbstractBattleEnemy class]]) {
                            [enemy youTookDamage:damage[damageIndex]];
                            [enemy flashColor:Color4fMake(0, 0.2, 1, 1)];
                            damageIndex++;
                        }
                    }
                    duration = 1;
                    break;
                case 1:
                    stage++;
                    active = NO;
                    break;
                    
                default:
                    break;
            }
        }
        switch (stage) {
            case 0:
                [nordrinEmitter updateWithDelta:aDelta];
                break;
                
            default:
                break;
        }
    }
}

- (void)render {
    
    if (active && stage == 0) {
        [nordrinEmitter renderParticles];
    }
}

@end

//
//  ThurisazAllEnemies.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/6/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "ThurisazAllEnemies.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleEnemy.h"
#import "BattleRanger.h"
#import "ParticleEmitter.h"

@implementation ThurisazAllEnemies

- (id)init
{
    self = [super init];
    if (self) {
        
        BattleRanger *ranger = [sharedGameController.battleCharacters objectForKey:@"BattleRanger"];
        damage = [ranger calculateThurisazDamage];
        thornEmitter = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"ThornEmitter.pex"];
        thornEmitter.sourcePosition = Vector2fMake(-20, 720);
        Vector2f vector = Vector2fMake(360 - thornEmitter.sourcePosition.x, 160 - thornEmitter.sourcePosition.y);
        if (vector.x == 0) {
            vector.x = 1;
        }
        if (vector.y == 0) {
            vector.y = 1;
        }
        float angle = atanf((vector.y / vector.x)) * 57.2957795;
        if (angle < 0 && vector.x < 0) {
            angle += 180;
        } else if (angle < 0 && vector.y < 0) {
            angle += 360;
        } else if (vector.x < 0 && vector.y < 0) {
            angle += 180;
        }
        thornEmitter.angle = angle;
        stage = 0;
        duration = 0.4;
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
                    duration = 1.6;
                    break;
                case 1:
                    stage++;
                    thornEmitter.active = NO;
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
        if (stage == 1) {
            for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
                if ([enemy isKindOfClass:[AbstractBattleEnemy class]] && enemy.isAlive) {
                    if (RANDOM_0_TO_1() > 0.94) {
                        [enemy youTookDamage:(int)(((float)damage * RANDOM_0_TO_1()) + ((float)damage * RANDOM_0_TO_1()))];
                        [enemy flashColor:Color4fMake(0, 1, 0, 1)];
                    }
                }
            }

        }
        thornEmitter.sourcePosition = Vector2fMake(thornEmitter.sourcePosition.x, thornEmitter.sourcePosition.y - (aDelta * 500));
        Vector2f vector = Vector2fMake(360 - thornEmitter.sourcePosition.x, 160 - thornEmitter.sourcePosition.y);
        if (vector.x == 0) {
            vector.x = 1;
        }
        if (vector.y == 0) {
            vector.y = 1;
        }
        float angle = atanf((vector.y / vector.x)) * 57.2957795;
        if (angle < 0 && vector.x < 0) {
            angle += 180;
        } else if (angle < 0 && vector.y < 0) {
            angle += 360;
        } else if (vector.x < 0 && vector.y < 0) {
            angle += 180;
        }
        thornEmitter.angle = angle;
        [thornEmitter updateWithDelta:aDelta];
    }
}

- (void)render {
    
    if (active) {
        [thornEmitter renderParticles];
    }
}

@end

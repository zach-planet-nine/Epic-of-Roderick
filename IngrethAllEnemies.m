//
//  IngrethAllEnemies.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/10/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "IngrethAllEnemies.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleEnemy.h"
#import "BattlePriest.h"
#import "Projectile.h"
#import "FadeInOrOut.h"
#import "ParticleEmitter.h"

@implementation IngrethAllEnemies

- (void)dealloc {
    
    if (mjollnir) {
        [mjollnir release];
    }
    if (dimWorld) {
        [dimWorld release];
    }
    if (ingrethEmitter) {
        [ingrethEmitter release];
    }
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        
        BattlePriest *poet = [sharedGameController.battleCharacters objectForKey:@"BattlePriest"];
        int enemyIndex = 0;
        for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
            if ([enemy isKindOfClass:[AbstractBattleEnemy class]]) {
                damages[enemyIndex] = [poet calculateIngrethDamageTo:enemy];
                enemyIndex++;
            }
        }
        mjollnir = [[Projectile alloc] initProjectileFrom:Vector2fMake(160, 500) to:Vector2fMake(360, 140) withImage:@"Mjollnir.png" lasting:0.55 withStartAngle:325 withStartSize:Scale2fMake(0.6, 0.6) toFinishSize:Scale2fMake(1, 1) revolving:YES];
        dimWorld = [[FadeInOrOut alloc] initFadeOutToAlpha:0.3 withDuration:1.05];
        ingrethEmitter = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"IngrethEmitter.pex"];
        ingrethEmitter.sourcePosition = Vector2fMake(360, 160);
        ingrethEmitter.speed = 600;
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
                    duration = 0.5;
                    break;
                case 1:
                    stage++;
                    duration = 0.5;
                    break;
                case 2:
                    stage++;
                    int enemyIndex = 0;
                    for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
                        if ([enemy isKindOfClass:[AbstractBattleEnemy class]]) {
                            [enemy youTookDamage:damages[enemyIndex]];
                            if (enemy.isAlive) {
                                [enemy flashColor:Color4fMake(0.5, 0.5, 0, 1)];
                            }
                        }
                    }
                    duration = 1;
                    break;
                case 3:
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
                [mjollnir updateWithDelta:aDelta];
                break;
            case 2:
                [ingrethEmitter updateWithDelta:aDelta];
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
                [mjollnir renderProjectiles];
                break;
            case 2:
                [dimWorld render];
                [mjollnir renderProjectiles];
                [ingrethEmitter renderParticles];
                break;
                
            default:
                break;
        }
    }
}

@end

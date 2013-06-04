//
//  IsaSingleEnemy.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/19/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "IsaSingleEnemy.h"
#import "GameController.h"
#import "BattleRoderick.h"
#import "AbstractBattleEnemy.h"
#import "ParticleEmitter.h"

@implementation IsaSingleEnemy

- (void)dealloc {
    
    if (iceEmitter) {
        [iceEmitter release];
    }
    [super dealloc];
}

- (id)initToEnemy:(AbstractBattleEnemy *)aEnemy {
    
    self = [super init];
    if (self) {
        BattleRoderick *roderick = [sharedGameController.battleCharacters objectForKey:@"BattleRoderick"];
        damage = [roderick calculateIsaDamageTo:aEnemy];
        target1 = aEnemy;
        iceEmitter = [[ParticleEmitter alloc] initProjectileEmitterWithFile:@"IsaEmitter.pex" fromPoint:CGPointMake(240, 400) toPoint:target1.renderPoint];
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
                    duration = 0.2;
                    [target1 flashColor:Color4fMake(0, 0.3, 1, 1)];
                    break;
                case 1:
                    stage++;
                    duration = 0.2;
                    [target1 flashColor:Color4fMake(0, 0.3, 1, 1)];
                    break;
                case 2:
                    stage++;
                    duration = 0.2;
                    [target1 flashColor:Color4fMake(0, 0.3, 1, 1)];
                    [target1 youTookDamage:damage];
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
                [iceEmitter updateWithDelta:aDelta];
                break;
            case 1:
                [iceEmitter updateWithDelta:aDelta];
                break;
            case 2:
                [iceEmitter updateWithDelta:aDelta];
                break;
            case 3:
                [iceEmitter updateWithDelta:aDelta];
                break;
            default:
                break;
        }
    }
}

- (void)render {
    
    if (active) {
        [iceEmitter renderParticles];
    }
}

@end

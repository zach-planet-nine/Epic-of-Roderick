//
//  OthalaSingleEnemy.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/21/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "OthalaSingleEnemy.h"
#import "GameController.h"
#import "BattleRoderick.h"
#import "AbstractBattleEnemy.h"
#import "AbstractGameObject.h"
#import "ParticleEmitter.h"
#import "FadeInOrOut.h"

@implementation OthalaSingleEnemy

- (void)dealloc {
    
    if (othalaEmitter) {
        [othalaEmitter release];
    }
    [super dealloc];
}

- (id)initToEnemy:(AbstractBattleEnemy *)aEnemy
{
    self = [super init];
    if (self) {
        
        BattleRoderick *roderick = [sharedGameController.battleCharacters objectForKey:@"BattleRoderick"];
        damage = [roderick calculateOthalaDamageTo:aEnemy];
        target1 = aEnemy;
        othalaEmitter = [[ParticleEmitter alloc] initSinWaveEmitterWithFile:@"LightningSinWaveTest.pex" fromPoint:roderick.renderPoint toPoint:aEnemy.renderPoint];
        dimWorld = [[FadeInOrOut alloc] initFadeOutToAlpha:0.3 withDuration:1.5];
        stage = 0;
        active = YES;
        duration = 1.5;
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
                    duration = 2;
                    dimWorld.active = YES;
                    break;
                case 1:
                    stage++;
                    [target1 youTookDamage:damage];
                    [target1 flashColor:Color4fMake(0.8, 0.2, 0.2, 1)];
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
        switch (stage) {
            case 0:
                [dimWorld updateWithDelta:aDelta];
                break;
            case 1:
                [othalaEmitter updateWithDelta:aDelta];
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
                [othalaEmitter render];
                break;
                
            default:
                break;
        }
    }
}

@end

//
//  NordrinSingleEnemy.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/22/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "NordrinSingleEnemy.h"
#import "GameController.h"
#import "BattleRoderick.h"
#import "AbstractBattleEnemy.h"
#import "ParticleEmitter.h"

@implementation NordrinSingleEnemy

- (void)dealloc {
    
    if (nordrinEmitter) {
        [nordrinEmitter release];
    }
    [super dealloc];
}

- (id)initToEnemy:(AbstractBattleEnemy *)aEnemy 
{
    self = [super init];
    if (self) {
        
        BattleRoderick *roderick = [sharedGameController.battleCharacters objectForKey:@"BattleRoderick"];
        damage = [roderick calculateNordrinDamageTo:aEnemy];
        target1 = aEnemy;
        nordrinEmitter = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"NordrinEmitter.pex"];
        nordrinEmitter.sourcePosition = Vector2fMake(aEnemy.renderPoint.x, aEnemy.renderPoint.y + 100);
        nordrinEmitter.stoppingPlane = Vector2fMake(480, aEnemy.renderPoint.y - 30);
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
                    [target1 flashColor:Color4fMake(0, 0.2, 1, 1)];
                    [target1 youTookDamage:damage];
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
                nordrinEmitter.stoppingPlane = Vector2fMake(480, nordrinEmitter.stoppingPlane.y + (aDelta * 20));
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

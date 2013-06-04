//
//  DaleythSingleEnemy.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/29/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "DaleythSingleEnemy.h"
#import "GameController.h"
#import "AbstractBattleEnemy.h"
#import "BattleWizard.h"
#import "ParticleEmitter.h"

@implementation DaleythSingleEnemy

- (void)dealloc {
    
    if (appearingEmitter) {
        [appearingEmitter release];
    }
    
}

- (id)initToEnemy:(AbstractBattleEnemy *)aEnemy
{
    self = [super init];
    if (self) {
        
        BattleWizard *wizard = [sharedGameController.battleCharacters objectForKey:@"BattleWizard"];
        target1 = aEnemy;
        damage = [wizard calculateDaleythDamageTo:aEnemy];
        appearingEmitter = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"AppearingEmitter.pex"];
        appearingEmitter.sourcePosition = Vector2fMake(aEnemy.renderPoint.x, aEnemy.renderPoint.y - 20);
        emitterDirection = 1;
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
                    [target1 flashColor:Color4fMake(1, 0, 1, 1)];
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
        if (stage == 0) {
            appearingEmitter.sourcePosition = Vector2fMake(appearingEmitter.sourcePosition.x + (aDelta * 20 * emitterDirection), appearingEmitter.sourcePosition.y);
            if (appearingEmitter.sourcePosition.x > target1.renderPoint.x + 10 || appearingEmitter.sourcePosition.x < target1.renderPoint.x - 10) {
                emitterDirection *= -1;
            }
            [appearingEmitter updateWithDelta:aDelta];
        }
    }
}

- (void)render {
    
    if (active && stage == 0) {
        [appearingEmitter renderParticles];
    }
}

@end

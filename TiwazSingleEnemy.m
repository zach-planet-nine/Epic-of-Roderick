//
//  TiwazSingleEnemy.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/28/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "TiwazSingleEnemy.h"
#import "GameController.h"
#import "AbstractBattleEnemy.h"
#import "BattleWizard.h"
#import "ParticleEmitter.h"

@implementation TiwazSingleEnemy

- (void)dealloc {
    
    if (comet) {
        [comet release];
    }
    if (explosion) {
        [explosion release];
    }
    [super dealloc];
}

- (id)initToEnemy:(AbstractBattleEnemy *)aEnemy
{
    self = [super init];
    if (self) {
        
        BattleWizard *wizard = [sharedGameController.battleCharacters objectForKey:@"BattleWizard"];
        target1 = aEnemy;
        damage = [wizard calculateTiwazDamageTo:aEnemy];
        comet = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"Comet.pex"];
        velocity = Vector2fMake((aEnemy.renderPoint.x + 40) / 1.3, ((aEnemy.renderPoint.y - 20) - 360)  / 1.3);
        comet.sourcePosition = Vector2fMake(-40, 360);
        explosion = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"Explosion.pex"];
        stage = 0;
        duration = 1.3;
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
                    explosion.sourcePosition = comet.sourcePosition;
                    [target1 youTookDamage:damage];
                    [target1 flashColor:Color4fMake(1, 0, 0, 1)];
                    duration = 0.3;
                    break;
                case 1:
                    stage++;
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
                comet.sourcePosition = Vector2fMake(comet.sourcePosition.x + (velocity.x * aDelta), comet.sourcePosition.y + (velocity.y * aDelta));
                [comet updateWithDelta:aDelta];
                break;
            case 1:
                [explosion updateWithDelta:aDelta];
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
                [comet renderParticles];
                break;
            case 1:
                [explosion renderParticles];
                break;
                
            default:
                break;
        }
    }
}

@end

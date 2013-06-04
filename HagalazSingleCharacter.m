//
//  HagalazSingleCharacter.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/24/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "HagalazSingleCharacter.h"
#import "GameController.h"
#import "AbstractBattleCharacter.h"
#import "BattleValkyrie.h"
#import "ParticleEmitter.h"


@implementation HagalazSingleCharacter

- (void)dealloc {
    
    if (rageEmitter) {
        [rageEmitter release];
    }
    if (statRaisedEmitter) {
        [statRaisedEmitter release];
    }
    [super dealloc];
}

- (id)initToCharacter:(AbstractBattleCharacter *)aCharacter
{
    self = [super init];
    if (self) {
        
        BattleValkyrie *valk = [sharedGameController.battleCharacters objectForKey:@"BattleValkyrie"];
        target1 = aCharacter;
        hagalazDuration = [valk calculateHagalazDurationToCharacter:aCharacter];
        float effect = (valk.rageMeter / 10) + ((valk.waterAffinity + aCharacter.waterAffinity) / 2);
        mod = (int)effect;
        [aCharacter increasePowerModifierBy:mod];
        rageEmitter = [[ParticleEmitter alloc] initProjectileEmitterWithFile:@"RageEmitter.pex" fromPoint:valk.renderPoint toPoint:aCharacter.renderPoint];
        rageEmitter.maxParticles = MAX(10, valk.rageMeter);
        valk.rageMeter -= MAX(10, (60 - valk.waterAffinity));
        statRaisedEmitter = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"PowerIncreasedEmitterTextureNotEmbedded.pex"];
        statRaisedEmitter.sourcePosition = Vector2fMake(aCharacter.renderPoint.x, aCharacter.renderPoint.y - 30);
        statRaisedEmitter.startColor = Color4fMake(1, 0, 0, 1);
        statRaisedEmitter.finishColor = Color4fMake(1, 0, 0, 0);
        stage = 0;
        duration = 0.6;
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
                    duration = hagalazDuration;
                    break;
                case 2:
                    stage++;
                    [target1 decreasePowerModifierBy:mod];
                    active = NO;
                    break;
                default:
                    break;
            }
        }
        switch (stage) {
            case 0:
                [rageEmitter updateWithDelta:aDelta];
                break;
            case 1:
                [rageEmitter updateWithDelta:aDelta];
                [statRaisedEmitter updateWithDelta:aDelta];
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
                [rageEmitter renderParticles];
                break;
            case 1:
                [rageEmitter renderParticles];
                [statRaisedEmitter renderParticles];
                break;
                
            default:
                break;
        }
    }
}

@end

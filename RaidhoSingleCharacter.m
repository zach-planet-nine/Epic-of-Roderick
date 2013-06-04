//
//  RaidhoSingleCharacter.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/27/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "RaidhoSingleCharacter.h"
#import "GameController.h"
#import "AbstractBattleCharacter.h"
#import "BattleWizard.h"
#import "ParticleEmitter.h"
#import "BattleStringAnimation.h"

@implementation RaidhoSingleCharacter

- (void)dealloc {
    
    if (ghostEmitter) {
        [ghostEmitter release];
    }
    [super dealloc];
}

- (id)initToCharacter:(AbstractBattleCharacter *)aCharacter
{
    self = [super init];
    if (self) {
        
        BattleWizard *wizard = [sharedGameController.battleCharacters objectForKey:@"BattleWizard"];
        if (wizard.rageAffinity * (wizard.essence / wizard.maxEssence) > 5) {
            ghostEmitter = [[ParticleEmitter alloc] initProjectileEmitterWithFile:@"GhostEmitter.pex" fromPoint:aCharacter.renderPoint toPoint:aCharacter.renderPoint];
            [aCharacter gainDoubleEffect];
            stage = 0;
            duration = 50;
            active = YES;
        } else {
            
            [BattleStringAnimation makeIneffectiveStringAt:aCharacter.renderPoint];
            stage = 4;
            active = NO;
        }
    }
    
    return self;
}

- (void)updateWithDelta:(float)aDelta {
    
    if (active) {
        if (stage > 0) {
            duration -= aDelta;
            if (duration < 0) {
                switch (stage) {
                    case 1:
                        stage++;
                        active = NO;
                        break;
                        
                    default:
                        break;
                }
            }
        }
        [ghostEmitter updateWithDelta:aDelta];
    }
}

- (void)render {
    
    if (active && stage < 2) {
        [ghostEmitter renderParticles];
    }
}

- (void)enhanceEffectTo:(AbstractBattleEntity *)aEntity {
    
    ghostEmitter.destination = CGPointMake(aEntity.renderPoint.x, aEntity.renderPoint.y);
    stage = 1;
    duration = 0.5;
    
}

@end

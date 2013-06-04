//
//  FyrazAllCharacters.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/29/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "FyrazAllCharacters.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleCharacter.h"
#import "BattleWizard.h"
#import "ParticleEmitter.h"


@implementation FyrazAllCharacters

- (void)dealloc {
    
    if (character1Emitter) {
        [character1Emitter release];
    }
    if (character2Emitter) {
        [character2Emitter release];
    }
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        
        BattleWizard *wizard = [sharedGameController.battleCharacters objectForKey:@"BattleWizard"];
        essenceGiven = [wizard calculateFyrazEssenceGiven];
        for (AbstractBattleCharacter *character in sharedGameController.currentScene.activeEntities) {
            if ([character isKindOfClass:[AbstractBattleCharacter class]] && character.isAlive && character != wizard) {
                if (character1Emitter) {
                    character2Emitter = [[ParticleEmitter alloc] initProjectileEmitterWithFile:@"EssenceEmitter.pex" fromPoint:wizard.renderPoint toPoint:character.renderPoint];
                    character2Emitter.startColor = wizard.essenceColor;
                    character2Emitter.finishColor = character.essenceColor;
                    character2Emitter.maxParticles *= 0.5;
                    target2 = character;
                } else {
                    character1Emitter = [[ParticleEmitter alloc] initProjectileEmitterWithFile:@"EssenceEmitter.pex" fromPoint:wizard.renderPoint toPoint:character.renderPoint];
                    character1Emitter.startColor = wizard.essenceColor;
                    character1Emitter.finishColor = character.essenceColor;
                    character1Emitter.maxParticles *= 0.5;
                    target1 = character;
                }
            }
        }
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
            if (character1Emitter && target1.isAlive) {
                [character1Emitter updateWithDelta:aDelta];
                target1.essence += (essenceGiven * aDelta);
            }
            if (character2Emitter && target2.isAlive) {
                [character2Emitter updateWithDelta:aDelta];
                target2.essence += (essenceGiven * aDelta);
            }
        }
    }
}

- (void)render {
    
    if (active && stage == 0) {
        if (character1Emitter && target1.isAlive) {
            [character1Emitter renderParticles];
        }
        if (character2Emitter && target2.isAlive) {
            [character2Emitter renderParticles];
        }
    }
}

@end

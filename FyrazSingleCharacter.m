//
//  FyrazSingleCharacter.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/29/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "FyrazSingleCharacter.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleCharacter.h"
#import "BattleWizard.h"
#import "ParticleEmitter.h"
#import "BattleStringAnimation.h"

@implementation FyrazSingleCharacter

- (void)dealloc {
    
    if (smokeEmitter) {
        [smokeEmitter release];
    }
    [super dealloc];
}

- (id)initToCharacter:(AbstractBattleCharacter *)aCharacter
{
    self = [super init];
    if (self) {
        
        BattleWizard *wizard = [sharedGameController.battleCharacters objectForKey:@"BattleWizard"];
        target1 = aCharacter;
        if (wizard.essence > 5) {
            smokeEmitter = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"SmokeEmitter.pex"];
            smokeEmitter.sourcePosition = Vector2fMake(aCharacter.renderPoint.x, aCharacter.renderPoint.y);
            stage = 0;
            duration = 1;
            active = YES;
        } else {
            [wizard youWereDrauraed:10];
            [wizard youWereFatigued:10];
            [wizard youWereDisoriented:10];
            [wizard youWereHexed:10];
            [wizard youWereSlothed:10];
            stage = 4;
            active = NO;
        }
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
                     target1.isDrauraed = target1.isFatigued = target1.isDisoriented = target1.isHexed = target1.isSlothed = NO;
                    BattleStringAnimation *healed = [[BattleStringAnimation alloc] initStatusString:@"Healed!" from:target1.renderPoint];
                    [sharedGameController.currentScene addObjectToActiveObjects:healed];
                    [healed release];
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
            [smokeEmitter updateWithDelta:aDelta];
        }
    }
}

- (void)render {
    
    if (active && stage == 0) {
        [smokeEmitter renderParticles];
    }
}

@end

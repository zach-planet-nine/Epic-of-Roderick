//
//  TiwazSingleCharacter.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/28/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "TiwazSingleCharacter.h"
#import "GameController.h"
#import "AbstractBattleCharacter.h"
#import "BattleWizard.h"
#import "ParticleEmitter.h"

@implementation TiwazSingleCharacter

- (void)dealloc {
    
    if (comet) {
        [comet release];
    }
    [super dealloc];
}

- (id)initToCharacter:(AbstractBattleCharacter *)aCharacter
{
    self = [super init];
    if (self) {
        
        BattleWizard *wizard = [sharedGameController.battleCharacters objectForKey:@"BattleWizard"];
        target1 = aCharacter;
        tiwazDuration = [wizard calculateTiwazDurationTo:aCharacter];
        [aCharacter youWillNotLoseEndurance];
        comet = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"Comet.pex"];
        comet.sourcePosition = Vector2fMake(aCharacter.renderPoint.x - 20, aCharacter.renderPoint.y + 30);
        cometDirection = -1;
        stage = 0;
        duration = tiwazDuration;
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
                    [target1 youWillLoseEndurance];
                    duration = 1;
                    break;
                case 1:
                    stage++;
                    active = NO;
                    
                default:
                    break;
            }
        }
        if (stage == 0) {
            comet.sourcePosition = Vector2fMake(comet.sourcePosition.x, comet.sourcePosition.y + (aDelta * 60 * cometDirection));
            if (comet.sourcePosition.y < target1.renderPoint.y - 30 || comet.sourcePosition.y > target1.renderPoint.y + 30) {
                cometDirection *= -1;
            }
            [comet updateWithDelta:aDelta];
        }
    }
}

- (void)render {
    
    if (active && stage == 0) {
        [comet renderParticles];
    }
}

@end

//
//  TiwazAllCharacters.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/28/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "TiwazAllCharacters.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleCharacter.h"
#import "BattleWizard.h"
#import "ParticleEmitter.h"

@implementation TiwazAllCharacters

- (void)dealloc {
    
    if (comet) {
        [comet release];
    }
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        
        BattleWizard *wizard = [sharedGameController.battleCharacters objectForKey:@"BattleWizard"];
        tiwazDuration = 0;
        for (AbstractBattleCharacter *character in sharedGameController.currentScene.activeEntities) {
            if ([character isKindOfClass:[AbstractBattleCharacter class]] && character.isAlive) {
                tiwazDuration = MAX(tiwazDuration, [wizard calculateTiwazDurationTo:character]);
                [character youWillLoseHalfEndurance];
            }
        }
        comet = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"Comet.pex"];
        comet.maxParticles = (int)((float)(comet.maxParticles) * 0.6);
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
                    for (AbstractBattleCharacter *character in sharedGameController.currentScene.activeEntities) {
                        if ([character isKindOfClass:[AbstractBattleCharacter class]] && character.isAlive) {
                            [character youWillNotLoseHalfEndurance];
                        }
                    }
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
            yMod += (aDelta * 60 * cometDirection);
            if (yMod > 30 || yMod < 30) {
                cometDirection *= -1;
            }
            for (AbstractBattleCharacter *character in sharedGameController.currentScene.activeEntities) {
                if ([character isKindOfClass:[AbstractBattleCharacter class]] && character.isAlive) {
                    comet.sourcePosition = Vector2fMake(character.renderPoint.x - 20, character.renderPoint.y + yMod);
                    [comet updateWithDelta:aDelta];
                }
            }
        }
    }
}

- (void)render {
    
    if (active && stage == 0) {
        [comet renderParticles];
    }
}

@end

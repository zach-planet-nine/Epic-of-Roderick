//
//  EkwazSingleCharacter.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/30/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "EkwazSingleCharacter.h"
#import "GameController.h"
#import "AbstractBattleCharacter.h"
#import "BattleWizard.h"
#import "ParticleEmitter.h"

@implementation EkwazSingleCharacter

- (void)dealloc {
    
    if (statRaisedEmitter) {
        [statRaisedEmitter release];
    }
    [super dealloc];
}

- (id)initToCharacter:(AbstractBattleCharacter *)aCharacter
{
    self = [super init];
    if (self) {
        
        BattleWizard *wizard = [sharedGameController.battleCharacters objectForKey:@"BattleWizard"];
        target1 = aCharacter;
        modDuration = [wizard calculateEkwazDurationTo:aCharacter];
        mod = (int)(((wizard.affinity + wizard.affinityModifier + wizard.stoneAffinity + aCharacter.stoneAffinity) / 10) * (wizard.essence / wizard.maxEssence));
        [aCharacter increaseStaminaModifierBy:mod];
        statRaisedEmitter = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"PowerIncreasedEmitterTextureNotEmbedded.pex"];
        statRaisedEmitter.sourcePosition = Vector2fMake(aCharacter.renderPoint.x, aCharacter.renderPoint.y - 30);
        statRaisedEmitter.startColor = Color4fMake(0.2, 1, 0, 1);
        statRaisedEmitter.startColorVariance = Color4fMake(0.2, 0, 0, 0);
        statRaisedEmitter.finishColor = Color4fMake(0.2, 1, 0, 0);
        statRaisedEmitter.finishColorVariance = Color4fMake(0, 0, 0, 0);
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
                    duration = modDuration;
                    break;
                case 1:
                    stage++;
                    [target1 decreaseStaminaModifierBy:mod];
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
        if (stage == 0) {
            [statRaisedEmitter updateWithDelta:aDelta];
        }
    }
}

- (void)render {
    
    if (active && stage == 0) {
        [statRaisedEmitter renderParticles];
    }
}

@end

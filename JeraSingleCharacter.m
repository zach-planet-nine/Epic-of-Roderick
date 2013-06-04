//
//  JeraSingleCharacter.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/24/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "JeraSingleCharacter.h"
#import "GameController.h"
#import "AbstractBattleCharacter.h"
#import "BattleValkyrie.h"
#import "ParticleEmitter.h"

@implementation JeraSingleCharacter

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
        
        BattleValkyrie *valk = [sharedGameController.battleCharacters objectForKey:@"BattleValkyrie"];
        target1 = aCharacter;
        jeraDuration = [valk calculateJeraDurationTo:aCharacter];
        float tempMod = ((valk.affinity + valk.affinityModifier + valk.rageAffinity + valk.level + valk.levelModifier) / 10);
        mod = (int)tempMod;
        [aCharacter increaseLevelModifierBy:mod];
        statRaisedEmitter = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"PowerIncreasedEmitterTextureNotEmbedded.pex"];
        statRaisedEmitter.sourcePosition = Vector2fMake(aCharacter.renderPoint.x, aCharacter.renderPoint.y - 30);
        statRaisedEmitter.startColor = Color4fMake(1, 1, 1, 1);
        statRaisedEmitter.finishColor = Color4fMake(1, 1, 1, 0);
        stage = 0;
        duration = 1.2;
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
                    duration = jeraDuration;
                    break;
                case 1:
                    stage++;
                    [target1 decreaseLevelModifierBy:mod];
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

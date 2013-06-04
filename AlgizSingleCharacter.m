//
//  AlgizSingleCharacter.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/7/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "AlgizSingleCharacter.h"
#import "GameController.h"
#import "AbstractBattleCharacter.h"
#import "BattleRanger.h"
#import "ParticleEmitter.h"
#import "BattleStringAnimation.h"

@implementation AlgizSingleCharacter

- (void)dealloc {
    
    if (butterflyEmitter) {
        [butterflyEmitter release];
    }
    [super dealloc];
}

- (id)initToCharacter:(AbstractBattleCharacter *)aCharacter
{
    self = [super init];
    if (self) {
        
        BattleRanger *ranger = [sharedGameController.battleCharacters objectForKey:@"BattleRanger"];
        target1 = aCharacter;
        if (ranger.essence > 5 && (aCharacter.isFatigued || aCharacter.isDrauraed)) {
            butterflyEmitter = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"ButterflyEmitter.pex"];
            butterflyEmitter.sourcePosition = Vector2fMake(aCharacter.renderPoint.x, aCharacter.renderPoint.y);
            stage = 0;
            duration = 1.5;
            active = YES;
        } else {
            [BattleStringAnimation makeIneffectiveStringAt:aCharacter.renderPoint];
            stage = 2;
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
                    target1.isDrauraed = NO;
                    target1.isFatigued = NO;
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
        [butterflyEmitter updateWithDelta:aDelta];
    }
}

- (void)render {
    
    if (active && stage == 0) {
        [butterflyEmitter renderParticles];
    }
}

@end

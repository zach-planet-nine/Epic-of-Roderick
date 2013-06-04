//
//  GeboSingleCharacter.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/8/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "GeboSingleCharacter.h"
#import "GameController.h"
#import "AbstractBattleCharacter.h"
#import "BattlePriest.h"
#import "ParticleEmitter.h"
#import "BattleStringAnimation.h"

@implementation GeboSingleCharacter

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
        
        BattlePriest *poet = [sharedGameController.battleCharacters objectForKey:@"BattlePriest"];
        target1 = aCharacter;
        if (poet.essence > 25 && aCharacter.isAlive) {
            statRaisedEmitter = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"PowerIncreasedEmitterTextureNotEmbedded.pex"];
            statRaisedEmitter.sourcePosition = Vector2fMake(aCharacter.renderPoint.x, aCharacter.renderPoint.y - 30);
            statRaisedEmitter.startColor = statRaisedEmitter.finishColor = aCharacter.essenceColor;
            statRaisedEmitter.finishColor = Color4fMake(statRaisedEmitter.finishColor.red, statRaisedEmitter.finishColor.green, statRaisedEmitter.finishColor.blue, 0);
            stage = 0;
            duration = 1;
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
                    [target1 unlockGeboPotential];
                    duration = 0.5;
                    break;
                case 1:
                    stage++;
                    active = NO;
                    break;
                    
                default:
                    break;
            }
        }
        [statRaisedEmitter updateWithDelta:aDelta];
    }
}

- (void)render {
    
    if (active) {
        [statRaisedEmitter renderParticles];
    }
}

@end

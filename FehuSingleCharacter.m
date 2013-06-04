//
//  FehuSingleCharacter.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/6/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "FehuSingleCharacter.h"
#import "GameController.h"
#import "AbstractBattleCharacter.h"
#import "BattleRanger.h"
#import "ParticleEmitter.h"

@implementation FehuSingleCharacter

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
        
        BattleRanger *ranger = [sharedGameController.battleCharacters objectForKey:@"Battleranger"];
        mod = (int)(1 + ((ranger.level + ranger.levelModifier + ranger.skyAffinity + aCharacter.skyAffinity) / 10) * (ranger.essence / ranger.maxEssence));
        target1 = aCharacter;
        [aCharacter increaseLuckModifierBy:mod];
        modDuration = ((ranger.level + ranger.levelModifier + ranger.affinity + ranger.affinityModifier + ranger.lifeAffinity) / 5) * (ranger.essence / ranger.maxEssence);
        statRaisedEmitter = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"PowerIncreasedEmitterTextureNotEmbedded.pex"];
        statRaisedEmitter.sourcePosition = Vector2fMake(aCharacter.renderPoint.x, aCharacter.renderPoint.y - 30);
        statRaisedEmitter.startColor = Color4fMake(1, 1, 0, 1);
        statRaisedEmitter.finishColor = Color4fMake(1, 1, 0, 0);
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
                    [target1 decreaseLuckModifierBy:mod];
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
        switch (stage) {
            case 0:
                [statRaisedEmitter updateWithDelta:aDelta];
                break;
                
            default:
                break;
        }
    }
}

- (void)render {
    
    if (active && stage == 0) {
        [statRaisedEmitter renderParticles];
    }
}

@end

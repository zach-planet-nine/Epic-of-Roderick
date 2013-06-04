//
//  UruzSingleCharacter.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/6/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "UruzSingleCharacter.h"
#import "GameController.h"
#import "AbstractBattleCharacter.h"
#import "BattleRanger.h"
#import "ParticleEmitter.h"

@implementation UruzSingleCharacter

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
        
        BattleRanger *ranger = [sharedGameController.battleCharacters objectForKey:@"BattleRanger"];
        mod = (int)(1 + ((ranger.level + ranger.levelModifier + ranger.stoneAffinity + aCharacter.stoneAffinity) / 10) * (ranger.essence / ranger.maxEssence));
        //NSLog(@"mod is: %d", mod);
        target1 = aCharacter;
        [aCharacter increaseStrengthModifierBy:mod];
        modDuration = [ranger calculateUruzDurationTo:aCharacter];
        statRaisedEmitter = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"PowerIncreasedEmitterTextureNotEmbedded.pex"];
        statRaisedEmitter.sourcePosition = Vector2fMake(aCharacter.renderPoint.x, aCharacter.renderPoint.y - 30);
        statRaisedEmitter.startColor = Color4fMake(0.5, 0, 0, 1);
        statRaisedEmitter.finishColor = Color4fMake(0.5, 0, 0, 0);
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
                    [target1 decreaseStrengthModifierBy:mod];
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

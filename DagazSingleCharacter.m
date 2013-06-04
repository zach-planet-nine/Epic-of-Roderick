//
//  DagazSingleCharacter.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/9/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "DagazSingleCharacter.h"
#import "GameController.h"
#import "AbstractBattleCharacter.h"
#import "BattlePriest.h"
#import "ParticleEmitter.h"

@implementation DagazSingleCharacter

- (void)dealloc {
    
    if (auraEmitter) {
        [auraEmitter release];
    }
    [super dealloc];
}

- (id)initToCharacter:(AbstractBattleCharacter *)aCharacter
{
    self = [super init];
    if (self) {
        
        BattlePriest *poet = [sharedGameController.battleCharacters objectForKey:@"BattlePriest"];
        target1 = aCharacter;
        auraRoll = [poet calculateDagazAuraRollTo:aCharacter];
        auraEmitter = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"AuraEmitter.pex"];
        auraEmitter.sourcePosition = Vector2fMake(aCharacter.renderPoint.x, aCharacter.renderPoint.y);
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
                    [target1 youWereAuraed:auraRoll];
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
            [auraEmitter updateWithDelta:aDelta];
        }
    }
}

- (void)render {
    
    if (active && stage == 0) {
        [auraEmitter renderParticles];
    }
}

@end

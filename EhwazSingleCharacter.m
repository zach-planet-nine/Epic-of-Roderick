//
//  EhwazSingleCharacter.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/8/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "EhwazSingleCharacter.h"
#import "GameController.h"
#import "AbstractBattleCharacter.h"
#import "BattlePriest.h"
#import "ParticleEmitter.h"

@implementation EhwazSingleCharacter

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
        ehwazDuration = [poet calculateEhwazDurationTo:aCharacter];
        float tempMod = ((poet.affinity + poet.affinityModifier + poet.rageAffinity + poet.level + poet.levelModifier) / 10);
        mod = (int)tempMod;
        [aCharacter increaseAgilityModifierBy:mod];
        [aCharacter increaseDexterityModifierBy:mod];
        statRaisedEmitter = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"PowerIncreasedEmitterTextureNotEmbedded.pex"];
        statRaisedEmitter.sourcePosition = Vector2fMake(aCharacter.renderPoint.x, aCharacter.renderPoint.y - 30);
        statRaisedEmitter.startColor = Color4fMake(0, 0.7, 0.2, 1);
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
                    duration = ehwazDuration;
                    break;
                case 1:
                    stage++;
                    [target1 decreaseAgilityModifierBy:mod];
                    [target1 decreaseDexterityModifierBy:mod];
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
            if (statRaisedEmitter.startColor.green == 0.7) {
                statRaisedEmitter.startColor = Color4fMake(0, 0.2, 0.7, 1);
            } else {
                statRaisedEmitter.startColor = Color4fMake(0, 0.7, 0.2, 1);
            }
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

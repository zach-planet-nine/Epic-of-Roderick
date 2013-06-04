//
//  SudrinSingleCharacter.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/22/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "SudrinSingleCharacter.h"
#import "GameController.h"
#import "AbstractBattleCharacter.h"
#import "BattleRoderick.h"
#import "ParticleEmitter.h"

@implementation SudrinSingleCharacter

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

        BattleRoderick *roderick = [sharedGameController.battleCharacters objectForKey:@"BattleRoderick"];
        mod = (int)(1 + ((roderick.level + roderick.levelModifier + roderick.skyAffinity + aCharacter.skyAffinity) / 10) * (roderick.essence / roderick.maxEssence));
        //NSLog(@"Mod is: %d", mod);
        target1 = aCharacter;
        [aCharacter increaseStrengthModifierBy:mod];
        [aCharacter increaseStaminaModifierBy:mod];
        [aCharacter increaseAgilityModifierBy:mod];
        [aCharacter increaseDexterityModifierBy:mod];
        [aCharacter increasePowerModifierBy:mod];
        [aCharacter increaseAffinityModifierBy:mod];
        [aCharacter increaseLuckModifierBy:mod];
        modDuration = ((roderick.level + roderick.levelModifier + roderick.power + roderick.powerModifier + roderick.skyAffinity) / 5) * (roderick.essence / roderick.maxEssence) - 2;
        statRaisedEmitter = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"PowerIncreasedEmitterTextureNotEmbedded.pex"];
        statRaisedEmitter.sourcePosition = Vector2fMake(aCharacter.renderPoint.x, aCharacter.renderPoint.y - 30);
        statRaisedEmitter.startColor = Color4fMake(1, 1, 1, 1);
        statRaisedEmitter.startColorVariance = Color4fMake(1, 1, 1, 0);
        statRaisedEmitter.finishColor = Color4fMake(1, 1, 1, 0);
        statRaisedEmitter.finishColorVariance = Color4fMake(1, 1, 1, 0);
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
                    [target1 decreaseStaminaModifierBy:mod];
                    [target1 decreaseDexterityModifierBy:mod];
                    [target1 decreaseAgilityModifierBy:mod];
                    [target1 decreasePowerModifierBy:mod];
                    [target1 decreaseAffinityModifierBy:mod];
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

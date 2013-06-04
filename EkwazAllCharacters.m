//
//  EkwazAllCharacters.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/30/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "EkwazAllCharacters.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleCharacter.h"
#import "BattleWizard.h"
#import "ParticleEmitter.h"

@implementation EkwazAllCharacters

- (void)dealloc {
    
    if (statRaisedEmitters) {
        [statRaisedEmitters release];
    }
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        
        BattleWizard *wizard = [sharedGameController.battleCharacters objectForKey:@"BattleWizard"];
        statRaisedEmitters = [[NSMutableArray alloc] init];
        int characterIndex = 0;
        for (AbstractBattleCharacter *character in sharedGameController.currentScene.activeEntities) {
            if ([character isKindOfClass:[AbstractBattleCharacter class]]) {
                modDurations[characterIndex] = ([wizard calculateEkwazDurationTo:character] * 0.7);
                mods[characterIndex] = CGPointMake((((wizard.affinity + wizard.affinityModifier + wizard.stoneAffinity + character.stoneAffinity) / 10) * (wizard.essence / wizard.maxEssence) * 0.64), [sharedGameController.currentScene.activeEntities indexOfObject:character]);
                [character increaseStaminaModifierBy:(int)(mods[characterIndex].x)];
                if (character.isAlive) {
                    ParticleEmitter *statEmitter = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"PowerIncreasedEmitterTextureNotEmbedded.pex"];
                    statEmitter.sourcePosition = Vector2fMake(character.renderPoint.x, character.renderPoint.y - 30);
                    statEmitter.startColor = Color4fMake(0.2, 1, 0, 1);
                    statEmitter.startColorVariance = Color4fMake(0.2, 0, 0, 0);
                    statEmitter.finishColor = Color4fMake(0.2, 1, 0, 0);
                    statEmitter.finishColorVariance = Color4fMake(0, 0, 0, 0);
                    [statRaisedEmitters addObject:statEmitter];
                    [statEmitter release];
                }
                characterIndex++;
            }
        }
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
                    duration = MAX(modDurations[0], modDurations[1]);
                    duration = MAX(modDurations[2], duration);
                    duration += 1;
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
            for (ParticleEmitter *pe in statRaisedEmitters) {
                [pe updateWithDelta:aDelta];
            }
        }
        if (stage == 1) {
            for (int i = 0; i < 3; i++) {
                if (modDurations[i] > 0) {
                    modDurations[i] -= aDelta;
                    if (modDurations[i] <= 0) {
                        AbstractBattleCharacter *character = [sharedGameController.currentScene.activeEntities objectAtIndex:mods[i].y];
                        [character decreaseStaminaModifierBy:(int)(mods[i].x)];
                    }
                }
            }
        }
    }
}

- (void)render {
    
    if (active && stage == 0) {
        for (ParticleEmitter *pe in statRaisedEmitters) {
            [pe renderParticles];
        }
    }
}

@end

//
//  JeraAllCharacters.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/24/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "JeraAllCharacters.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleCharacter.h"
#import "BattleValkyrie.h"
#import "ParticleEmitter.h"

@implementation JeraAllCharacters

- (void)dealloc {
    
    if (statEmitters) {
        [statEmitters release];
    }
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        
        BattleValkyrie *valk = [sharedGameController.battleCharacters objectForKey:@"BattleValkyrie"];
        statEmitters = [[NSMutableArray alloc] init];
        int characterIndex = 0;
        for (AbstractBattleCharacter *character in sharedGameController.currentScene.activeEntities) {
            if ([character isKindOfClass:[AbstractBattleCharacter class]]) {
                durations[characterIndex] = ([valk calculateJeraDurationTo:character] * 0.7);
                float tempMod = ((valk.affinity + valk.affinityModifier + valk.rageAffinity + valk.level + valk.levelModifier) / 10) * 0.7;
                [character increaseLevelModifierBy:(int)tempMod];
                mods[characterIndex] = CGPointMake((int)tempMod, [sharedGameController.currentScene.activeEntities indexOfObject:character]);
                characterIndex++;
                if (character.isAlive) {
                    ParticleEmitter *pe = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"PowerIncreasedEmitterTextureNotEmbedded.pex"];
                    pe.startColor = Color4fOnes;
                    pe.finishColor = Color4fMake(1, 1, 1, 0);
                    pe.sourcePosition = Vector2fMake(character.renderPoint.x, character.renderPoint.y - 30);
                    [statEmitters addObject:pe];
                    [pe release];
                }
            }
        }
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
                    duration = MAX(durations[0], durations[1]);
                    duration = MAX(duration, durations[2]);
                    duration += 1;
                    break;
                case 1:
                    stage++;
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
                for (ParticleEmitter *pe in statEmitters) {
                    [pe updateWithDelta:aDelta];
                }
                break;
            case 1:
                for (int i = 0; i < 3; i++) {
                    if (durations[i] > 0) {
                        durations[i] -= aDelta;
                        if (durations[i] <= 0) {
                            AbstractBattleCharacter *character = [sharedGameController.currentScene.activeEntities objectAtIndex:mods[i].y];
                            [character increaseLevelModifierBy:mods[i].x];
                        }
                    }
                }
                break;
                
            default:
                break;
        }
    }
}

- (void)render {
    
    if (active && stage == 0) {
        for (ParticleEmitter *pe in statEmitters) {
            [pe renderParticles];
        }
    }
}

@end

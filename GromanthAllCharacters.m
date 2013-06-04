//
//  GromanthAllCharacters.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/22/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "GromanthAllCharacters.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleCharacter.h"
#import "BattleRoderick.h"
#import "ParticleEmitter.h"

@implementation GromanthAllCharacters

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
        BattleRoderick *roderick = [sharedGameController.battleCharacters objectForKey:@"BattleRoderick"];
        statEmitters = [[NSMutableArray alloc] init];
        int timerIndex = 0;
        for (AbstractBattleCharacter *character in sharedGameController.currentScene.activeEntities) {
            if ([character isKindOfClass:[AbstractBattleCharacter class]] && character.isAlive) {
                timers[timerIndex] = [roderick calculateGromanthAffinityTimeToCharacter:character];
                timerIndex++;
                ParticleEmitter *affinityEmitter = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"PowerIncreasedEmitterTextureNotEmbedded.pex"];
                [statEmitters addObject:affinityEmitter];
                [affinityEmitter release];
                affinityEmitter.startColor = Color4fMake(0, 0.4, 0.6, 1);
                affinityEmitter.sourcePosition = Vector2fMake(character.renderPoint.x, character.renderPoint.y - 20);
            }
        }
        stage = 0;
        duration = 1.5;
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
                    int counter = 0;
                    BattleRoderick *roderick = [sharedGameController.battleCharacters objectForKey:@"BattleRoderick"];
                    for (AbstractBattleCharacter *character in sharedGameController.currentScene.activeEntities) {
                        if ([character isKindOfClass:[AbstractBattleCharacter class]] && character.isAlive) {
                            [character increaseAffinityModifierBy:(int)(5 + ((roderick.level + roderick.levelModifier) / 10))];
                            characters[counter] = CGPointMake([sharedGameController.currentScene.activeEntities indexOfObject:character], (5 + ((roderick.level + roderick.levelModifier) / 10)));
                            counter++;
                        }
                    }
                    duration = MAX(timers[0], timers[1]);
                    duration = MAX(duration, timers[2]);
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
        switch (stage) {
            case 0:
                for (ParticleEmitter *pe in statEmitters) {
                    [pe updateWithDelta:aDelta];
                }
                break;
            case 1:
                for (int i = 0; i < 3; i++) {
                    if (timers[i] > 0) {
                        timers[i] -= aDelta;
                        if (timers[i] < 0) {
                            timers[i] = 0;
                            AbstractBattleCharacter *character = [sharedGameController.currentScene.activeEntities objectAtIndex:characters[i].x];
                            [character decreaseAffinityModifierBy:(int)characters[i].y];
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

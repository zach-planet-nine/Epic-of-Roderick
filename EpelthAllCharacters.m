//
//  EpelthAllCharacters.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/10/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "EpelthAllCharacters.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleCharacter.h"
#import "BattlePriest.h"
#import "ParticleEmitter.h"

@implementation EpelthAllCharacters

- (void)dealloc {
    
    if (emitters) {
        [emitters release];
    }
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        
        BattlePriest *poet = [sharedGameController.battleCharacters objectForKey:@"BattlePriest"];
        enduranceAdded = [poet calculateEpelthEnduranceAdded];
        emitters = [[NSMutableArray alloc] init];
        for (AbstractBattleCharacter *character in sharedGameController.currentScene.activeEntities) {
            if ([character isKindOfClass:[AbstractBattleCharacter class]] && character.isAlive) {
                ParticleEmitter *epelthEmitter = [[ParticleEmitter alloc] initProjectileEmitterWithFile:@"BloodSplatter.pex" fromPoint:character.renderPoint toPoint:character.renderPoint];
                [emitters addObject:epelthEmitter];
                [epelthEmitter release];
            }
        }
        stage = 0;
        duration = 0.4;
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
                    for (AbstractBattleCharacter *character in sharedGameController.currentScene.activeEntities) {
                        if ([character isKindOfClass:[AbstractBattleCharacter class]] && character.isAlive) {
                            [character youTookDamage:enduranceAdded];
                            character.endurance = MIN(enduranceAdded, character.maxEndurance - character.endurance);
                        }
                    }
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
            for (ParticleEmitter *pe in emitters) {
                [pe updateWithDelta:aDelta];
            }
        }
    }
}

- (void)render {
    
    if (active && stage == 0) {
        for (ParticleEmitter *pe in emitters) {
            [pe renderParticles];
        }
    }
}

@end

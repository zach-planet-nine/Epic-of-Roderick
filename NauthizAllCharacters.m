//
//  NauthizAllCharacters.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/25/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "NauthizAllCharacters.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleCharacter.h"
#import "BattleValkyrie.h"
#import "ParticleEmitter.h"

@implementation NauthizAllCharacters

- (void)dealloc {
    
    if (doubleHealingEmitter) {
        [doubleHealingEmitter release];
    }
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
    
        doubleHealingEmitter = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"DoubleHealingEmitter.pex"];
        doubleHealingEmitter.sourcePosition = Vector2fMake(40, 0);
        BattleValkyrie *valk = [sharedGameController.battleCharacters objectForKey:@"BattleValkyrie"];
        nauthizDuration = [valk calculateNauthizDuration];
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
                    for (AbstractBattleCharacter *character in sharedGameController.currentScene.activeEntities) {
                        if ([character isKindOfClass:[AbstractBattleCharacter class]]) {
                            [character youGainedDoubleHealing];
                        }
                    }
                    duration = nauthizDuration;
                    break;
                case 1:
                    stage++;
                    for (AbstractBattleCharacter *character in sharedGameController.currentScene.activeEntities) {
                        if ([character isKindOfClass:[AbstractBattleCharacter class]]) {
                            [character youLostDoubleHealing];
                        }
                    }
                    duration = 0.5;
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
            doubleHealingEmitter.sourcePosition = Vector2fMake(40, doubleHealingEmitter.sourcePosition.y + (aDelta * (360 / 1.5)));
            [doubleHealingEmitter updateWithDelta:aDelta];
        }
    }
}

- (void)render {
    
    if (active && stage == 0) {
        [doubleHealingEmitter renderParticles];
    }
}

@end

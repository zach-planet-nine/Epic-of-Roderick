//
//  HagalazAllCharacters.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/24/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "HagalazAllCharacters.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleCharacter.h"
#import "BattleValkyrie.h"
#import "ParticleEmitter.h"
#import "FadeInOrOut.h"

@implementation HagalazAllCharacters

- (void)dealloc {
    
    if (starEmitter) {
        [starEmitter release];
    }
    if (dimWorld) {
        [dimWorld release];
    }
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        
        BattleValkyrie *valk = [sharedGameController.battleCharacters objectForKey:@"BattleValkyrie"];
        if (valk.essence > 5) {
            starEmitter = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"RageEmitter.pex"];
            starEmitter.sourcePosition = Vector2fMake(120, 160);
            starEmitter.angle = 180;
            starEmitter.startColor = Color4fMake(1, 1, 1, 1);
            starEmitter.startColorVariance = Color4fMake(1, 1, 1, 0);
            starEmitter.finishColor = Color4fMake(1, 1, 1, 0);
            starEmitter.finishColorVariance = Color4fMake(1, 1, 1, 0);
            starEmitter.maxParticles = 120;
            for (AbstractBattleCharacter *character in sharedGameController.currentScene.activeEntities) {
                if ([character isKindOfClass:[AbstractBattleCharacter class]]) {
                    character.isDrauraed = NO;
                    character.isFatigued = NO;
                    character.isSlothed = NO;
                    character.isDisoriented = NO;
                    character.isHexed = NO;
                }
            }
        } else {
            starEmitter = [[ParticleEmitter alloc] initProjectileEmitterWithFile:@"RageEmitter.pex" fromPoint:CGPointMake(120, 160) toPoint:valk.renderPoint];
            starEmitter.startColor = Color4fMake(0, 0, 0, 1);
            starEmitter.startColorVariance = starEmitter.finishColor = starEmitter.finishColorVariance = Color4fMake(0, 0, 0, 0);
            [valk youWereDrauraed:10];
            [valk youWereFatigued:10];
            [valk youWereDisoriented:10];
            [valk youWereHexed:10];
            [valk youWereSlothed:10];
        }
        dimWorld = [[FadeInOrOut alloc] initFadeOutToAlpha:0.3 withDuration:1.15];
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
                    dimWorld.active = YES;
                    duration = 1.2;
                    break;
                case 1:
                    stage++;
                    dimWorld.active = NO;
                    active = NO;
                    duration = 1;
                    break;
                case 2:
                    stage++;
                    active = NO;
                default:
                    break;
            }
        }
        switch (stage) {
            case 0:
                [dimWorld updateWithDelta:aDelta];
                break;
            case 1:
                [starEmitter updateWithDelta:aDelta];
                break;
                
            default:
                break;
        }
    }
}

- (void)render {
    
    if (active) {
        switch (stage) {
            case 0:
                [dimWorld render];
                break;
            case 1:
                //[dimWorld render];
                [starEmitter renderParticles];
                break;
                
            default:
                break;
        }
    }
}

@end

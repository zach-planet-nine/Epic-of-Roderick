//
//  SudrinSingleEnemy.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/22/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "SudrinSingleEnemy.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleEnemy.h"
#import "BattleRoderick.h"
#import "ParticleEmitter.h"
#import "BattleStringAnimation.h"

@implementation SudrinSingleEnemy

- (void)dealloc {
    if (essenceEmitter) {
        [essenceEmitter release];
    }
    [super dealloc];
}

- (id)initToEnemy:(AbstractBattleEnemy *)aEnemy 
{
    self = [super init];
    if (self) {
        
        BattleRoderick *roderick = [sharedGameController.battleCharacters objectForKey:@"BattleRoderick"];
        target1 = aEnemy;
        fatigueDuration = [roderick calculateSudrinDurationTo:aEnemy];
        essenceEmitter = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"EssenceEmitter.pex"];
        essenceEmitter.sourcePosition = Vector2fMake(aEnemy.renderPoint.x, aEnemy.renderPoint.y + 20);
        essenceEmitter.startColor = Color4fMake(0.4, 0.4, 0.4, 0.9);
        essenceEmitter.gravity = Vector2fMake(0, -500);
        essenceEmitter.speed = 0;
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
                    if (fatigueDuration > 0) {
                        [target1 youWereFatigued:(int)fatigueDuration * 10];
                    } else {
                        BattleStringAnimation *bsa = [[BattleStringAnimation alloc] initIneffectiveStringFrom:target1.renderPoint];
                        [sharedGameController.currentScene addObjectToActiveObjects:bsa];
                        [bsa release];
                    }
                    duration = 0.5;
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
                [essenceEmitter updateWithDelta:aDelta];
                break;
            case 1:
                [essenceEmitter updateWithDelta:aDelta];
                break;
                
            default:
                break;
        }
    }
}

- (void)render {
    
    if (active) {
        [essenceEmitter renderParticles];
    }
}

@end

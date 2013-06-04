//
//  GromanthSingleEnemy.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/21/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "GromanthSingleEnemy.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleEnemy.h"
#import "BattleRoderick.h"
#import "ParticleEmitter.h"
#import "BattleStringAnimation.h"

@implementation GromanthSingleEnemy

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
        drauraDuration = [roderick calculateGromanthDurationTo:aEnemy];
        essenceEmitter = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"EssenceEmitter.pex"];
        essenceEmitter.sourcePosition = Vector2fMake(aEnemy.renderPoint.x, aEnemy.renderPoint.y + 20);
        essenceEmitter.startColor = aEnemy.essenceColor;
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
                    if (drauraDuration > 0) {
                        [target1 youWereDrauraed:(int)drauraDuration];
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

//
//  AlgizSingleEnemy.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/7/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "AlgizSingleEnemy.h"
#import "GameController.h"
#import "AbstractBattleEnemy.h"
#import "BattleRanger.h"
#import "ParticleEmitter.h"
#import "BattleStringAnimation.h"

@implementation AlgizSingleEnemy

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
       
        BattleRanger *ranger = [sharedGameController.battleCharacters objectForKey:@"BattleRanger"];
        algizDuration = [ranger calculateAlgizDurationTo:aEnemy];
        if (algizDuration > 0) {
            target1 = aEnemy;
            essenceEmitter = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"EssenceEmitter.pex"];
            essenceEmitter.sourcePosition = Vector2fMake(aEnemy.renderPoint.x, aEnemy.renderPoint.y + 20);
            essenceEmitter.startColor = aEnemy.essenceColor;
            essenceEmitter.gravity = Vector2fMake(0, -500);
            essenceEmitter.speed = 0;
            stage = 0;
            duration = 1.5;
            active = YES; 
        } else {
            [BattleStringAnimation makeIneffectiveStringAt:aEnemy.renderPoint];
            stage = 2;
            active = NO;
        }
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
                    [target1 youWereDrauraed:(int)algizDuration];
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

//
//  EnemyHealNegativeStatus.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/14/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "EnemyHealNegativeStatus.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleEnemy.h"
#import "ParticleEmitter.h"
#import "BattleStringAnimation.h"

@implementation EnemyHealNegativeStatus

- (void)dealloc {
    
    if (statusEmitter) {
        [statusEmitter release];
    }
    [super dealloc];
}

- (id)initToEnemy:(AbstractBattleEnemy *)aEnemy
{
    self = [super init];
    if (self) {
        
        target1 = aEnemy;
        statusEmitter = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"EnemyStatusEmitter.pex"];
        statusEmitter.sourcePosition = Vector2fMake(aEnemy.renderPoint.x, aEnemy.renderPoint.y + 30);
        stage = 10;
        duration = 0.3;
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
                    if (target1.isFatigued) {
                        target1.isFatigued = NO;
                        [BattleStringAnimation makeStatusString:@"DeFatigued!" at:target1.renderPoint];
                    }
                    if (target1.isDisoriented) {
                        target1.isDisoriented = NO;
                        [BattleStringAnimation makeStatusString:@"ReOriented!" at:target1.renderPoint];
                    }
                    if (target1.isDrauraed) {
                        target1.isDrauraed = NO;
                        [BattleStringAnimation makeStatusString:@"Raura!" at:target1.renderPoint];
                    }
                    if (target1.isSlothed) {
                        target1.isSlothed = NO;
                        [BattleStringAnimation makeStatusString:@"DeSlothed!" at:target1.renderPoint];
                    }
                    if (target1.isHexed) {
                        target1.isHexed = NO;
                        [BattleStringAnimation makeStatusString:@"DeHexed!" at:target1.renderPoint];
                    }
                    duration = 1;
                    break;
                case 1:
                    stage++;
                    active = NO;
                    break;
                case 10:
                    stage = 0;
                    duration = 0.5;
                    break;
                default:
                    break;
            }
        }
        if (stage == 0) {
            [statusEmitter updateWithDelta:aDelta];
        }
    }
}

- (void)render {
    
    if (active && stage == 0) {
        [statusEmitter renderParticles];
    }
}

@end

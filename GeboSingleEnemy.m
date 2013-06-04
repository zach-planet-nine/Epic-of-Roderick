//
//  GeboSingleEnemy.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/8/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "GeboSingleEnemy.h"
#import "GameController.h"
#import "AbstractBattleEnemy.h"
#import "BattlePriest.h"
#import "ParticleEmitter.h"
#import "BattleStringAnimation.h"

@implementation GeboSingleEnemy

- (void)dealloc {
    
    if (bloodEmitter) {
        [bloodEmitter release];
    }
    if (essenceEmitter) {
        [essenceEmitter release];
    }
    [super dealloc];
}

- (id)initToEnemy:(AbstractBattleEnemy *)aEnemy
{
    self = [super init];
    if (self) {
        
        BattlePriest *poet = [sharedGameController.battleCharacters objectForKey:@"BattlePriest"];
        target1 = aEnemy;
        originator = poet;
        geboDuration = [poet calculateGeboDurationTo:aEnemy];
        if (geboDuration > 0) {
            bloodEmitter = [[ParticleEmitter alloc] initProjectileEmitterWithFile:@"EssenceEmitter.pex" fromPoint:poet.renderPoint toPoint:aEnemy.renderPoint];
            bloodEmitter.startColor = Color4fMake(1, 0, 0, 1);
            bloodEmitter.finishColor = Color4fMake(1, 0, 0, 1);
            bloodEmitter.startParticleSize = 12;
            bloodEmitter.finishParticleSize = 0;
            bloodEmitter.angle = 90;
            bloodEmitter.speed *= 0.5;
            essenceEmitter = [[ParticleEmitter alloc] initProjectileEmitterWithFile:@"EssenceEmitter.pex" fromPoint:aEnemy.renderPoint toPoint:poet.renderPoint];
            essenceEmitter.startColor = aEnemy.essenceColor;
            essenceEmitter.finishColor = poet.essenceColor;
            essenceEmitter.startParticleSize = 12;
            essenceEmitter.finishParticleSize = 0;
            essenceEmitter.speed *= 0.5;
            essenceEmitter.angle = 270;
            stage = 0;
            duration = geboDuration;
            active = YES;

        } else {
            stage = 2;
            [BattleStringAnimation makeIneffectiveStringAt:aEnemy.renderPoint];
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
            [bloodEmitter updateWithDelta:aDelta];
            [essenceEmitter updateWithDelta:aDelta];
            originator.hp -= (aDelta * (originator.level + originator.levelModifier + originator.lifeAffinity - target1.lifeAffinity));
            originator.essence += (aDelta * (originator.level + originator.levelModifier + originator.lifeAffinity - target1.lifeAffinity) * 0.1);
            target1.essence -= (aDelta * (originator.level + originator.levelModifier + originator.lifeAffinity - target1.lifeAffinity) * 0.1);
        }
    }
}

- (void)render {
    
    if (active && stage == 0) {
        [bloodEmitter renderParticles];
        [essenceEmitter renderParticles];
    }
}

@end

//
//  HagalazSingleEnemy.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/24/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "HagalazSingleEnemy.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleEnemy.h"
#import "BattleValkyrie.h"
#import "ParticleEmitter.h"
#import "FadeInOrOut.h"

@implementation HagalazSingleEnemy

- (void)dealloc {
    
    if (hailEmitter) {
        [hailEmitter release];
    }
    if (statEmitter) {
        [statEmitter release];
    }
    if (dimWorld) {
        [dimWorld release];
    }
    [super dealloc];
}

- (id)initToEnemy:(AbstractBattleEnemy *)aEnemy
{
    self = [super init];
    if (self) {
        BattleValkyrie *valk = [sharedGameController.battleCharacters objectForKey:@"BattleValkyrie"];
        hagalazDuration = [valk calculateHagalazDurationTo:aEnemy];
        float modifier = ((valk.affinity + valk.affinityModifier + valk.level + valk.levelModifier) * (valk.waterAffinity / aEnemy.waterAffinity) + 1);
        [aEnemy decreaseAgilityModifierBy:(int)(modifier / 2)];
        [aEnemy decreaseDexterityModifierBy:(int)(modifier / 2)];
        mod = (int)(modifier / 2);
        hailEmitter = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"RainEmitter.pex"];
        statEmitter = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"StatModifierEmitter.pex"];
        statEmitter.startColor = Color4fMake(0, 0.8, 0.2, 0.9);
        statEmitter.finishColor = Color4fMake(0, 0.4, 0.05, 0);
        statEmitter.sourcePosition = Vector2fMake(aEnemy.renderPoint.x, aEnemy.renderPoint.y);
        target1 = aEnemy;
        dimWorld = [[FadeInOrOut alloc] initFadeOutToAlpha:0.3 withDuration:1];
        stage = 0;
        active = YES;
        duration = 1;
        
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
                    duration = 0.8;
                    break;
                case 1:
                    stage++;
                    duration = 1;
                    break;
                case 2:
                    stage++;
                    duration = hagalazDuration;
                    break;
                case 3:
                    stage++;
                    [target1 increaseAgilityModifierBy:mod];
                    [target1 increaseDexterityModifierBy:mod];
                    active = NO;
                    break;
                    
                default:
                    break;
            }
        }
        switch (stage) {
            case 0:
                [dimWorld updateWithDelta:aDelta];
                break;
            case 1:
                [hailEmitter updateWithDelta:aDelta];
                break;
            case 2:
                [hailEmitter updateWithDelta:aDelta];
                [statEmitter updateWithDelta:aDelta];
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
                [dimWorld render];
                [hailEmitter renderParticles];
                break;
            case 2:
                [dimWorld render];
                [statEmitter renderParticles];
                [hailEmitter renderParticles];
                break;
                
            default:
                break;
        }
    }
}

@end

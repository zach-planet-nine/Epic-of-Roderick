//
//  UruzSingleEnemy.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/6/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "UruzSingleEnemy.h"
#import "GameController.h"
#import "AbstractBattleEnemy.h"
#import "BattleRanger.h"
#import "Image.h"
#import "ParticleEmitter.h"

@implementation UruzSingleEnemy

- (void)dealloc {
    
    if (bull) {
        [bull release];
    }
    if (dustEmitter) {
        [dustEmitter release];
    }
    [super dealloc];
}

- (id)initToEnemy:(AbstractBattleEnemy *)aEnemy
{
    self = [super init];
    if (self) {
        
        BattleRanger *ranger = [sharedGameController.battleCharacters objectForKey:@"BattleRanger"];
        damage = [ranger calculateUruzDamageTo:aEnemy];
        target1 = aEnemy;
        bull = [[Image alloc] initWithImageNamed:@"Bull.png" filter:GL_NEAREST];
        bull.renderPoint = CGPointMake(-60, aEnemy.renderPoint.y);
        dustEmitter = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"DustEmitter.pex"];
        dustEmitter.sourcePosition = Vector2fMake(-60, bull.renderPoint.y - 30);
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
                    [target1 flashColor:Color4fMake(0.3, 0.3, 0.3, 1)];
                    [target1 youTookDamage:damage];
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
        bull.renderPoint = CGPointMake(bull.renderPoint.x + (aDelta * 540), bull.renderPoint.y);
        dustEmitter.sourcePosition = Vector2fMake(dustEmitter.sourcePosition.x + (aDelta * 540), dustEmitter.sourcePosition.y);
        [dustEmitter updateWithDelta:aDelta];
    }
}

- (void)render {
    
    if (active && stage == 0) {
        [bull renderCenteredAtPoint:bull.renderPoint];
        [dustEmitter renderParticles];
    }
}

@end

//
//  IngrethSingleEnemy.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/9/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "IngrethSingleEnemy.h"
#import "GameController.h"
#import "AbstractBattleEnemy.h"
#import "BattlePriest.h"
#import "Image.h"
#import "FadeInOrOut.h"
#import "ParticleEmitter.h"

@implementation IngrethSingleEnemy

- (void)dealloc {
    
    if (gungnir) {
        [gungnir release];
    }
    if (ingrethEmitter) {
        [ingrethEmitter release];
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
        
        BattlePriest *poet = [sharedGameController.battleCharacters objectForKey:@"BattlePriest"];
        target1 = aEnemy;
        damage = [poet calculateIngrethDamageTo:aEnemy];
        gungnir = [[Image alloc] initWithImageNamed:@"Gungnir.png" filter:GL_NEAREST];
        gungnir.renderPoint = CGPointMake(aEnemy.renderPoint.x, aEnemy.renderPoint.y + 400);
        dimWorld = [[FadeInOrOut alloc] initFadeOutToAlpha:0.3 withDuration:1.05];
        ingrethEmitter = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"IngrethEmitter.pex"];
        ingrethEmitter.sourcePosition = Vector2fMake(aEnemy.renderPoint.x, aEnemy.renderPoint.y - 20);
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
                    duration = 0.3;
                    break;
                case 1:
                    stage++;
                    duration = 0.5;
                    break;
                case 2:
                    stage++;
                    [target1 youTookDamage:damage];
                    [target1 flashColor:Color4fMake(0.5, 0.5, 0, 1)];
                    duration = 1;
                    break;
                case 3:
                    stage++;
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
                gungnir.renderPoint = CGPointMake(gungnir.renderPoint.x, gungnir.renderPoint.y - (aDelta * 1266.666667));
                break;
            case 2:
                [ingrethEmitter updateWithDelta:aDelta];
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
                [gungnir renderCenteredAtPoint:gungnir.renderPoint];
                break;
            case 2:
                [dimWorld render];
                [gungnir renderCenteredAtPoint:gungnir.renderPoint];
                [ingrethEmitter renderParticles];
                break;
            default:
                break;
        }
    }
}

@end

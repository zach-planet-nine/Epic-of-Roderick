//
//  Fyraz.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/29/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "FyrazSingleEnemy.h"
#import "GameController.h"
#import "AbstractBattleEnemy.h"
#import "AbstractScene.h"
#import "BattleWizard.h"
#import "ParticleEmitter.h"
#import "Image.h"

@implementation FyrazSingleEnemy

- (void)dealloc {
    
    if (fyrazEmitter) {
        [fyrazEmitter release];
    }
    [super dealloc];
}

- (id)initToEnemy:(AbstractBattleEnemy *)aEnemy
{
    self = [super init];
    if (self) {
       
        BattleWizard *wizard = [sharedGameController.battleCharacters objectForKey:@"BattleWizard"];
        target1 = aEnemy;
        damage = [wizard calculateFyrazDamageTo:aEnemy];
        fyrazEmitter = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"FyrazEmitter.pex"];
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
                    [fyrazEmitter particlesBecomeProjectilesTo:target1.renderPoint withDuration:0.5];
                    duration = 0.5;
                    break;
                case 1:
                    stage++;
                    [target1 flashColor:Color4fMake(1, 0, 0, 1)];
                    [target1 youTookDamage:damage];
                    sharedGameController.currentScene.battleImage.color = Color4fOnes;
                    duration = 1;
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
            sharedGameController.currentScene.battleImage.color = Color4fMake(1, sharedGameController.currentScene.battleImage.color.green - aDelta, sharedGameController.currentScene.battleImage.color.blue - aDelta, 1);
        }
        if (stage < 2) {
            [fyrazEmitter updateWithDelta:aDelta];
        }    
    }
}

- (void)render {
    
    if (active && stage < 2) {
        [fyrazEmitter renderParticles];
    }
}

@end

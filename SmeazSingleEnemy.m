//
//  SmeazSingleEnemy.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/10/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "SmeazSingleEnemy.h"
#import "GameController.h"
#import "AbstractBattleEnemy.h"
#import "BattlePriest.h"
#import "ParticleEmitter.h"

@implementation SmeazSingleEnemy

- (void)dealloc {
    
    if (smeazEmitter) {
        [smeazEmitter release];
    }
    [super dealloc];
}

- (id)initToEnemy:(AbstractBattleEnemy *)aEnemy
{
    self = [super init];
    if (self) {
        
        BattlePriest *poet = [sharedGameController.battleCharacters objectForKey:@"BattlePriest"];
        target1 = aEnemy;
        damage = [poet calculateSmeazDamageTo:aEnemy];
        damage = MAX(damage, aEnemy.hp);
        smeazEmitter = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"BloodSplatter.pex"];
        smeazEmitter.sourcePosition = Vector2fMake(aEnemy.renderPoint.x, aEnemy.renderPoint.y);
        stage = 0;
        duration = 0.4;
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
                    [target1 youTookDamage:damage];
                    BattlePriest *poet = [sharedGameController.battleCharacters objectForKey:@"BattlePriest"];
                    [smeazEmitter particlesBecomeProjectilesTo:poet.renderPoint withDuration:0.5];
                    duration = 0.5;
                    break;
                case 1:
                    stage++;
                    BattlePriest *poeter = [sharedGameController.battleCharacters objectForKey:@"BattlePriest"];
                    [poeter youWereHealed:damage];
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
        if (stage < 2) {
            [smeazEmitter updateWithDelta:aDelta];
        } 
    }
}

- (void)render {
    
    if (active && stage < 2) {
        [smeazEmitter renderParticles];
    }
}

@end

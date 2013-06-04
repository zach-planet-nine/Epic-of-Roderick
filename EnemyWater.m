//
//  EnemyWater.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/26/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "EnemyWater.h"
#import "GameController.h"
#import "AbstractBattleEnemy.h"
#import "AbstractBattleCharacter.h"
#import "ParticleEmitter.h"

@implementation EnemyWater

- (void)dealloc {
    
    if (enemyWaterEmitter) {
        [enemyWaterEmitter release];
    }
    [super dealloc];
}

- (id)initFromEnemy:(AbstractBattleEnemy *)aEnemy toCharacter:(AbstractBattleCharacter *)aCharacter
{
    self = [super init];
    if (self) {
        
        target1 = aCharacter;
        damage = [aEnemy calculateWaterDamageToASingleCharacter:aCharacter];
        enemyWaterEmitter = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"EnemyWaterEmitter.pex"];
        enemyWaterEmitter.sourcePosition = Vector2fMake(aCharacter.renderPoint.x, aCharacter.renderPoint.y + 30);
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
                    [target1 youTookDamage:damage];
                    [target1 flashColor:Blue];
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
            [enemyWaterEmitter updateWithDelta:aDelta];
        }
    }
}

- (void)render {
    
    if (active && stage == 0) {
        [enemyWaterEmitter render];
    }
}


@end

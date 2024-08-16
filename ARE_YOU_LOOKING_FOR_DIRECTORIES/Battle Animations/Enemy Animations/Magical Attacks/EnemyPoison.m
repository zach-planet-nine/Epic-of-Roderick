//
//  EnemyPoison.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/26/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "EnemyPoison.h"
#import "GameController.h"
#import "AbstractBattleCharacter.h"
#import "AbstractBattleEnemy.h"
#import "ParticleEmitter.h"

@implementation EnemyPoison

- (void)dealloc {
    
    if (enemyPoisonEmitter) {
        [enemyPoisonEmitter release];
    }
    [super dealloc];
}

- (id)initFromEnemy:(AbstractBattleEnemy *)aEnemy toCharacter:(AbstractBattleCharacter *)aCharacter
{
    self = [super init];
    if (self) {
        
        target1 = aCharacter;
        damage = [aEnemy calculatePoisonDamageToASingleCharacter:aCharacter];
        enemyPoisonEmitter = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"EnemyPoisonEmitter.pex"];
        enemyPoisonEmitter.sourcePosition = Vector2fMake(aCharacter.renderPoint.x, aCharacter.renderPoint.y);
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
                    [target1 flashColor:Green];
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
            [enemyPoisonEmitter updateWithDelta:aDelta];
        }
    }
}

- (void)render {
    
    if (active && stage == 0) {
        [enemyPoisonEmitter render];
    }
}



@end

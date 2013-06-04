//
//  EnemyFire.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/13/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "EnemyFire.h"
#import "AbstractBattleCharacter.h"
#import "AbstractBattleEnemy.h"
#import "ParticleEmitter.h"

@implementation EnemyFire

- (void)dealloc {
    
    if (enemyFireEmitter) {
        [enemyFireEmitter release];
    }
    [super dealloc];
}

- (id)initFromEnemy:(AbstractBattleEnemy *)aEnemy toCharacter:(AbstractBattleCharacter *)aCharacter
{
    self = [super init];
    if (self) {
        
        target1 = aCharacter;
        enemyFireEmitter = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"EnemyFireEmitter.pex"];
        enemyFireEmitter.sourcePosition = Vector2fMake(aCharacter.renderPoint.x, aCharacter.renderPoint.y - 20);
        damage = [aEnemy calculateFireDamageToASingleCharacter:aCharacter];
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
                    [target1 flashColor:Red];
                    [target1 youTookDamage:damage];
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
            [enemyFireEmitter updateWithDelta:aDelta];
        }
    }
}

- (void)render {
    
    if (active && stage == 0) {
        [enemyFireEmitter renderParticles];
    }
}

@end

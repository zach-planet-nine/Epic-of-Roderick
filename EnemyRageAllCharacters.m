//
//  EnemyRageAllCharacters.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 8/3/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "EnemyRageAllCharacters.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleEnemy.h"
#import "AbstractBattleCharacter.h"
#import "ParticleEmitter.h"


@implementation EnemyRageAllCharacters

- (void)dealloc {
    
    if (enemyRageEmitter) {
        [enemyRageEmitter release];
    }
    [super dealloc];
}

- (id)initFromEnemy:(AbstractBattleEnemy *)aEnemy
{
    self = [super init];
    if (self) {
        
        int characterIndex = 0;
        for (AbstractBattleCharacter *character in sharedGameController.currentScene.activeEntities) {
            if ([character isKindOfClass:[AbstractBattleCharacter class]]) {
                damages[characterIndex] = [aEnemy calculateRageDamageToCharacter:character];
                characterIndex++;
            }
        }
        aEnemy.essence -= 15 * characterIndex + (aEnemy.level * 0.2);
        enemyRageEmitter = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"EnemyRageEmitter.pex"];
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
                    int characterIndex = 0;
                    for (AbstractBattleCharacter *character in sharedGameController.currentScene.activeEntities) {
                        if ([character isKindOfClass:[AbstractBattleCharacter class]]) {
                            [character youTookDamage:damages[characterIndex]];
                            if (character.isAlive) {
                                [character flashColor:Green];
                            }
                            characterIndex++;
                        }
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
            for (AbstractBattleCharacter *character in sharedGameController.currentScene.activeEntities) {
                if ([character isKindOfClass:[AbstractBattleCharacter class]] && character.isAlive) {
                    enemyRageEmitter.sourcePosition = Vector2fMake(character.renderPoint.x, character.renderPoint.y);
                    [enemyRageEmitter updateWithDelta:aDelta];
                }
            }
        }
        
    }
}

- (void)render {
    
    if (active && stage == 0) {
        [enemyRageEmitter renderParticles];
    }
}


@end

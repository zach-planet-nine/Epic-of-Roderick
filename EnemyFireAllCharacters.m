//
//  EnemyFireAllCharacters.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 8/3/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "EnemyFireAllCharacters.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleEnemy.h"
#import "AbstractBattleCharacter.h"
#import "ParticleEmitter.h"

@implementation EnemyFireAllCharacters

- (void)dealloc {
    
    if (enemyFireEmitter) {
        [enemyFireEmitter release];
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
                damages[characterIndex] = [aEnemy calculateFireDamageToCharacter:character];
                characterIndex++;
            }
        }
        aEnemy.essence -= 15 * characterIndex + (aEnemy.level * 0.2);
        enemyFireEmitter = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"EnemyFireEmitter.pex"];
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
                    enemyFireEmitter.sourcePosition = Vector2fMake(character.renderPoint.x, character.renderPoint.y);
                    [enemyFireEmitter updateWithDelta:aDelta];
                }
            }
        }
        
    }
}

- (void)render {
    
    if (active && stage == 0) {
        [enemyFireEmitter renderParticles];
    }
}


@end

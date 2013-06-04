//
//  EnemyPoisonAllCharacters.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/14/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "AbstractBattleAnimation.h"

@class ParticleEmitter;

@interface EnemyPoisonAllCharacters : AbstractBattleAnimation {
    
    ParticleEmitter *enemyPoisonEmitter;
    int damages[3];
}

- (id)initFromEnemy:(AbstractBattleEnemy *)aEnemy;

@end

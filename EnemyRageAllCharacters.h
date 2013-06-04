//
//  EnemyRageAllCharacters.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 8/3/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "AbstractBattleAnimation.h"

@class ParticleEmitter;

@interface EnemyRageAllCharacters : AbstractBattleAnimation {
    
    ParticleEmitter *enemyRageEmitter;
    int damages[3];
}

- (id)initFromEnemy:(AbstractBattleEnemy *)aEnemy;

@end

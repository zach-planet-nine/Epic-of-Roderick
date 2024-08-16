//
//  EnemyFireAllCharacters.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 8/3/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "AbstractBattleAnimation.h"

@class ParticleEmitter;

@interface EnemyFireAllCharacters : AbstractBattleAnimation {
    
    ParticleEmitter *enemyFireEmitter;
    int damages[4];
}

- (id)initFromEnemy:(AbstractBattleEnemy *)aEnemy;

@end

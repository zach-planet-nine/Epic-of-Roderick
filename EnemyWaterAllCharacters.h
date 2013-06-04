//
//  EnemyWaterAllCharacters.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/26/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "AbstractBattleAnimation.h"

@class ParticleEmitter;

@interface EnemyWaterAllCharacters : AbstractBattleAnimation {
    
    ParticleEmitter *enemyWaterEmitter;
    int damages[3];
}

- (id)initFromEnemy:(AbstractBattleEnemy *)aEnemy;


@end

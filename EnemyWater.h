//
//  EnemyWater.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/26/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "AbstractBattleAnimation.h"

@class ParticleEmitter;

@interface EnemyWater : AbstractBattleAnimation {
    
    ParticleEmitter *enemyWaterEmitter;
    int damage;
    
}

- (id)initFromEnemy:(AbstractBattleEnemy *)aEnemy toCharacter:(AbstractBattleCharacter *)aCharacter;

@end

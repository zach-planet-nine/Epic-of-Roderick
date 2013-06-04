//
//  EnemyRage.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 8/3/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "AbstractBattleAnimation.h"

@class ParticleEmitter;

@interface EnemyRage : AbstractBattleAnimation {
    
    ParticleEmitter *enemyRageEmitter;
    int damage;
}

- (id)initFromEnemy:(AbstractBattleEnemy *)aEnemy toCharacter:(AbstractBattleCharacter *)aCharacter;

@end

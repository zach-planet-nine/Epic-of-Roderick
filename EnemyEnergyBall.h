//
//  EnemyEnergyBall.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/13/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "AbstractBattleAnimation.h"

@class Projectile;

@interface EnemyEnergyBall : AbstractBattleAnimation {
    
    Projectile *energyBall;
    int damage;
}

- (id)initFromEnemy:(AbstractBattleEnemy *)aEnemy toCharacter:(AbstractBattleCharacter *)aCharacter;

@end

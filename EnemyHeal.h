//
//  EnemyHeal.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/13/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "AbstractBattleAnimation.h"

@interface EnemyHeal : AbstractBattleAnimation 

+ (void)healEnemy:(AbstractBattleEnemy *)aEnemy;

@end

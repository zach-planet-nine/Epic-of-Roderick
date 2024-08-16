//
//  EnemyHeal.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/13/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "EnemyHeal.h"
#import "AbstractBattleEnemy.h"

@implementation EnemyHeal

+ (void)healEnemy:(AbstractBattleEnemy *)aEnemy {
    
    [aEnemy youWereHealed:[aEnemy calculateHealAmountTo:aEnemy]];
}


@end

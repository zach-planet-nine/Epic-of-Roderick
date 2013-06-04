//
//  BattleSwordMan.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/10/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleEnemy.h"

@interface BattleSwordMan : AbstractBattleEnemy {
    
    BOOL shouldAttack;
    EnemyAI ai;
}

@property (nonatomic, assign) BOOL shouldAttack;

@end

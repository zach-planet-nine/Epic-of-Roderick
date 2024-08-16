//
//  BearAllEnemies.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 8/19/11.
//  Copyright (c) 2011 InstantLazer. All rights reserved.
//

#import "AbstractBattleAnimation.h"

@interface BearAllEnemies : AbstractBattleAnimation {
    
}

+ (void)attackTwoEnemies;

- (id)initFromEnemy:(AbstractBattleEnemy *)aEnemy to:(AbstractBattleEnemy *)anotherEnemy;

@end

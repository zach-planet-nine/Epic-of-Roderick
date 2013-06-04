//
//  SpearShower.h
//  TEORBattleTest
//
//  Created by Zach Babb on 5/24/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"

@class BattleValkyrie;
@class AbstractBattleEnemy;
@class BattleValkyrie;

@interface SpearShower : AbstractBattleAnimation {

	NSMutableArray *spears;
	int spearCount;
	BattleValkyrie *valkyrie;
    int damage;
}

- (id)initToEnemy:(AbstractBattleEnemy *)aEnemy;

- (id)initToEnemy:(AbstractBattleEnemy *)aEnemy from:(BattleValkyrie *)aValkyrie;

@end

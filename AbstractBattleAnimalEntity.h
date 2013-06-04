//
//  AbstractBattleAnimalEntity.h
//  TEORBattleTest
//
//  Created by Zach Babb on 5/29/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleEntity.h"

@class AbstractBattleEntity;

@interface AbstractBattleAnimalEntity : AbstractBattleEntity {

	AbstractBattleEntity *target;
	BOOL allEnemies;
	BOOL allCharacters;
    float attackPower;
    float helpPower;
}

@property (nonatomic, retain) AbstractBattleEntity *target;
@property (nonatomic, assign) BOOL allEnemies;
@property (nonatomic, assign) BOOL allCharacters;

- (void)timerFired;

- (void)beSummoned;

- (void)depart;

- (void)joinBattle;

@end

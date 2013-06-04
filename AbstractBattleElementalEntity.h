//
//  AbstractBattleElementalEntity.h
//  TEORBattleTest
//
//  Created by Zach Babb on 5/28/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleEntity.h"

@class AbstractBattleEnemy;
@class AbstractBattleCharacter;

@interface AbstractBattleElementalEntity : AbstractBattleEntity {
	
	int element;
	
}

- (void)youAttackedEnemy:(AbstractBattleEnemy *)aEnemy;

- (void)youAffectedCharacter:(AbstractBattleCharacter *)aCharacter;

- (void)youAffectedAllEnemies;

- (void)youAffectedAllCharacters;

@end

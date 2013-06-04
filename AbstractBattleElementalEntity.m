//
//  AbstractBattleElementalEntity.m
//  TEORBattleTest
//
//  Created by Zach Babb on 5/28/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "AbstractBattleElementalEntity.h"


@implementation AbstractBattleElementalEntity

//These must be updated to initialize the appropriate battle objects.
- (void)youAttackedEnemy:(AbstractBattleEnemy *)aEnemy {}

- (void)youAffectedCharacter:(AbstractBattleCharacter *)aCharacter {}

- (void)youAffectedAllEnemies {}

- (void)youAffectedAllCharacters {}

@end

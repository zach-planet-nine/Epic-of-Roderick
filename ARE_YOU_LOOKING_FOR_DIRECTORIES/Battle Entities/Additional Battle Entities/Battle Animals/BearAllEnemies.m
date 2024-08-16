//
//  BearAllEnemies.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 8/19/11.
//  Copyright (c) 2011 InstantLazer. All rights reserved.
//

#import "BearAllEnemies.h"
#import "GameController.h"
#import "AbstractBattleEnemy.h"
#import "OverMind.h"
#import "AbstractScene.h"
#import "BearSingleEnemy.h"

@implementation BearAllEnemies

- (void)dealloc {
    
    [super dealloc];
}

+ (void)attackTwoEnemies {
    int numberOfEnemies = 0;
    for (AbstractBattleEnemy *enemy in [GameController sharedGameController].currentScene.activeEntities) {
        if ([enemy isKindOfClass:[AbstractBattleEnemy class]] && enemy.isAlive) {
            numberOfEnemies++;
        }
    }
    if (numberOfEnemies < 2) {
        [BearSingleEnemy bearMakeEnemyWait:[[OverMind sharedOverMind] anyEnemy]];
        return;
    }
    AbstractBattleEnemy *firstEnemy = [[OverMind sharedOverMind] anyEnemy];
    AbstractBattleEnemy *secondEnemy = firstEnemy;
    while (firstEnemy == secondEnemy) {
        secondEnemy = [[OverMind sharedOverMind] anyEnemy];
    }
    BearAllEnemies *bae = [[BearAllEnemies alloc] initFromEnemy:firstEnemy to:secondEnemy];
    [[GameController sharedGameController].currentScene addObjectToActiveObjects:bae];
    [bae release];
}

/*- (id)initFromEnemy:(AbstractBattleEnemy *)aEnemy to:(AbstractBattleEnemy *)anotherEnemy {
    
    self = [super init];
    if (self) {
        <#statements#>
    }
}*/

@end

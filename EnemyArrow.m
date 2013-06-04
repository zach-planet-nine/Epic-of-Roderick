//
//  EnemyArrow.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/14/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "EnemyArrow.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleEnemy.h"
#import "AbstractBattleCharacter.h"
#import "FirstArrowShot.h"

@implementation EnemyArrow

+ (void)enemy:(AbstractBattleEnemy *)aEnemy arrows:(AbstractBattleCharacter *)aCharacter {
    
    FirstArrowShot *arrow = [[FirstArrowShot alloc] initFromEnemy:aEnemy toCharacter:aCharacter];
    [[GameController sharedGameController].currentScene addObjectToActiveObjects:arrow];
    [arrow release];
}

@end

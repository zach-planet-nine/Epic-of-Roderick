//
//  DagazAllEnemies.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/9/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "DagazAllEnemies.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleEnemy.h"
#import "BattlePriest.h"
#import "DagazSingleEnemy.h"
#import "BattleStringAnimation.h"

@implementation DagazAllEnemies

+ (void)hexEnemies {
    
    BattlePriest *poet = [[GameController sharedGameController].battleCharacters objectForKey:@"BattlePriest"];
    for (AbstractBattleEnemy *enemy in [GameController sharedGameController].currentScene.activeEntities) {
        if ([enemy isKindOfClass:[AbstractBattleEnemy class]] && enemy.isAlive) {
            if (RANDOM_0_TO_1() * 100 < (poet.affinity + poet.affinityModifier + poet.poisonAffinity + poet.level + poet.levelModifier - enemy.level - enemy.levelModifier) * (poet.essence / poet.maxEssence)) {
                DagazSingleEnemy *dse = [[DagazSingleEnemy alloc] initToEnemy:enemy];
                [[GameController sharedGameController].currentScene addObjectToActiveObjects:dse];
                [dse release];
            } else {
                [BattleStringAnimation makeIneffectiveStringAt:enemy.renderPoint];
            }
        }
    }
}

@end

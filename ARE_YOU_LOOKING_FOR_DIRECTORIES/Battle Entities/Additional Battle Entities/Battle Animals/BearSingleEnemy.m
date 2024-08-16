//
//  BearSingleEnemy.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 8/19/11.
//  Copyright (c) 2011 InstantLazer. All rights reserved.
//

#import "BearSingleEnemy.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleEnemy.h"
#import "BattleRanger.h"

@implementation BearSingleEnemy 

- (void)dealloc {
    [super dealloc];
}

+ (void)bearMakeEnemyWait:(AbstractBattleEnemy *)aEnemy {
    BattleRanger *ranger = [[GameController sharedGameController].battleCharacters objectForKey:@"BattleRanger"];
    aEnemy.wait = YES;
    aEnemy.waitTimer = (ranger.level + ranger.levelModifier + ranger.luck + ranger.luckModifier + (arc4random() % 3)) * 0.1;
    BearSingleEnemy *bse = [[BearSingleEnemy alloc] init];
    [[GameController sharedGameController].currentScene addObjectToActiveObjects:bse];
    [bse release];
}

- (id)init {
    self = [super init];
    if (self) {
        stage = 0;
        active = YES;
        duration = 1;
    }
    return self;
}

- (void)updateWithDelta:(float)aDelta {
    
    if (active) {
        duration -= aDelta;
        if (duration < 0) {
            switch (stage) {
                case 0:
                    stage++;
                    BattleRanger *ranger = [[GameController sharedGameController].battleCharacters objectForKey:@"BattleRanger"];
                    [ranger.currentAnimal returnToRanger];
                    duration = 0.5;
                    break;
                case 1:
                    stage++;
                    active = NO;
                    break;
                    
                default:
                    break;
            }
        }
    }
}

@end

//
//  AlgizAllCharacters.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/7/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "AlgizAllCharacters.h"
#import "GameController.h"
#import "AbstractBattleAnimalEntity.h"
#import "BattleRanger.h"
#import "Squirrel.h"

@implementation AlgizAllCharacters

+ (void)summonSquirrel {
    
    BattleRanger *ranger = [[GameController sharedGameController].battleCharacters objectForKey:@"BattleRanger"];
    [ranger.currentAnimal depart];
    Squirrel *squirrel = [[Squirrel alloc] init];
    [squirrel beSummoned];
    ranger.currentAnimal = squirrel;
}

@end

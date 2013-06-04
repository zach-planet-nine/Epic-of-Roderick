//
//  SwopazAllCharacters.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/7/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "SwopazAllCharacters.h"
#import "GameController.h"
#import "AbstractBattleAnimalEntity.h"
#import "BattleRanger.h"
#import "Hawk.h"

@implementation SwopazAllCharacters

+ (void)summonHawk {
    
    BattleRanger *ranger = [[GameController sharedGameController].battleCharacters objectForKey:@"BattleRanger"];
    [ranger.currentAnimal depart];
    Hawk *hawk = [[Hawk alloc] init];
    [hawk beSummoned];
    ranger.currentAnimal = hawk;
}
@end

//
//  HoppatAllCharacters.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/7/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "HoppatAllCharacters.h"
#import "GameController.h"
#import "AbstractBattleAnimalEntity.h"
#import "BattleRanger.h"
#import "Frog.h"

@implementation HoppatAllCharacters

+ (void)summonFrog {
    
    BattleRanger *ranger = [[GameController sharedGameController].battleCharacters objectForKey:@"BattleRanger"];
    [ranger.currentAnimal depart];
    Frog *frog = [[Frog alloc] init];
    [frog beSummoned];
    ranger.currentAnimal = frog;
}

@end

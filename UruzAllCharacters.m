//
//  UruzAllCharacters.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/6/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "UruzAllCharacters.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleAnimalEntity.h"
#import "Bear.h"
#import "BattleRanger.h"

@implementation UruzAllCharacters

+ (void)summonBear {
    
    BattleRanger *ranger = [[GameController sharedGameController].battleCharacters objectForKey:@"BattleRanger"];
    [ranger.currentAnimal depart];
    Bear *bear = [[Bear alloc] init];
    [bear beSummoned];
    ranger.currentAnimal = bear;
}

@end

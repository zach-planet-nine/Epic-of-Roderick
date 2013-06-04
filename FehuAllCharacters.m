//
//  FehuAllCharacters.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/6/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "FehuAllCharacters.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "BattleRanger.h"
#import "AbstractBattleAnimalEntity.h"
#import "Dog.h"


@implementation FehuAllCharacters

+ (void)summonDog {
    
    BattleRanger *ranger = [[GameController sharedGameController].battleCharacters objectForKey:@"BattleRanger"];
    [ranger.currentAnimal depart];
    Dog *dog = [[Dog alloc] init];
    [dog beSummoned];
    ranger.currentAnimal = dog;
}

@end

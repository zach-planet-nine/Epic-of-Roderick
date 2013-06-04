//
//  ThurisazSingleCharacter.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/6/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "ThurisazSingleCharacter.h"
#import "GameController.h"
#import "AbstractBattleCharacter.h"
#import "BattleRanger.h"

@implementation ThurisazSingleCharacter

+ (void)grantWoodElementTo:(AbstractBattleCharacter *)aCharacter {
	
	[aCharacter youReceivedWeaponElement:kWood];
    BattleRanger *ranger = [[GameController sharedGameController].battleCharacters objectForKey:@"BattleRanger"];
    for (int i = 1; i < (ranger.level + ranger.levelModifier + ranger.woodAffinity) / 10 * (ranger.essence / ranger.maxEssence); i++) {
        [aCharacter gainElementalAttack:kWood];
    }
}

@end

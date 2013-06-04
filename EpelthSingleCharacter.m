//
//  EpelthSingleCharacter.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/10/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "EpelthSingleCharacter.h"
#import "GameController.h"
#import "AbstractBattleCharacter.h"
#import "BattlePriest.h"

@implementation EpelthSingleCharacter

+ (void)grantDeathAttackTo:(AbstractBattleCharacter *)aCharacter {
    
    [aCharacter youReceivedWeaponElement:kDeath];
    BattlePriest *poet = [[GameController sharedGameController].battleCharacters objectForKey:@"BattlePriest"];
    for (int i = 1; i < (poet.level + poet.levelModifier + poet.rageAffinity) / 10; i++) {
        [aCharacter gainElementalAttack:kDeath];
    }
}

@end

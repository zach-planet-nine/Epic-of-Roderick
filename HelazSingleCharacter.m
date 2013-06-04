//
//  HelazSingleCharacter.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/10/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "HelazSingleCharacter.h"
#import "GameController.h"
#import "AbstractBattleCharacter.h"
#import "BattlePriest.h"

@implementation HelazSingleCharacter

+ (void)grantRageAttackTo:(AbstractBattleCharacter *)aCharacter {
    
    [aCharacter youReceivedWeaponElement:kDivine];
    BattlePriest *poet = [[GameController sharedGameController].battleCharacters objectForKey:@"BattlePriest"];
    for (int i = 1; i < (poet.level + poet.levelModifier + poet.rageAffinity) / 10; i++) {
        [aCharacter gainElementalAttack:kDivine];
    }
}

@end

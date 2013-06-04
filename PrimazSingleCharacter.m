//
//  PrimazSingleCharacter.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/27/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "PrimazSingleCharacter.h"
#import "GameController.h"
#import "AbstractBattleCharacter.h"
#import "BattleValkyrie.h"

@implementation PrimazSingleCharacter

+ (void)grantRageAttackTo:(AbstractBattleCharacter *)aCharacter {
    
    [aCharacter youReceivedWeaponElement:kRage];
    BattleValkyrie *valkyrie = [[GameController sharedGameController].battleCharacters objectForKey:@"BattleValkyrie"];
    for (int i = 1; i < (valkyrie.level + valkyrie.levelModifier + valkyrie.rageAffinity) / 10; i++) {
        [aCharacter gainElementalAttack:kRage];
    }
}

@end

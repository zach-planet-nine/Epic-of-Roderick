//
//  VestrinSingleCharacter.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/23/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "VestrinSingleCharacter.h"
#import "GameController.h"
#import "AbstractBattleCharacter.h"
#import "BattleRoderick.h"

@implementation VestrinSingleCharacter

+ (void)grantSkyElementTo:(AbstractBattleCharacter *)aCharacter {
	
	[aCharacter youReceivedWeaponElement:kSky];
    BattleRoderick *roderick = [[GameController sharedGameController].battleCharacters objectForKey:@"BattleRoderick"];
    for (int i = 1; i < (roderick.level + roderick.levelModifier + roderick.skyAffinity) / 10; i++) {
        [aCharacter gainElementalAttack:kSky];
    }
}

@end

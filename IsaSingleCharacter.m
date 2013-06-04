//
//  IsaSingleCharacter.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/19/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "IsaSingleCharacter.h"
#import "GameController.h"
#import "AbstractBattleCharacter.h"
#import "BattleRoderick.h"

@implementation IsaSingleCharacter

+ (void)grantWaterElementTo:(AbstractBattleCharacter *)aCharacter {
	
	[aCharacter youReceivedWeaponElement:kWater];
    BattleRoderick *roderick = [[GameController sharedGameController].battleCharacters objectForKey:@"BattleRoderick"];
    for (int i = 1; i < (roderick.level + roderick.levelModifier + roderick.waterAffinity) / 10 * (roderick.essence / roderick.maxEssence); i++) {
        [aCharacter gainElementalAttack:kWater];
    }
}

@end

//
//  NauthizSingleCharacter.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/25/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "NauthizSingleCharacter.h"
#import "GameController.h"
#import "BattleValkyrie.h"

@implementation NauthizSingleCharacter

+ (void)grantLifeAttackTo:(AbstractBattleCharacter *)aCharacter {
	
	[aCharacter youReceivedWeaponElement:kLife];
    BattleValkyrie *valk = [[GameController sharedGameController].battleCharacters objectForKey:@"BattleRoderick"];
    for (int i = 1; i < (valk.level + valk.levelModifier + valk.lifeAffinity) / 10; i++) {
        [aCharacter gainElementalAttack:kLife];
    }
}

@end

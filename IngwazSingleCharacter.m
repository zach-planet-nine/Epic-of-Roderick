//
//  IngwazSingleCharacter.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/28/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "IngwazSingleCharacter.h"
#import "GameController.h"
#import "BattleWizard.h"

@implementation IngwazSingleCharacter

+ (void)grantStoneAttackTo:(AbstractBattleCharacter *)aCharacter {
    
    [aCharacter youReceivedWeaponElement:kStone];
    BattleWizard *wizard = [[GameController sharedGameController].battleCharacters objectForKey:@"BattleWizard"];
    for (int i = 1; i < ((wizard.level + wizard.levelModifier + wizard.stoneAffinity) / 10) * (wizard.essence / wizard.maxEssence); i++) {
        [aCharacter gainElementalAttack:kStone];
    }

}

@end

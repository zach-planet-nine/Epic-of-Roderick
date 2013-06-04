//
//  MannazSingleCharacter.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/28/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "MannazSingleCharacter.h"
#import "GameController.h"
#import "AbstractBattleCharacter.h"
#import "BattleWizard.h"

@implementation MannazSingleCharacter

+ (void)grantFireAttackTo:(AbstractBattleCharacter *)aCharacter {
    
    [aCharacter youReceivedWeaponElement:kFire];
    BattleWizard *wizard = [[GameController sharedGameController].battleCharacters objectForKey:@"BattleWizard"];
    for (int i = 1; i < (wizard.level + wizard.levelModifier + wizard.fireAffinity) / 10; i++) {
        [aCharacter gainElementalAttack:kFire];
    }
}

@end

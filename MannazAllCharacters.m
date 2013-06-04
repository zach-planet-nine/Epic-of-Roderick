//
//  MannazAllCharacters.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/28/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "MannazAllCharacters.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleCharacter.h"
#import "BattleWizard.h"

@implementation MannazAllCharacters

+ (void)grantFireShields {
    
    BattleWizard *wizard = [[GameController sharedGameController].battleCharacters objectForKey:@"BattleWizard"];
    
    for (AbstractBattleCharacter *character in [GameController sharedGameController].currentScene.activeEntities) {
		if ([character isKindOfClass:[AbstractBattleCharacter class]] && character.isAlive) {
			[character youReceivedShield:kFire];
		}
        for (int i = 1; i < ((wizard.level + wizard.levelModifier) / 10 * (wizard.essence / wizard.maxEssence)); i++) {
            [character gainElementalProtection:kFire];
        }
	}

}


@end

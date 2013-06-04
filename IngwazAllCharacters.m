//
//  IngwazAllCharacters.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/28/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "IngwazAllCharacters.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleCharacter.h"
#import "BattleWizard.h"

@implementation IngwazAllCharacters

+ (void)grantStoneShields {
    
    BattleWizard *wizard = [[GameController sharedGameController].battleCharacters objectForKey:@"BattleWizard"];
    
    for (AbstractBattleCharacter *character in [GameController sharedGameController].currentScene.activeEntities) {
		if ([character isKindOfClass:[AbstractBattleCharacter class]] && character.isAlive) {
			[character youReceivedShield:kStone];
		}
        for (int i = 1; i < ((wizard.level + wizard.levelModifier + wizard.stoneAffinity) / 10 * (wizard.essence / wizard.maxEssence)); i++) {
            [character gainElementalProtection:kStone];
        }
	}
}

@end

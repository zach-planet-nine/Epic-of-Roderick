//
//  HelazAllCharacters.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/10/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "HelazAllCharacters.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleCharacter.h"
#import "BattlePriest.h"

@implementation HelazAllCharacters

+ (void)grantDivineShields {

    BattlePriest *poet = [[GameController sharedGameController].battleCharacters objectForKey:@"BattlePriest"];
    
    for (AbstractBattleCharacter *character in [GameController sharedGameController].currentScene.activeEntities) {
		if ([character isKindOfClass:[AbstractBattleCharacter class]] && character.isAlive) {
			[character youReceivedShield:kDivine];
		}
        for (int i = 1; i < ((poet.level + poet.levelModifier + poet.waterAffinity) / 10 * (poet.essence / poet.maxEssence)); i++) {
            [character gainElementalProtection:kDivine];
        }
	}
}

@end

//
//  ThurisazAllCharacters.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/6/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "ThurisazAllCharacters.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleCharacter.h"
#import "BattleRanger.h"

@implementation ThurisazAllCharacters

+ (void)grantWoodShields {
    
    BattleRanger *ranger = [[GameController sharedGameController].battleCharacters objectForKey:@"BattleRanger"];
    
    for (AbstractBattleCharacter *character in [GameController sharedGameController].currentScene.activeEntities) {
		if ([character isKindOfClass:[AbstractBattleCharacter class]] && character.isAlive) {
			[character youReceivedShield:kWood];
		}
        for (int i = 1; i < ((ranger.level + ranger.levelModifier + ranger.woodAffinity) / 10 * (ranger.essence / ranger.maxEssence)); i++) {
            [character gainElementalProtection:kWood];
        }
	}
}

@end

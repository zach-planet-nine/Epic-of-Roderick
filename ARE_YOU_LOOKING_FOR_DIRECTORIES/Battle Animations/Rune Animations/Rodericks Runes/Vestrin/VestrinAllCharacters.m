//
//  VestrinAllCharacters.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/23/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "VestrinAllCharacters.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleCharacter.h"
#import "BattleRoderick.h"

@implementation VestrinAllCharacters

+ (void)grantSkyShields {
    
    BattleRoderick *roderick = [[GameController sharedGameController].battleCharacters objectForKey:@"BattleRoderick"];
    
    for (AbstractBattleCharacter *character in [GameController sharedGameController].currentScene.activeEntities) {
		if ([character isKindOfClass:[AbstractBattleCharacter class]] && character.isAlive) {
			[character youReceivedShield:kSky];
		}
        for (int i = 1; i < (roderick.level + roderick.levelModifier) / 10; i++) {
            [character gainElementalProtection:kSky];
        }
	}
}

@end

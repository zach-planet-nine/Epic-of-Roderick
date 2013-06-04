//
//  AkathAllCharacters.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/27/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "AkathAllCharacters.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleCharacter.h"
#import "BattleValkyrie.h"

@implementation AkathAllCharacters

+ (void)grantLifeShields {
    
    BattleValkyrie *valk = [[GameController sharedGameController].battleCharacters objectForKey:@"BattleValkyrie"];
    for (AbstractBattleCharacter *character in [GameController sharedGameController].currentScene.activeEntities) {
		if ([character isKindOfClass:[AbstractBattleCharacter class]] && character.isAlive) {
			[character youReceivedShield:kLife];
		}
        for (int i = 1; i < ((valk.level + valk.levelModifier) / 10 * (valk.essence / valk.maxEssence)); i++) {
            [character gainElementalProtection:kLife];
        }
	}
    
}

@end

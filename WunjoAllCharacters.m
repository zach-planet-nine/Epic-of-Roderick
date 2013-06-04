//
//  WunjoAllCharacters.m
//  TEORBattleTest
//
//  Created by Zach Babb on 6/2/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "WunjoAllCharacters.h"
#import "AbstractBattleCharacter.h"
#import "AbstractScene.h"
#import "GameController.h"

@implementation WunjoAllCharacters

+ (void)giveAllCharactersProtection {
	
	for (AbstractBattleCharacter *character in [GameController sharedGameController].currentScene.activeEntities) {
		if ([character isKindOfClass:[AbstractBattleCharacter class]]) {
			[character youReceivedShield:kDeath];
		}
	}
}

@end

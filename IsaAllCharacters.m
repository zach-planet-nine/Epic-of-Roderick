//
//  IsaAllCharacters.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/19/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "IsaAllCharacters.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleCharacter.h"
#import "BattleRoderick.h"

@implementation IsaAllCharacters

+ (void)grantWaterShields {
    
    BattleRoderick *roderick = [[GameController sharedGameController].battleCharacters objectForKey:@"BattleRoderick"];

    for (AbstractBattleCharacter *character in [GameController sharedGameController].currentScene.activeEntities) {
		if ([character isKindOfClass:[AbstractBattleCharacter class]] && character.isAlive) {
			[character youReceivedShield:kWater];
		}
        for (int i = 1; i < ((roderick.level + roderick.levelModifier + roderick.waterAffinity) / 10 * (roderick.essence / roderick.maxEssence)); i++) {
            [character gainElementalProtection:kWater];
        }
	}
}
@end

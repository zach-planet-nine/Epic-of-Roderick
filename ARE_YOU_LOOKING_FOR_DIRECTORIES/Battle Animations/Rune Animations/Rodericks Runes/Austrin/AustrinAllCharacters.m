//
//  AustrinAllCharacters.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/23/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "AustrinAllCharacters.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleCharacter.h"
#import "BattleRoderick.h"

@implementation AustrinAllCharacters

+ (void)healCharacterEssences {
    
    BattleRoderick *roderick = [[GameController sharedGameController].battleCharacters objectForKey:@"BattleRoderick"];
    for (AbstractBattleCharacter *character in [GameController sharedGameController].currentScene.activeEntities) {
        if ([character isKindOfClass:[AbstractBattleCharacter class]]) {
            [character youWereGivenEssence:(int)((10 + ((roderick.skyAffinity + roderick.affinity + roderick.affinityModifier) / 10)) * (roderick.essence / roderick.maxEssence))];
        }
    }
}


@end

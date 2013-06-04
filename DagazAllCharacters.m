//
//  DagazAllCharacters.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/9/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "DagazAllCharacters.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleCharacter.h"
#import "BattlePriest.h"
#import "DagazSingleCharacter.h"
#import "BattleStringAnimation.h"

@implementation DagazAllCharacters

+ (void)auraAllCharacters {
    
    BattlePriest *poet = [[GameController sharedGameController].battleCharacters objectForKey:@"BattlePriest"];
    for (AbstractBattleCharacter *character in [GameController sharedGameController].currentScene.activeEntities) {
        if ([character isKindOfClass:[AbstractBattleCharacter class]]) {
            if (RANDOM_0_TO_1() * 100 < (poet.poisonAffinity + character.poisonAffinity) * (poet.essence / poet.maxEssence) && character.isAlive) {
                DagazSingleCharacter *dsc = [[DagazSingleCharacter alloc] initToCharacter:character];
                [[GameController sharedGameController].currentScene addObjectToActiveObjects:dsc];
                [dsc release];
            } else {
                [BattleStringAnimation makeIneffectiveStringAt:character.renderPoint];
            }
        }
    }
}

@end

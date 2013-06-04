//
//  SudrinAllCharacters.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/22/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "SudrinAllCharacters.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleCharacter.h"
#import "BattleRoderick.h"
#import "BattleStringAnimation.h"

@implementation SudrinAllCharacters

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

+ (void)healAllCharacters {
    
    BattleRoderick *roderick = [[GameController sharedGameController].battleCharacters objectForKey:@"BattleRoderick"];
    for (AbstractBattleCharacter *character in [GameController sharedGameController].currentScene.activeEntities) {
        if ([character isKindOfClass:[AbstractBattleCharacter class]]) {
            [character youWereHealed:(int)(((roderick.affinity + roderick.affinityModifier) * 4) * ((roderick.skyAffinity + character.skyAffinity) / 10) * (roderick.essence / roderick.maxEssence))];
            character.endurance += (roderick.skyAffinity * (roderick.essence / roderick.maxEssence));
            character.essence += (roderick.skyAffinity * (roderick.essence / roderick.maxEssence));
            if (character.endurance > character.maxEndurance) {
                character.endurance = character.maxEndurance;
            }
            if (character.essence > character.maxEssence) {
                character.essence = character.maxEssence;
            }
            if (character.isAlive) {
                BattleStringAnimation *bsa = [[BattleStringAnimation alloc] initStatusString:@"Enduranced!" from:character.renderPoint];
                [[GameController sharedGameController].currentScene addObjectToActiveObjects:bsa];
                [bsa release];
                BattleStringAnimation *essenced = [[BattleStringAnimation alloc] initStatusString:@"Essenced!" from:character.renderPoint];
                [[GameController sharedGameController].currentScene addObjectToActiveObjects:essenced];
                [essenced release];

            }
        }
    }
}

@end

//
//  LaguzAllCharacters.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/7/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "LaguzAllCharacters.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleCharacter.h"
#import "LaguzSingleCharacter.h"

@implementation LaguzAllCharacters 

+ (void)healAllCharacters {
    
    for (AbstractBattleCharacter *character in [GameController sharedGameController].currentScene.activeEntities) {
        if ([character isKindOfClass:[AbstractBattleCharacter class]] && character.isAlive) {
            LaguzSingleCharacter *lsc = [[LaguzSingleCharacter alloc] initToCharacter:character];
            [[GameController sharedGameController].currentScene addObjectToActiveObjects:lsc];
            [lsc release];
        }
    }
}

@end

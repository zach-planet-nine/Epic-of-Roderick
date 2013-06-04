//
//  DaleythAllCharacters.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/29/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "DaleythAllCharacters.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "BattleWizard.h"
#import "Textbox.h"

@implementation DaleythAllCharacters

+ (void)accelerateTime {
    
    BattleWizard *wizard = [[GameController sharedGameController].battleCharacters objectForKey:@"BattleWizard"];
    [wizard accelerateTime];
    Textbox *tb = [[Textbox alloc] initWithRect:CGRectMake(90, 0, 300, 60) color:Color4fMake(0.3, 0.3, 0.3, 0.9) duration:1.5 animating:NO text:@"Wizard: I feel time flowing faster..."];
    [[GameController sharedGameController].currentScene addObjectToActiveObjects:tb];
    [tb release];
}

@end

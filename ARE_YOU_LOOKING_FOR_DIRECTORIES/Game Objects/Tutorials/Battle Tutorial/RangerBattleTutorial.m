//
//  RangerBattleTutorial.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 8/9/11.
//  Copyright (c) 2011 InstantLazer. All rights reserved.
//

#import "RangerBattleTutorial.h"
#import "GameController.h"
#import "ScriptReader.h"
#import "AbstractScene.h"
#import "BattleRanger.h"
#import "Character.h"
#import "InputManager.h"
#import "AbstractBattleEnemy.h"
#import "Primitives.h"

@implementation RangerBattleTutorial

- (void)dealloc {

    [super dealloc];
}

+ (void)loadRangerBattleTutorial {
    RangerBattleTutorial *rbt = [[RangerBattleTutorial alloc] init];
    [[GameController sharedGameController].currentScene addObjectToActiveObjects:rbt];
    [rbt release];
}

+ (void)reloadRangerBattleTutorial {
    RangerBattleTutorial *rbt = [[RangerBattleTutorial alloc] init];
    rbt.replay = YES;
    [[GameController sharedGameController].currentScene addObjectToActiveObjects:rbt];
    [rbt release];
}

- (id)init {
    
    self = [super init];
    if (self) {
        
        sharedGameController = [GameController sharedGameController];
        ranger = [sharedGameController.battleCharacters objectForKey:@"BattleRanger"];
        NSMutableArray *oldParty = [[NSMutableArray alloc] initWithArray:sharedGameController.party];
        NSMutableArray *newParty = [[NSMutableArray alloc] initWithArray:sharedGameController.party];
        Character *range = [sharedGameController.characters objectForKey:@"Ranger"];
        [newParty replaceObjectAtIndex:2 withObject:range];
        sharedGameController.party = newParty;
        originalRealm = sharedGameController.realm;
        sharedGameController.realm = kRealm_RangerBattleTutorial;
        [sharedGameController.currentScene initBattle];
        sharedGameController.party = oldParty;
        [oldParty release];
        [newParty release];
        [sharedScriptReader createTutorial:5];
        stage = 0;
    }
    return self;
}

- (void)render {
    
    if (stage == 3) {
        for (AbstractBattleEntity *entity in sharedGameController.currentScene.activeEntities) {
            if ([entity isKindOfClass:[AbstractBattleEntity class]]) {
                drawRect([entity getRect]);
            }
        }
        drawRect(CGRectMake(1, 1, 279, 319));
        drawRect(CGRectMake(281, 1, 279, 319));
    }
}

- (void)advance {
    switch (stage) {
        case 0:
            stage++;
            [[GameController sharedGameController].currentScene removeTextbox];
            [sharedScriptReader advanceTutorial];
            [ranger gainPriority];
            [[InputManager sharedInputManager] setState:kRanger];
            break;
        case 1:
            stage++;
            [sharedScriptReader advanceTutorial];
            break;
        case 2:
            stage++;
            [sharedScriptReader advanceTutorial];
            break;
            
            
        default:
            break;
    }
}

- (void)endTutorial {

    if (!replay) {
        sharedGameController.realm = originalRealm;
        [sharedGameController.currentScene removeTextbox];
        [[InputManager sharedInputManager] setState:kNoOnesTurn];
        for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
            if ([enemy isKindOfClass:[AbstractBattleEnemy class]]) {
                enemy.hp = 100;
            }
        }
    } else {
        sharedGameController.realm = originalRealm;
        [sharedGameController.currentScene restoreMap];
    }
}

@end

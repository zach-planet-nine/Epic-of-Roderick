//
//  RoderickBattleTutorial.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 8/9/11.
//  Copyright (c) 2011 InstantLazer. All rights reserved.
//

#import "RoderickBattleTutorial.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleEnemy.h"
#import "BattleRoderick.h"
#import "ScriptReader.h"
#import "InputManager.h"

@implementation RoderickBattleTutorial

- (void)dealloc {
    
    [super dealloc];
}

+ (void)loadRoderickBattleTutorial {
    RoderickBattleTutorial *rbt = [[RoderickBattleTutorial alloc] init];
    [[GameController sharedGameController].currentScene addObjectToActiveObjects:rbt];
    [rbt release];
}

+ (void)reloadRoderickBattleTutorial {
    RoderickBattleTutorial *rbt = [[RoderickBattleTutorial alloc] init];
    rbt.replay = YES;
    [[GameController sharedGameController].currentScene addObjectToActiveObjects:rbt];
    [rbt release];
}

- (id)init {
    self = [super init];
    if (self) {
        sharedGameController = [GameController sharedGameController];
        roderick = [sharedGameController.battleCharacters objectForKey:@"BattleRoderick"];
        originalRealm = [GameController sharedGameController].realm;
        [GameController sharedGameController].realm = kRealm_ChapterOneCamp;
        [[GameController sharedGameController].currentScene initBattle];
        for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
            if ([enemy isKindOfClass:[AbstractBattleEnemy class]]) {
                abe = enemy;
            }
        }
        [sharedScriptReader createTutorial:2];
        stage = 0;
        active = YES;
    }
    return self;
}

- (void)advance {
    switch (stage) {
        case 0:
            stage++;
            [sharedScriptReader advanceTutorial];
            [[InputManager sharedInputManager] setStateTutorialMustTapRect:[roderick getRect]];
            break;
        case 1:
            stage++;
            [sharedScriptReader advanceTutorial];
            /*AbstractBattleEnemy *abe;
            for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
                if ([enemy isKindOfClass:[AbstractBattleEnemy class]]) {
                    abe = enemy;
                }
            }*/
            [[InputManager sharedInputManager] setStateTutorialMustTapRect:[abe getRect]];
            break;
        case 2:
            stage++;
            [sharedScriptReader advanceTutorial];
            /*AbstractBattleEnemy *abe2;
            for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
                if ([enemy isKindOfClass:[AbstractBattleEnemy class]]) {
                    abe2 = enemy;
                }
            }*/
            [roderick youAttackedEnemy:abe];
            break;
            
        default:
            break;
    }
}

- (void)endTutorial {
    [[GameController sharedGameController].currentScene removeTextbox];
    active = NO;
    if (!replay) {
        [[InputManager sharedInputManager] setState:kRoderick];
    } else {
        [sharedGameController.currentScene restoreMap];
    }
}

@end

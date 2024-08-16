//
//  RoderickBattleTutorial.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 8/9/11.
//  Copyright (c) 2011 InstantLazer. All rights reserved.
//

#import "AbstractGameTutorial.h"

@class BattleSwordMan;
@class BattleRoderick;
@class GameController;
@class AbstractBattleEnemy;

@interface RoderickBattleTutorial : AbstractGameTutorial {
    
    int originalRealm;
    BattleRoderick *roderick;
    GameController *sharedGameController;
    AbstractBattleEnemy *abe;
    
}

+ (void)loadRoderickBattleTutorial;

+ (void)reloadRoderickBattleTutorial;

@end

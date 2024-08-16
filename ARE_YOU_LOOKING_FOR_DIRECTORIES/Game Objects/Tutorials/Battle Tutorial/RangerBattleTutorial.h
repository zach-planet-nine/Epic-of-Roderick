//
//  RangerBattleTutorial.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 8/9/11.
//  Copyright (c) 2011 InstantLazer. All rights reserved.
//

#import "AbstractGameTutorial.h"

@class BattleRanger;
@class GameController;

@interface RangerBattleTutorial : AbstractGameTutorial {
    
    int originalRealm;
    BattleRanger *ranger;
    GameController *sharedGameController;
    
}

+ (void)loadRangerBattleTutorial;

+ (void)reloadRangerBattleTutorial;

@end

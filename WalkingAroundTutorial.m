//
//  WalkingAroundTutorial.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 8/9/11.
//  Copyright (c) 2011 InstantLazer. All rights reserved.
//

#import "WalkingAroundTutorial.h"
#import "GameController.h"
#import "AbstractEntity.h"
#import "ScriptReader.h"
#import "AbstractScene.h"

@implementation WalkingAroundTutorial

- (void)dealloc {
    [super dealloc];
}

+ (void)loadWalkingAroundTutorial {
    WalkingAroundTutorial *wat = [[WalkingAroundTutorial alloc] init];
    [[GameController sharedGameController].currentScene addObjectToActiveObjects:wat];
    [wat release];
}

+ (void)reloadWalkingAroundTutorial {
    WalkingAroundTutorial *wat = [[WalkingAroundTutorial alloc] init];
    wat.replay = YES;
    [[GameController sharedGameController].currentScene addObjectToActiveObjects:wat];
    [wat release];
}

- (id)init {
    
    self = [super init];
    if (self) {
        [[GameController sharedGameController].player stopMoving];
        stage = 0;
        [sharedScriptReader createTutorial:1];
        duration = -1;
        active = YES;
    }
    return self;
}


- (void)advance {
    [sharedScriptReader advanceTutorial];
}

- (void)endTutorial {
    [[GameController sharedGameController].currentScene removeTextbox];
    active = NO;
    if (!replay) {
        [[GameController sharedGameController].currentScene moveToNextStageInScene];
    }
}

@end

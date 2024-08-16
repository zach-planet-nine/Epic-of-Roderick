//
//  Teleportal.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/26/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "Teleportal.h"
#import "InputManager.h"
#import "FadeInOrOut.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractEntity.h"

@implementation Teleportal

- (void)dealloc {
    
    [super dealloc];
}

+ (void)teleportalToTile:(CGPoint)aTile {
    
    Teleportal *tele = [[Teleportal alloc] initTeleportalToTile:aTile];
    [[GameController sharedGameController].currentScene addObjectToActiveObjects:tele];
    [tele release];
}

- (id)initTeleportalToTile:(CGPoint)aTile
{
    self = [super init];
    if (self) {
        [[InputManager sharedInputManager] setState:kNoTouchesAllowed];
        [FadeInOrOut fadeOutWithDuration:0.5];
        tile = aTile;
        duration = 0.5;
        stage = 0;
        active = YES;
    }
    
    return self;
}

- (void)updateWithDelta:(float)aDelta {
    
    if (active) {
        duration -= aDelta;
        if (duration < 0) {
            switch (stage) {
                case 0:
                    stage++;
                    [[GameController sharedGameController].player teleportToTile:tile];
                    [[GameController sharedGameController].currentScene checkForPortal];
                    [FadeInOrOut fadeInWithDuration:0.5];
                    duration = 0.5;
                    break;
                case 1:
                    stage++;
                    duration = 1;
                    [[InputManager sharedInputManager] setState:kWalkingAround_NoTouches];
                    break;
                case 2:
                    stage++;
                    active = NO;
                    break;
                default:
                    break;
            }
        }
    }
}

@end

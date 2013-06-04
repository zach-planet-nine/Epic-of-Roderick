//
//  Bleeder.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/7/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "Bleeder.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleEntity.h"

@implementation Bleeder

- (void)dealloc {
    
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (id)initWithTarget:(AbstractBattleEntity *)aEntity withDuration:(float)aDuration {
    
    self = [super init];
    if (self) {
        target1 = aEntity;
        [target1 addBleeder];
        stage = 0;
        duration = aDuration;
        active = YES;
    }
    return self;
}

+ (void)addBleederTo:(AbstractBattleEntity *)aEntity withDuration:(float)aDuration {
    
    if (aDuration <= 0) {
        return;
    }
    Bleeder *bleeder = [[Bleeder alloc] initWithTarget:aEntity withDuration:aDuration];
    [[GameController sharedGameController].currentScene addObjectToActiveObjects:bleeder];
    [bleeder release];
}

- (void)updateWithDelta:(float)aDelta {
    
    if (active) {
        duration -= aDelta;
        if (duration < 0) {
            switch (stage) {
                case 0:
                    stage++;
                    [target1 removeBleeder];
                    duration = 1;
                    break;
                case 1:
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

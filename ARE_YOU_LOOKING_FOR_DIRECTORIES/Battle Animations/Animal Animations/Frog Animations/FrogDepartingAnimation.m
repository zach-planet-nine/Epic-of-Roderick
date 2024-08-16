//
//  FrogDepartingAnimation.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/6/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "FrogDepartingAnimation.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "Frog.h"
#import "Image.h"

@implementation FrogDepartingAnimation

- (void)dealloc {
    
    [super dealloc];
}

- (id)initFrom:(Frog *)aFrog
{
    self = [super init];
    if (self) {
        
        frog = aFrog;
        [sharedGameController.currentScene addEntityToActiveEntities:frog];
        [frog hopToPoint:CGPointMake(240, 160)];
        stage = 0;
        duration = 0.3;
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
                    [frog hopToPoint:CGPointMake(360, 240)];
                    duration = 0.3;
                    break;
                case 1:
                    stage++;
                    [frog hopToPoint:CGPointMake(480, 320)];
                    duration = 0.3;
                    break;
                case 2:
                    stage++;
                    [frog hopToPoint:CGPointMake(600, 500)];
                    duration = 0.3;
                    break;
                case 3:
                    stage++;
                    active = NO;
                    [sharedGameController.currentScene.activeEntities removeObject:frog];
                    break;
                    
                default:
                    break;
            }
        }
        frog.defaultImage.color = Color4fMake(1, 1, 1, frog.defaultImage.color.alpha - aDelta);
    }
}

@end

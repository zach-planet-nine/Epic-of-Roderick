//
//  HawkCatchArrow.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 8/10/11.
//  Copyright (c) 2011 InstantLazer. All rights reserved.
//

#import "HawkCatchArrow.h"
#import "Hawk.h"
#import "GameController.h"
#import "AbstractScene.h"

@implementation HawkCatchArrow

- (void)dealloc {
    [super dealloc];
}

+ (void)hawk:(Hawk *)aHawk CatchArrowAt:(CGPoint)aPoint {
    HawkCatchArrow *hca = [[HawkCatchArrow alloc] initCatchArrowAt:aPoint fromHawk:aHawk];
    [[GameController sharedGameController].currentScene addObjectToActiveObjects:hca];
    [hca release];
}

- (id)initCatchArrowAt:(CGPoint)aPoint fromHawk:(Hawk *)aHawk {
    
    self = [super init];
    if (self) {
        hawk = aHawk;
        velocity = Vector2fMake((aPoint.x - hawk.renderPoint.x) / 0.15, (aPoint.y - hawk.renderPoint.y) / 0.15);
        stage = 0;
        duration = 0.15;
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
                    velocity = Vector2fMake(velocity.x * -1, velocity.y * -1);
                    duration = 0.15;
                    break;
                case 1:
                    stage++;
                    hawk.renderPoint = CGPointMake(180, 160);
                    duration = 0.5;
                    break;
                case 2:
                    stage++;
                    active = NO;
                    
                default:
                    break;
            }
        }
        if (stage < 2) {
            Vector2f temp = Vector2fMultiply(velocity, aDelta);
            hawk.renderPoint = CGPointMake(hawk.renderPoint.x + temp.x, hawk.renderPoint.y + temp.y);
        }
    }
}

@end

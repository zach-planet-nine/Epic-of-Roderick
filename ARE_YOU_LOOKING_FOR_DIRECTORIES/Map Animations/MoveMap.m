//
//  MoveMap.m
//  TEORCutSceneTest
//
//  Created by Zach Babb on 5/22/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "MoveMap.h"
#import "GameController.h"
#import "AbstractScene.h"


@implementation MoveMap

- (void)dealloc {
	
	[super dealloc];
}

- (id)initMoveFromMapXY:(CGPoint)aFromPoint to:(CGPoint)aToPoint withDuration:(float)aDuration {
	
	if (self = [super init]) {
		fromPoint = aFromPoint;
		toPoint = aToPoint;
		duration = aDuration;
		
		velocity = Vector2fMake((toPoint.x - fromPoint.x) / duration, (toPoint.y - fromPoint.y) / duration);
		
		sharedGameController = [GameController sharedGameController];
        active = YES;
	}
	
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
    if (active) {
        fromPoint.x += velocity.x * aDelta;
        fromPoint.y += velocity.y * aDelta;
        duration -= aDelta;
        
        if (duration < 0) {
            duration == 0;
            fromPoint = toPoint;
            active = NO;
        }
        
        [[sharedGameController currentScene] setCameraPosition:fromPoint];

    }
    
}

- (void)render {
}


@end

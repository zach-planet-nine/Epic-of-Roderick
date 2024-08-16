//
//  TargetObject.h
//  TEORBattleTest
//
//  Created by Zach Babb on 5/27/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractGameObject.h"

@class Image;
@class GameController;
@class TouchManager;

@interface TargetObject : AbstractGameObject {

	TouchManager *sharedTouchManager;
	Image *target;
	CGPoint renderPoint;
	GameController *sharedGameController;
	
}

@property (nonatomic, assign) CGPoint renderPoint;

- (void)updateLocationWithAccelerationX:(float)aAccelerationX andAccelerationY:(float)aAccelerationY;

@end

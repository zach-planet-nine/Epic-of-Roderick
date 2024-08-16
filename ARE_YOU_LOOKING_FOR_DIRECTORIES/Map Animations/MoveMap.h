//
//  MoveMap.h
//  TEORCutSceneTest
//
//  Created by Zach Babb on 5/22/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractGameObject.h"
#import "Global.h"


@class GameController;

@interface MoveMap : AbstractGameObject {
	
	GameController *sharedGameController;
	CGPoint fromPoint;
	CGPoint toPoint;
	Vector2f velocity;
}

- (id)initMoveFromMapXY:(CGPoint)aFromPoint to:(CGPoint)aToPoint withDuration:(float)aDuration;

- (void)updateWithDelta:(float)aDelta;

- (void)render;

@end

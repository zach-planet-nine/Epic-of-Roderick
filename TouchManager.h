//
//  TouchManager.h
//  TEORBattleTest
//
//  Created by Zach Babb on 5/21/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AbstractScene;
@class GameController;

@interface TouchManager : NSObject {
	
	GameController *sharedGameController;
	int state;
	int drawingHash;
	bool isTouchDrawing;
	CGPoint previousLocation;
	int previousDirection;
	int touchDirection;
	int drawCounter;
	int drawingImageIndex;
	int countIt;
	int inEnemyRect;
	int notInEnemyRect;
	int gestureCounter;
	int walkingRightTouchHash;
	int walkingLeftTouchHash;
	int entityTouchHash;
	CGPoint leftTouchLocation;
	CGPoint rightTouchLocation;
}

@property (nonatomic, assign) int state;

+ (TouchManager *)sharedTouchManager;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event view:(UIView *)aView sender:(AbstractScene *)aScene;

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event view:(UIView *)aView sender:(AbstractScene *)aScene;

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event view:(UIView *)aView sender:(AbstractScene *)aScene;

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event view:(UIView *)aView sender:(AbstractScene *)aScene;

- (void)setState:(int)aState;

- (void)updatePlayerMovementWithLeftTouchLocation:(CGPoint)aLeftPoint andRightTouchLocation:(CGPoint)aRightTouchLocation;

@end

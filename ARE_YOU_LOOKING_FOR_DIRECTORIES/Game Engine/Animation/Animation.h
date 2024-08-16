//
//  Animation.h
//  TEORBattleTest
//
//  Created by Zach Babb on 5/21/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Global.h"

enum {
	kAnimationState_Running = 0,
	kAnimationState_Stopped = 1
};

enum {
	kAnimationType_Repeating = 0,
	kAnimationType_PingPong = 1,
	kAnimationType_Once = 2
};


@interface Animation : NSObject {
	
	NSUInteger state;
	NSUInteger type;
	NSInteger direction;
	NSUInteger maxFrames;
	NSInteger currentFrame;
	AnimationFrame *frames;
	float displayTime;
	NSInteger frameCount;
	NSUInteger bounceFrame;
	CGPoint renderPoint;
}

@property (nonatomic, assign) NSUInteger state;
@property (nonatomic, assign) NSUInteger type;
@property (nonatomic, assign) NSInteger currentFrame;
@property (nonatomic, assign) NSUInteger bounceFrame;
@property (nonatomic, assign, readonly) NSInteger direction;
@property (nonatomic, assign, readonly) NSUInteger maxFrames;
@property (nonatomic, assign) NSInteger frameCount;
@property (nonatomic, assign) CGPoint renderPoint;

- (id)init;

- (void)addFrameWithImage:(Image *)aImage delay:(float)aDelay;

- (void)updateWithDelta:(float)aDelta;

- (Image *)currentFrameImage;

- (Image *)imageForFrame:(NSUInteger)aIndex;

- (void)rotationPoint:(CGPoint)aPoint;

- (void)renderAtPoint:(CGPoint)aPoint;

- (void)renderAtPoint:(CGPoint)aPoint scale:(Scale2f)aScale rotation:(float)aRotation;

- (void)renderCenteredAtPoint:(CGPoint)aPoint;

- (void)renderCenteredAtPoint:(CGPoint)aPoint scale:(Scale2f)aScale rotation:(float)aRotation;

- (void)render;

@end

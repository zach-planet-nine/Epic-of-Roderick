//
//  Animation.m
//  TEORBattleTest
//
//  Created by Zach Babb on 5/21/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "Animation.h"
#import "Image.h"
#import "SpriteSheet.h"


@implementation Animation

@synthesize state;
@synthesize type;
@synthesize direction;
@synthesize currentFrame;
@synthesize maxFrames;
@synthesize bounceFrame;
@synthesize frameCount;
@synthesize renderPoint;

- (void)dealloc {
	
	if (frames) {
		for (int i = 0; i < frameCount; i++) {
			AnimationFrame *frame = &frames[i];
			[frame->image release];
		}
		free(frames);
	}
	[super dealloc];
}

- (id)init {
	if (self = [super init]) {
		maxFrames = 5;
		frameCount = 0;
		currentFrame = 0;
		state = kAnimationState_Stopped;
		type = kAnimationType_Once;
		direction = 1;
		bounceFrame = -1;
		
		frames = calloc(maxFrames, sizeof(AnimationFrame));
	}
	return self;	
}

#define FRAMES_TO_EXTEND 5

- (void)addFrameWithImage:(Image *)aImage delay:(float)aDelay {
	
	if (frameCount + 1 > maxFrames) {
		maxFrames += FRAMES_TO_EXTEND;
		frames = realloc(frames, sizeof(AnimationFrame) * maxFrames);
	}
	
	frames[frameCount].image = [aImage retain];
	frames[frameCount].delay = aDelay;
	
	frameCount++;
}

- (void)updateWithDelta:(float)aDelta {
	
	if (state != kAnimationState_Running) {
		return;
	}
	
	displayTime += aDelta;
	
	if (displayTime > frames[currentFrame].delay) {
		
		currentFrame += direction;
		displayTime -= frames[currentFrame].delay;
		////NSLog(@"displayTime is: %f and currentFrame is: %d", displayTime, currentFrame);
		
		if (type == kAnimationType_PingPong && (currentFrame == 0 || currentFrame == frameCount - 1 || currentFrame == bounceFrame)) {
			direction = -direction;
		} else if (currentFrame > frameCount - 1 || currentFrame == bounceFrame) {
			if (type != kAnimationType_Repeating) {
				currentFrame -= 1;
				state = kAnimationState_Stopped;
			} else {
				currentFrame = 0;
				displayTime -= frames[currentFrame].delay;
			}
		}
	}
}

- (Image *)currentFrameImage {
	return frames[currentFrame].image;
}

- (Image *)imageForFrame:(NSUInteger)aIndex {
	if (aIndex > frameCount) {
		return nil;
	}
	return frames[aIndex].image;
}

- (void)rotationPoint:(CGPoint)aPoint {
	for (int i = 0; i < frameCount; i++) {
		[frames[i].image setRotationPoint:aPoint];
	}
}

- (void)setRotation:(float)aRotation {
	for (int i = 0; i < frameCount; i++) {
		[frames[i].image setRotation:aRotation];
	}
}

- (void)renderAtPoint:(CGPoint)aPoint {
	[self renderAtPoint:aPoint scale:frames[currentFrame].image.scale rotation:frames[currentFrame].image.rotation];
}

- (void)renderAtPoint:(CGPoint)aPoint scale:(Scale2f)aScale rotation:(float)aRotation {
	[frames[currentFrame].image renderAtPoint:aPoint scale:aScale rotation:aRotation];
}

- (void)renderCenteredAtPoint:(CGPoint)aPoint {
	[self renderCenteredAtPoint:aPoint scale:frames[currentFrame].image.scale rotation:frames[currentFrame].image.rotation];
}

- (void)renderCenteredAtPoint:(CGPoint)aPoint scale:(Scale2f)aScale rotation:(float)aRotation {
	[frames[currentFrame].image renderCenteredAtPoint:aPoint scale:aScale rotation:aRotation];
}

- (void)render {
	[self renderCenteredAtPoint:CGPointMake(240, 160)];
}

@end

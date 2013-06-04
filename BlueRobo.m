//
//  BlueRobo.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 5/26/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "BlueRobo.h"
#import "Textbox.h"
#import "TouchManager.h"
#import "InputManager.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "SpriteSheet.h"
#import "Image.h"
#import "Animation.h"


@implementation BlueRobo

- (id)initAtLocation:(CGPoint)aLocation {
	
	if (self = [super init]) {
		SpriteSheet *roderickSheet = [[SpriteSheet alloc] initWithImageNamed:@"RoderickSpriteSheet30x40.png" spriteSize:CGSizeMake(30, 40) spacing:10 margin:0 imageFilter:GL_LINEAR];
		float delay = 0.14;
		
		[leftAnimation addFrameWithImage:[roderickSheet spriteImageAtCoords:CGPointMake(4, 3)] delay:delay];
		[leftAnimation addFrameWithImage:[roderickSheet spriteImageAtCoords:CGPointMake(5, 3)] delay:delay];
		[leftAnimation addFrameWithImage:[roderickSheet spriteImageAtCoords:CGPointMake(6, 3)] delay:delay];
		[leftAnimation addFrameWithImage:[roderickSheet spriteImageAtCoords:CGPointMake(7, 3)] delay:delay];
		
		[rightAnimation addFrameWithImage:[roderickSheet spriteImageAtCoords:CGPointMake(4, 2)] delay:delay];
		[rightAnimation addFrameWithImage:[roderickSheet spriteImageAtCoords:CGPointMake(5, 2)] delay:delay];
		[rightAnimation addFrameWithImage:[roderickSheet spriteImageAtCoords:CGPointMake(6, 2)] delay:delay];
		[rightAnimation addFrameWithImage:[roderickSheet spriteImageAtCoords:CGPointMake(7, 2)] delay:delay];
		
		[upAnimation addFrameWithImage:[roderickSheet spriteImageAtCoords:CGPointMake(4, 1)] delay:delay];
		[upAnimation addFrameWithImage:[roderickSheet spriteImageAtCoords:CGPointMake(5, 1)] delay:delay];
		[upAnimation addFrameWithImage:[roderickSheet spriteImageAtCoords:CGPointMake(6, 1)] delay:delay];
		[upAnimation addFrameWithImage:[roderickSheet spriteImageAtCoords:CGPointMake(7, 1)] delay:delay];
		
		[downAnimation addFrameWithImage:[roderickSheet spriteImageAtCoords:CGPointMake(4, 0)] delay:delay];
		[downAnimation addFrameWithImage:[roderickSheet spriteImageAtCoords:CGPointMake(5, 0)] delay:delay];
		[downAnimation addFrameWithImage:[roderickSheet spriteImageAtCoords:CGPointMake(6, 0)] delay:delay];
		[downAnimation addFrameWithImage:[roderickSheet spriteImageAtCoords:CGPointMake(7, 0)] delay:delay];
		
		
		leftAnimation.state = kAnimationState_Running;
		leftAnimation.type = kAnimationType_Repeating;
		rightAnimation.state = kAnimationState_Running;
		rightAnimation.type = kAnimationType_Repeating;
		upAnimation.state = kAnimationState_Running;
		upAnimation.type = kAnimationType_Repeating;
		downAnimation.state = kAnimationState_Running;
		downAnimation.type = kAnimationType_Repeating;
		currentAnimation.state = kAnimationState_Stopped;
		currentAnimation.type = kAnimationType_Repeating;
		
		//NSLog(@"CurrentAnimation framecount is: %d.", currentAnimation.frameCount);
		currentAnimation = leftAnimation;
		//NSLog(@"CurrentAnimation framecount is: %d.", currentAnimation.frameCount);
		movementSpeed = 65;
		destination = CGPointMake(aLocation.x + 200, aLocation.y);
		[self moveToPoint:destination duration:3.0];
		currentAnimation = rightAnimation;
		
	}
	return self;
}	

- (void)updateWithDelta:(float)aDelta {
	
	[super updateWithDelta:aDelta];
	if (moving == kNotMoving && stage != 5) {
		stage++;
		//NSLog(@"Setting new destination with stage: %d.", stage);
		switch (stage) {
			case 1:
				destination = CGPointMake(currentLocation.x, currentLocation.y - 200);
				[self moveToPoint:destination duration:3.0];
				break;
			case 2:
				destination = CGPointMake(currentLocation.x - 200, currentLocation.y);
				[self moveToPoint:destination duration:3.0];
				break;
			case 3:
				destination = CGPointMake(currentLocation.x, currentLocation.y + 200);
				[self moveToPoint:destination duration:3.0];
				break;
			case 4:
				destination = CGPointMake(currentLocation.x + 200, currentLocation.y);
				[self moveToPoint:destination duration:3.0];
				stage = 0;
				break;
			default:
				break;
		}
	}
	if (stage == 5 && sharedTouchManager.state != kWalkingAround_TextboxOnScreen) {
		stage = previousStage;
		moving = kMovingAutomated;
		switch (stage) {
			case 0:
				[self faceRight];
				break;
			case 1:
				[self faceDown];
				break;
			case 2:
				[self faceLeft];
				break;
			case 3:
				[self faceUp];
				break;
			default:
				break;
		}
	}
}

- (void)youWereTapped {
	
	previousStage = stage;
	stage = 5;
	Textbox *tb = [[Textbox alloc] initWithRect:CGRectMake(0, 0, 480, 100) color:Color4fMake(0.0, 0.0, 1.0, 0.5) duration:-1 animating:YES text:@"Hello yellow Robot."];
	[sharedGameController.currentScene addObjectToActiveObjects:tb];
	[[InputManager sharedInputManager] setState:kWalkingAround_TextboxOnScreen];
	[self facePlayerAndStop];
	[tb release];
}

@end

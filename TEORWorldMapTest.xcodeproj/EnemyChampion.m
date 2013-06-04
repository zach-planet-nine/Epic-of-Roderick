//
//  EnemyChampion.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/10/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "EnemyChampion.h"
#import "Textbox.h"
#import "TouchManager.h"
#import "InputManager.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "PackedSpriteSheet.h"
#import "SpriteSheet.h"
#import "Image.h"
#import "Animation.h"

@implementation EnemyChampion

- (id)initAtLocation:(CGPoint)aLocation {
	
	if (self = [super init]) {
        PackedSpriteSheet *pss = [[PackedSpriteSheet alloc] initWithImageNamed:@"TEORNPCSpriteSheets.png" controlFile:@"TEORNPCSpriteSheets" filter:GL_LINEAR];
		SpriteSheet *ecSheet = [SpriteSheet spriteSheetForImage:[pss imageForKey:@"EnemyChampion.png"] sheetKey:@"EnemyChampion.png" spriteSize:CGSizeMake(30, 40) spacing:10 margin:0]; 
		float delay = 0.14;
		
		[leftAnimation addFrameWithImage:[ecSheet spriteImageAtCoords:CGPointMake(0, 2)] delay:delay];
		[leftAnimation addFrameWithImage:[ecSheet spriteImageAtCoords:CGPointMake(1, 2)] delay:delay];
		[leftAnimation addFrameWithImage:[ecSheet spriteImageAtCoords:CGPointMake(2, 2)] delay:delay];
		[leftAnimation addFrameWithImage:[ecSheet spriteImageAtCoords:CGPointMake(3, 2)] delay:delay];
		
		[rightAnimation addFrameWithImage:[ecSheet spriteImageAtCoords:CGPointMake(0, 3)] delay:delay];
		[rightAnimation addFrameWithImage:[ecSheet spriteImageAtCoords:CGPointMake(1, 3)] delay:delay];
		[rightAnimation addFrameWithImage:[ecSheet spriteImageAtCoords:CGPointMake(2, 3)] delay:delay];
		[rightAnimation addFrameWithImage:[ecSheet spriteImageAtCoords:CGPointMake(3, 3)] delay:delay];
		
		[upAnimation addFrameWithImage:[ecSheet spriteImageAtCoords:CGPointMake(0, 0)] delay:delay];
		[upAnimation addFrameWithImage:[ecSheet spriteImageAtCoords:CGPointMake(1, 0)] delay:delay];
		[upAnimation addFrameWithImage:[ecSheet spriteImageAtCoords:CGPointMake(2, 0)] delay:delay];
		[upAnimation addFrameWithImage:[ecSheet spriteImageAtCoords:CGPointMake(3, 0)] delay:delay];
		
		[downAnimation addFrameWithImage:[ecSheet spriteImageAtCoords:CGPointMake(0, 1)] delay:delay];
		[downAnimation addFrameWithImage:[ecSheet spriteImageAtCoords:CGPointMake(1, 1)] delay:delay];
		[downAnimation addFrameWithImage:[ecSheet spriteImageAtCoords:CGPointMake(2, 1)] delay:delay];
		[downAnimation addFrameWithImage:[ecSheet spriteImageAtCoords:CGPointMake(3, 1)] delay:delay];
		
        [pss release];
		
		leftAnimation.state = kAnimationState_Stopped;
		leftAnimation.type = kAnimationType_Repeating;
		rightAnimation.state = kAnimationState_Stopped;
		rightAnimation.type = kAnimationType_Repeating;
		upAnimation.state = kAnimationState_Stopped;
		upAnimation.type = kAnimationType_Repeating;
		downAnimation.state = kAnimationState_Stopped;
		downAnimation.type = kAnimationType_Repeating;
		currentAnimation.state = kAnimationState_Stopped;
		currentAnimation.type = kAnimationType_Repeating;
		
		//NSLog(@"CurrentAnimation framecount is: %d.", currentAnimation.frameCount);
		currentAnimation = leftAnimation;
		//NSLog(@"CurrentAnimation framecount is: %d.", currentAnimation.frameCount);
		movementSpeed = 65;
        stage = 6;
		currentAnimation = rightAnimation;
        currentLocation = aLocation;
		
	}
	return self;
}	

- (void)updateWithDelta:(float)aDelta {
	
	[super updateWithDelta:aDelta];
	if (moving == kNotMoving && stage != 5 && stage != 6) {
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
	Textbox *tb = [[Textbox alloc] initWithRect:CGRectMake(0, 0, 480, 100) color:Color4fMake(0.0, 0.0, 1.0, 0.5) duration:-1 animating:YES text:@"I shall defeatest you!!! BWAHAHAHAHAHA!"];
	[sharedGameController.currentScene addObjectToActiveObjects:tb];
	[[InputManager sharedInputManager] setState:kWalkingAround_TextboxOnScreen];
	[self facePlayerAndStop];
	[tb release];
}

@end

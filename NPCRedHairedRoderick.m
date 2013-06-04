//
//  NPCRedHairedRoderick.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/10/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "NPCRedHairedRoderick.h"
#import "Textbox.h"
#import "TouchManager.h"
#import "InputManager.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "PackedSpriteSheet.h"
#import "SpriteSheet.h"
#import "Image.h"
#import "Animation.h"

@implementation NPCRedHairedRoderick

- (id)initAtLocation:(CGPoint)aLocation {
	
	if (self = [super init]) {
      
        SpriteSheet *rhrSheet = [SpriteSheet spriteSheetForImage:[[PackedSpriteSheet packedSpriteSheetForImageNamed:@"TEORNPCSpriteSheets.png" controlFile:@"TEORNPCSpriteSheets" imageFilter:GL_LINEAR] imageForKey:@"RedHairedRoderickRevised.png"] sheetKey:@"RedHairedRoderickRevised.png" spriteSize:CGSizeMake(30, 40) spacing:10 margin:0];
		float delay = 0.14;
		
		[leftAnimation addFrameWithImage:[rhrSheet spriteImageAtCoords:CGPointMake(0, 2)] delay:delay];
		[leftAnimation addFrameWithImage:[rhrSheet spriteImageAtCoords:CGPointMake(1, 2)] delay:delay];
		[leftAnimation addFrameWithImage:[rhrSheet spriteImageAtCoords:CGPointMake(2, 2)] delay:delay];
		[leftAnimation addFrameWithImage:[rhrSheet spriteImageAtCoords:CGPointMake(3, 2)] delay:delay];
		
		[rightAnimation addFrameWithImage:[rhrSheet spriteImageAtCoords:CGPointMake(0, 3)] delay:delay];
		[rightAnimation addFrameWithImage:[rhrSheet spriteImageAtCoords:CGPointMake(1, 3)] delay:delay];
		[rightAnimation addFrameWithImage:[rhrSheet spriteImageAtCoords:CGPointMake(2, 3)] delay:delay];
		[rightAnimation addFrameWithImage:[rhrSheet spriteImageAtCoords:CGPointMake(3, 3)] delay:delay];
		
		[upAnimation addFrameWithImage:[rhrSheet spriteImageAtCoords:CGPointMake(0, 0)] delay:delay];
		[upAnimation addFrameWithImage:[rhrSheet spriteImageAtCoords:CGPointMake(1, 0)] delay:delay];
		[upAnimation addFrameWithImage:[rhrSheet spriteImageAtCoords:CGPointMake(2, 0)] delay:delay];
		[upAnimation addFrameWithImage:[rhrSheet spriteImageAtCoords:CGPointMake(3, 0)] delay:delay];
		
		[downAnimation addFrameWithImage:[rhrSheet spriteImageAtCoords:CGPointMake(0, 1)] delay:delay];
		[downAnimation addFrameWithImage:[rhrSheet spriteImageAtCoords:CGPointMake(1, 1)] delay:delay];
		[downAnimation addFrameWithImage:[rhrSheet spriteImageAtCoords:CGPointMake(2, 1)] delay:delay];
		[downAnimation addFrameWithImage:[rhrSheet spriteImageAtCoords:CGPointMake(3, 1)] delay:delay];
				
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
		
		////NSLog(@"CurrentAnimation framecount is: %d.", currentAnimation.frameCount);
		currentAnimation = leftAnimation;
		////NSLog(@"CurrentAnimation framecount is: %d.", currentAnimation.frameCount);
		movementSpeed = 65;
		//destination = CGPointMake(aLocation.x + 200, aLocation.y);
		//[self moveToPoint:destination duration:3.0];
		currentAnimation = rightAnimation;
        currentAnimation.state = kAnimationState_Stopped;
        currentLocation = aLocation;
        stage = 6;
		
	}
	return self;
}	

- (id)initAtTile:(CGPoint)aTile {
    
    if (self = [super initAtTile:aTile]) {
        
        SpriteSheet *rhrSheet = [SpriteSheet spriteSheetForImage:[[PackedSpriteSheet packedSpriteSheetForImageNamed:@"TEORNPCSpriteSheets.png" controlFile:@"TEORNPCSpriteSheets" imageFilter:GL_LINEAR] imageForKey:@"RedHairedRoderickRevised.png"] sheetKey:@"RedHairedRoderickRevised.png" spriteSize:CGSizeMake(30, 40) spacing:10 margin:0];
		float delay = 0.14;
		
		[leftAnimation addFrameWithImage:[rhrSheet spriteImageAtCoords:CGPointMake(0, 2)] delay:delay];
		[leftAnimation addFrameWithImage:[rhrSheet spriteImageAtCoords:CGPointMake(1, 2)] delay:delay];
		[leftAnimation addFrameWithImage:[rhrSheet spriteImageAtCoords:CGPointMake(2, 2)] delay:delay];
		[leftAnimation addFrameWithImage:[rhrSheet spriteImageAtCoords:CGPointMake(3, 2)] delay:delay];
		
		[rightAnimation addFrameWithImage:[rhrSheet spriteImageAtCoords:CGPointMake(0, 3)] delay:delay];
		[rightAnimation addFrameWithImage:[rhrSheet spriteImageAtCoords:CGPointMake(1, 3)] delay:delay];
		[rightAnimation addFrameWithImage:[rhrSheet spriteImageAtCoords:CGPointMake(2, 3)] delay:delay];
		[rightAnimation addFrameWithImage:[rhrSheet spriteImageAtCoords:CGPointMake(3, 3)] delay:delay];
		
		[upAnimation addFrameWithImage:[rhrSheet spriteImageAtCoords:CGPointMake(0, 0)] delay:delay];
		[upAnimation addFrameWithImage:[rhrSheet spriteImageAtCoords:CGPointMake(1, 0)] delay:delay];
		[upAnimation addFrameWithImage:[rhrSheet spriteImageAtCoords:CGPointMake(2, 0)] delay:delay];
		[upAnimation addFrameWithImage:[rhrSheet spriteImageAtCoords:CGPointMake(3, 0)] delay:delay];
		
		[downAnimation addFrameWithImage:[rhrSheet spriteImageAtCoords:CGPointMake(0, 1)] delay:delay];
		[downAnimation addFrameWithImage:[rhrSheet spriteImageAtCoords:CGPointMake(1, 1)] delay:delay];
		[downAnimation addFrameWithImage:[rhrSheet spriteImageAtCoords:CGPointMake(2, 1)] delay:delay];
		[downAnimation addFrameWithImage:[rhrSheet spriteImageAtCoords:CGPointMake(3, 1)] delay:delay];
        
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
		
		////NSLog(@"CurrentAnimation framecount is: %d.", currentAnimation.frameCount);
		currentAnimation = leftAnimation;
		////NSLog(@"CurrentAnimation framecount is: %d.", currentAnimation.frameCount);
		movementSpeed = 65;
		//destination = CGPointMake(aLocation.x + 200, aLocation.y);
		//[self moveToPoint:destination duration:3.0];
		currentAnimation = rightAnimation;
        currentAnimation.state = kAnimationState_Stopped;
        stage = 6;
		
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
	
    if (triggerNextStage) {
        [super youWereTapped];
        return;
    }
	
	Textbox *tb = [[Textbox alloc] initWithRect:CGRectMake(0, 0, 480, 100) color:Color4fMake(0.0, 0.0, 1.0, 0.5) duration:-1 animating:YES text:message];
	[sharedGameController.currentScene addObjectToActiveObjects:tb];
	[[InputManager sharedInputManager] setState:kWalkingAround_TextboxOnScreen];
	[self facePlayerAndStop];
	[tb release];

}

@end

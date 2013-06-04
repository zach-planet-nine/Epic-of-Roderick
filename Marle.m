//
//  Marle.m
//  TEORCutSceneTest
//
//  Created by Zach Babb on 5/24/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "Marle.h"
#import "Animation.h"
#import "SpriteSheet.h"

@implementation Marle

- (id)init {
	
	if (self = [super init]) {
		SpriteSheet *marleSheet = [[SpriteSheet alloc] initWithImageNamed:@"MarleSheet.png" spriteSize:CGSizeMake(40, 40) spacing:0 margin:0 imageFilter:GL_LINEAR];
		if (marleSheet) {
			//NSLog(@"We have the sheet");
		}
		float delay = 0.3;
		
		[leftAnimation addFrameWithImage:[marleSheet spriteImageAtCoords:CGPointMake(3, 18)] delay:delay];
		[leftAnimation addFrameWithImage:[marleSheet spriteImageAtCoords:CGPointMake(3, 19)] delay:delay];
		[leftAnimation addFrameWithImage:[marleSheet spriteImageAtCoords:CGPointMake(3, 17)] delay:delay];
		[leftAnimation addFrameWithImage:[marleSheet spriteImageAtCoords:CGPointMake(3, 16)] delay:delay];

		[rightAnimation addFrameWithImage:[marleSheet spriteImageAtCoords:CGPointMake(5, 18)] delay:delay];
		[rightAnimation addFrameWithImage:[marleSheet spriteImageAtCoords:CGPointMake(5, 19)] delay:delay];
		[rightAnimation addFrameWithImage:[marleSheet spriteImageAtCoords:CGPointMake(5, 17)] delay:delay];
		[rightAnimation addFrameWithImage:[marleSheet spriteImageAtCoords:CGPointMake(5, 16)] delay:delay];

		[upAnimation addFrameWithImage:[marleSheet spriteImageAtCoords:CGPointMake(4, 18)] delay:delay];
		[upAnimation addFrameWithImage:[marleSheet spriteImageAtCoords:CGPointMake(4, 19)] delay:delay];
		[upAnimation addFrameWithImage:[marleSheet spriteImageAtCoords:CGPointMake(4, 17)] delay:delay];
		[upAnimation addFrameWithImage:[marleSheet spriteImageAtCoords:CGPointMake(4, 16)] delay:delay];

		[downAnimation addFrameWithImage:[marleSheet spriteImageAtCoords:CGPointMake(2, 18)] delay:delay];
		[downAnimation addFrameWithImage:[marleSheet spriteImageAtCoords:CGPointMake(2, 19)] delay:delay];
		[downAnimation addFrameWithImage:[marleSheet spriteImageAtCoords:CGPointMake(2, 17)] delay:delay];
		[downAnimation addFrameWithImage:[marleSheet spriteImageAtCoords:CGPointMake(2, 16)] delay:delay];
		
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
		
		currentAnimation = upAnimation;
	}
	
	return self;
}

	

@end

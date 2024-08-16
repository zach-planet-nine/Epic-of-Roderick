//
//  Robo.m
//  TEORCutSceneTest
//
//  Created by Zach Babb on 5/24/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "Robo.h"
#import "SpriteSheet.h"
#import "Animation.h"


@implementation Robo

- (id)init {
	
	if (self = [super init]) {
		SpriteSheet *roboSheet = [[SpriteSheet alloc] initWithImageNamed:@"RoboSheet.png" spriteSize:CGSizeMake(40, 40) spacing:0 margin:0 imageFilter:GL_LINEAR];
		SpriteSheet *roderickSheet = [[SpriteSheet alloc] initWithImageNamed:@"RoderickSpriteSheet30x40.png" spriteSize:CGSizeMake(30, 40) spacing:10 margin:0 imageFilter:GL_LINEAR];
		float delay = 0.14;
		
		[leftAnimation addFrameWithImage:[roderickSheet spriteImageAtCoords:CGPointMake(0, 3)] delay:delay];
		[leftAnimation addFrameWithImage:[roderickSheet spriteImageAtCoords:CGPointMake(1, 3)] delay:delay];
		[leftAnimation addFrameWithImage:[roderickSheet spriteImageAtCoords:CGPointMake(2, 3)] delay:delay];
		[leftAnimation addFrameWithImage:[roderickSheet spriteImageAtCoords:CGPointMake(3, 3)] delay:delay];
		
		[rightAnimation addFrameWithImage:[roderickSheet spriteImageAtCoords:CGPointMake(0, 2)] delay:delay];
		[rightAnimation addFrameWithImage:[roderickSheet spriteImageAtCoords:CGPointMake(1, 2)] delay:delay];
		[rightAnimation addFrameWithImage:[roderickSheet spriteImageAtCoords:CGPointMake(2, 2)] delay:delay];
		[rightAnimation addFrameWithImage:[roderickSheet spriteImageAtCoords:CGPointMake(3, 2)] delay:delay];
		
		[upAnimation addFrameWithImage:[roderickSheet spriteImageAtCoords:CGPointMake(0, 1)] delay:delay];
		[upAnimation addFrameWithImage:[roderickSheet spriteImageAtCoords:CGPointMake(1, 1)] delay:delay];
		[upAnimation addFrameWithImage:[roderickSheet spriteImageAtCoords:CGPointMake(2, 1)] delay:delay];
		[upAnimation addFrameWithImage:[roderickSheet spriteImageAtCoords:CGPointMake(3, 1)] delay:delay];
		
		[downAnimation addFrameWithImage:[roderickSheet spriteImageAtCoords:CGPointMake(0, 0)] delay:delay];
		[downAnimation addFrameWithImage:[roderickSheet spriteImageAtCoords:CGPointMake(1, 0)] delay:delay];
		[downAnimation addFrameWithImage:[roderickSheet spriteImageAtCoords:CGPointMake(2, 0)] delay:delay];
		[downAnimation addFrameWithImage:[roderickSheet spriteImageAtCoords:CGPointMake(3, 0)] delay:delay];

				
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
        currentAnimation.state = kAnimationState_Stopped;
		//NSLog(@"CurrentAnimation framecount is: %d.", currentAnimation.frameCount);
		movementSpeed = 65;
	}
	
	return self;
}

- (void)render {
	
	

	[currentAnimation renderCenteredAtPoint:currentLocation scale:Scale2fMake(1, 1) rotation:0];
	
}

	
	
@end

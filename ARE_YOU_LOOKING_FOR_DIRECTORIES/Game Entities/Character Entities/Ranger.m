//
//  Ranger.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 8/15/11.
//  Copyright (c) 2011 InstantLazer. All rights reserved.
//

#import "Ranger.h"
#import "SpriteSheet.h"
#import "Image.h"
#import "Animation.h"

@implementation Ranger

- (id)initAtLocation:(CGPoint)aLocation {
	
	if (self = [super init]) {
		SpriteSheet *rangerSheet = [[SpriteSheet alloc] initWithImageNamed:@"ranger_spritesheet.png" spriteSize:CGSizeMake(40, 40) spacing:10 margin:0 imageFilter:GL_LINEAR];
		float delay = 0.14;
		
		[leftAnimation addFrameWithImage:[rangerSheet spriteImageAtCoords:CGPointMake(0, 3)] delay:delay];
		[leftAnimation addFrameWithImage:[rangerSheet spriteImageAtCoords:CGPointMake(1, 3)] delay:delay];
		[leftAnimation addFrameWithImage:[rangerSheet spriteImageAtCoords:CGPointMake(2, 3)] delay:delay];
		[leftAnimation addFrameWithImage:[rangerSheet spriteImageAtCoords:CGPointMake(3, 3)] delay:delay];
		
		[rightAnimation addFrameWithImage:[rangerSheet spriteImageAtCoords:CGPointMake(0, 2)] delay:delay];
		[rightAnimation addFrameWithImage:[rangerSheet spriteImageAtCoords:CGPointMake(1, 2)] delay:delay];
		[rightAnimation addFrameWithImage:[rangerSheet spriteImageAtCoords:CGPointMake(2, 2)] delay:delay];
		[rightAnimation addFrameWithImage:[rangerSheet spriteImageAtCoords:CGPointMake(3, 2)] delay:delay];
		
		[upAnimation addFrameWithImage:[rangerSheet spriteImageAtCoords:CGPointMake(0, 1)] delay:delay];
		[upAnimation addFrameWithImage:[rangerSheet spriteImageAtCoords:CGPointMake(1, 1)] delay:delay];
		[upAnimation addFrameWithImage:[rangerSheet spriteImageAtCoords:CGPointMake(2, 1)] delay:delay];
		[upAnimation addFrameWithImage:[rangerSheet spriteImageAtCoords:CGPointMake(3, 1)] delay:delay];
		
		[downAnimation addFrameWithImage:[rangerSheet spriteImageAtCoords:CGPointMake(0, 0)] delay:delay];
		[downAnimation addFrameWithImage:[rangerSheet spriteImageAtCoords:CGPointMake(1, 0)] delay:delay];
		[downAnimation addFrameWithImage:[rangerSheet spriteImageAtCoords:CGPointMake(2, 0)] delay:delay];
		[downAnimation addFrameWithImage:[rangerSheet spriteImageAtCoords:CGPointMake(3, 0)] delay:delay];
		
		
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
		
		currentAnimation = leftAnimation;
		movementSpeed = 105;
        currentLocation = aLocation;
        stage = 6;
        active = YES;
	}
	return self;
}	

- (id)initAtTile:(CGPoint)aTile {
    
    if (self = [super initAtTile:aTile]) {
		SpriteSheet *rangerSheet = [[SpriteSheet alloc] initWithImageNamed:@"RoderickSpriteSheet30x40.png" spriteSize:CGSizeMake(30, 40) spacing:10 margin:0 imageFilter:GL_LINEAR];
		float delay = 0.14;
		
		[leftAnimation addFrameWithImage:[rangerSheet spriteImageAtCoords:CGPointMake(4, 3)] delay:delay];
		[leftAnimation addFrameWithImage:[rangerSheet spriteImageAtCoords:CGPointMake(5, 3)] delay:delay];
		[leftAnimation addFrameWithImage:[rangerSheet spriteImageAtCoords:CGPointMake(6, 3)] delay:delay];
		[leftAnimation addFrameWithImage:[rangerSheet spriteImageAtCoords:CGPointMake(7, 3)] delay:delay];
		
		[rightAnimation addFrameWithImage:[rangerSheet spriteImageAtCoords:CGPointMake(4, 2)] delay:delay];
		[rightAnimation addFrameWithImage:[rangerSheet spriteImageAtCoords:CGPointMake(5, 2)] delay:delay];
		[rightAnimation addFrameWithImage:[rangerSheet spriteImageAtCoords:CGPointMake(6, 2)] delay:delay];
		[rightAnimation addFrameWithImage:[rangerSheet spriteImageAtCoords:CGPointMake(7, 2)] delay:delay];
		
		[upAnimation addFrameWithImage:[rangerSheet spriteImageAtCoords:CGPointMake(4, 1)] delay:delay];
		[upAnimation addFrameWithImage:[rangerSheet spriteImageAtCoords:CGPointMake(5, 1)] delay:delay];
		[upAnimation addFrameWithImage:[rangerSheet spriteImageAtCoords:CGPointMake(6, 1)] delay:delay];
		[upAnimation addFrameWithImage:[rangerSheet spriteImageAtCoords:CGPointMake(7, 1)] delay:delay];
		
		[downAnimation addFrameWithImage:[rangerSheet spriteImageAtCoords:CGPointMake(4, 0)] delay:delay];
		[downAnimation addFrameWithImage:[rangerSheet spriteImageAtCoords:CGPointMake(5, 0)] delay:delay];
		[downAnimation addFrameWithImage:[rangerSheet spriteImageAtCoords:CGPointMake(6, 0)] delay:delay];
		[downAnimation addFrameWithImage:[rangerSheet spriteImageAtCoords:CGPointMake(7, 0)] delay:delay];
		
		
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
		
		currentAnimation = leftAnimation;
		movementSpeed = 105;
        stage = 6;
        active = YES;
	}
	return self;
}

/*- (void)render {
    currentAnimation.currentFrameImage.color = Color4fMake(1, 1, 1, 1);
    [currentAnimation renderCenteredAtPoint:currentLocation];
    currentAnimation.currentFrameImage.color = Color4fMake(1, 1, 1, 0.4);
    [currentAnimation.currentFrameImage renderCenteredAtPoint:currentLocation scale:Scale2fMake(1.1, 1.1) rotation:0];
    currentAnimation.currentFrameImage.color = Color4fMake(1, 1, 1, 0.3);
    [currentAnimation.currentFrameImage renderCenteredAtPoint:currentLocation scale:Scale2fMake(1.2, 1.2) rotation:0];
    currentAnimation.currentFrameImage.color = Color4fMake(1, 1, 1, 0.2);
    [currentAnimation.currentFrameImage renderCenteredAtPoint:currentLocation scale:Scale2fMake(1.3, 1.3) rotation:0];
   
}*/

@end

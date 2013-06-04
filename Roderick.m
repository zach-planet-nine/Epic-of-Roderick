//
//  Roderick.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/10/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "Roderick.h"
#import "SpriteSheet.h"
#import "Image.h"
#import "Animation.h"

@implementation Roderick

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

@end

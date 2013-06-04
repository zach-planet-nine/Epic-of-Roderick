//
//  Surt.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/16/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "Surt.h"
#import "Image.h"
#import "Animation.h"

@implementation Surt

- (id)initAtLocation:(CGPoint)aLocation
{
    self = [super init];
    if (self) {
        
        Image *surtImage = [[Image alloc] initWithImageNamed:@"surt_104x130.png" filter:GL_LINEAR];
        [leftAnimation addFrameWithImage:surtImage delay:0.2];
        [rightAnimation addFrameWithImage:surtImage delay:0.2];
        [upAnimation addFrameWithImage:surtImage delay:0.2];
        [downAnimation addFrameWithImage:surtImage delay:0.2];
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
		movementSpeed = 65;
        currentLocation = aLocation;
        stage = 6;
        active = YES;
	}
	return self;
}	

- (id)initAtTile:(CGPoint)aTile {
    
    self = [super initAtTile:aTile];
    if (self) {
        
        Image *surtImage = [[Image alloc] initWithImageNamed:@"surt_104x130.png" filter:GL_LINEAR];
        [leftAnimation addFrameWithImage:surtImage delay:0.2];
        [rightAnimation addFrameWithImage:surtImage delay:0.2];
        [upAnimation addFrameWithImage:surtImage delay:0.2];
        [downAnimation addFrameWithImage:surtImage delay:0.2];
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
		movementSpeed = 65;
        stage = 6;
        active = YES;
	}
	return self;
}

@end
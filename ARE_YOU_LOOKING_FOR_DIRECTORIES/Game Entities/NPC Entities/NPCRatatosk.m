//
//  NPCRatatosk.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/23/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "NPCRatatosk.h"
#import "Image.h"
#import "Animation.h"

@implementation NPCRatatosk

- (id)initAtLocation:(CGPoint)aLocation
{
    self = [super initAtLocation:aLocation];
    if (self) {
        Image *ratatosk = [[Image alloc] initWithImageNamed:@"Ratatosk.png" filter:GL_LINEAR];
        [leftAnimation addFrameWithImage:ratatosk delay:0.2];
        [rightAnimation addFrameWithImage:ratatosk delay:0.2];
        [upAnimation addFrameWithImage:ratatosk delay:0.2];
        [downAnimation addFrameWithImage:ratatosk delay:0.2];
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

@end

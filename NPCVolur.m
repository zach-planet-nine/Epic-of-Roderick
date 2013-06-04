//
//  NPCVolur.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/23/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "NPCVolur.h"
#import "SpriteSheet.h"
#import "Image.h"
#import "Animation.h"

@implementation NPCVolur

- (id)initAtTile:(CGPoint)aTile
{
    self = [super initAtTile:aTile];
    if (self) {
        SpriteSheet *volur = [SpriteSheet spriteSheetForImageNamed:@"VolurSprites.png" spriteSize:CGSizeMake(40, 40) spacing:0 margin:0 imageFilter:GL_NEAREST];
        [leftAnimation addFrameWithImage:[volur spriteImageAtCoords:CGPointMake(0, 0)] delay:0.25];
        [leftAnimation addFrameWithImage:[volur spriteImageAtCoords:CGPointMake(1, 0)] delay:0.25];
        currentAnimation = leftAnimation;
        movementSpeed = 40;
        leftAnimation.state = kAnimationState_Stopped;
		leftAnimation.type = kAnimationType_Repeating;
        currentAnimation.state = kAnimationState_Running;
        currentAnimation.type = kAnimationType_Repeating;
    }
    
    return self;
}

@end

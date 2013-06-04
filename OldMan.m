//
//  OldMan.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/18/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "OldMan.h"
#import "InputManager.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "SpriteSheet.h"
#import "Animation.h"
#import "Image.h"
#import "Textbox.h"

@implementation OldMan

- (id)initAtLocation:(CGPoint)aLocation
{
    self = [super init];
    if (self) {
        
        SpriteSheet *oldManSheet = [[SpriteSheet alloc] initWithImageNamed:@"OldManSpriteSheet.png" spriteSize:CGSizeMake(48, 48) spacing:0 margin:0 imageFilter:GL_NEAREST];
        [leftAnimation addFrameWithImage:[oldManSheet spriteImageAtCoords:CGPointMake(5, 0)] delay:0.14];
        [leftAnimation addFrameWithImage:[oldManSheet spriteImageAtCoords:CGPointMake(8, 0)] delay:0.14];
        [leftAnimation addFrameWithImage:[oldManSheet spriteImageAtCoords:CGPointMake(5, 0)] delay:0.14];
        [leftAnimation addFrameWithImage:[oldManSheet spriteImageAtCoords:CGPointMake(9, 0)] delay:0.14];
        [rightAnimation addFrameWithImage:[oldManSheet spriteImageAtCoords:CGPointMake(7, 0)] delay:0.14];
        [rightAnimation addFrameWithImage:[oldManSheet spriteImageAtCoords:CGPointMake(6, 0)] delay:0.14];
        [rightAnimation addFrameWithImage:[oldManSheet spriteImageAtCoords:CGPointMake(7, 0)] delay:0.14];
        [rightAnimation addFrameWithImage:[oldManSheet spriteImageAtCoords:CGPointMake(10, 0)] delay:0.14];
        [upAnimation addFrameWithImage:[oldManSheet spriteImageAtCoords:CGPointMake(4, 0)] delay:0.14];
        [upAnimation addFrameWithImage:[oldManSheet spriteImageAtCoords:CGPointMake(3, 0)] delay:0.14];
        [upAnimation addFrameWithImage:[oldManSheet spriteImageAtCoords:CGPointMake(4, 0)] delay:0.14];
        [upAnimation addFrameWithImage:[oldManSheet spriteImageAtCoords:CGPointMake(2, 0)] delay:0.14];
        [downAnimation addFrameWithImage:[oldManSheet spriteImageAtCoords:CGPointMake(11, 0)] delay:0.14];
        [downAnimation addFrameWithImage:[oldManSheet spriteImageAtCoords:CGPointMake(0, 0)] delay:0.14];
        [downAnimation addFrameWithImage:[oldManSheet spriteImageAtCoords:CGPointMake(11, 0)] delay:0.14];
        [downAnimation addFrameWithImage:[oldManSheet spriteImageAtCoords:CGPointMake(1, 0)] delay:0.14];
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
		
		movementSpeed = 20;
		currentLocation = aLocation;
		currentAnimation = downAnimation;
        stage = 6;
    }
    
    return self;
}

- (id)initAtTile:(CGPoint)aTile {
    
    self = [super initAtTile:aTile];
    if (self) {
        
        SpriteSheet *oldManSheet = [[SpriteSheet alloc] initWithImageNamed:@"OldManSpriteSheet.png" spriteSize:CGSizeMake(48, 48) spacing:0 margin:0 imageFilter:GL_NEAREST];
        [leftAnimation addFrameWithImage:[oldManSheet spriteImageAtCoords:CGPointMake(5, 0)] delay:0.14];
        [leftAnimation addFrameWithImage:[oldManSheet spriteImageAtCoords:CGPointMake(8, 0)] delay:0.14];
        [leftAnimation addFrameWithImage:[oldManSheet spriteImageAtCoords:CGPointMake(5, 0)] delay:0.14];
        [leftAnimation addFrameWithImage:[oldManSheet spriteImageAtCoords:CGPointMake(9, 0)] delay:0.14];
        [rightAnimation addFrameWithImage:[oldManSheet spriteImageAtCoords:CGPointMake(7, 0)] delay:0.14];
        [rightAnimation addFrameWithImage:[oldManSheet spriteImageAtCoords:CGPointMake(6, 0)] delay:0.14];
        [rightAnimation addFrameWithImage:[oldManSheet spriteImageAtCoords:CGPointMake(7, 0)] delay:0.14];
        [rightAnimation addFrameWithImage:[oldManSheet spriteImageAtCoords:CGPointMake(10, 0)] delay:0.14];
        [upAnimation addFrameWithImage:[oldManSheet spriteImageAtCoords:CGPointMake(4, 0)] delay:0.14];
        [upAnimation addFrameWithImage:[oldManSheet spriteImageAtCoords:CGPointMake(3, 0)] delay:0.14];
        [upAnimation addFrameWithImage:[oldManSheet spriteImageAtCoords:CGPointMake(4, 0)] delay:0.14];
        [upAnimation addFrameWithImage:[oldManSheet spriteImageAtCoords:CGPointMake(2, 0)] delay:0.14];
        [downAnimation addFrameWithImage:[oldManSheet spriteImageAtCoords:CGPointMake(11, 0)] delay:0.14];
        [downAnimation addFrameWithImage:[oldManSheet spriteImageAtCoords:CGPointMake(0, 0)] delay:0.14];
        [downAnimation addFrameWithImage:[oldManSheet spriteImageAtCoords:CGPointMake(11, 0)] delay:0.14];
        [downAnimation addFrameWithImage:[oldManSheet spriteImageAtCoords:CGPointMake(1, 0)] delay:0.14];
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
		
		movementSpeed = 20;
		currentAnimation = downAnimation;
        stage = 6;
    }
    
    return self;
}



- (void)youWereTapped {
	
    if (triggerNextStage) {
        [super youWereTapped];
        [self facePlayerAndStop];
        return;
    }
	
	Textbox *tb = [[Textbox alloc] initWithRect:CGRectMake(0, 0, 480, 100) color:Color4fMake(0.0, 0.0, 1.0, 0.5) duration:-1 animating:YES text:message];
	[sharedGameController.currentScene addObjectToActiveObjects:tb];
	[[InputManager sharedInputManager] setState:kWalkingAround_TextboxOnScreen];
	[self facePlayerAndStop];
	[tb release];
    
}

@end

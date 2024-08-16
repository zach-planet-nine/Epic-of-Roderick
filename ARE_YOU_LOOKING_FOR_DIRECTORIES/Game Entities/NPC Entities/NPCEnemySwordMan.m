//
//  NPCEnemySwordMan.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/10/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "NPCEnemySwordMan.h"
#import "Textbox.h"
#import "TouchManager.h"
#import "InputManager.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "PackedSpriteSheet.h"
#import "SpriteSheet.h"
#import "Image.h"
#import "Animation.h"

@implementation NPCEnemySwordMan

- (id)initAtLocation:(CGPoint)aLocation {
    
    if (self = [super init]) {
		SpriteSheet *esmSheet = [SpriteSheet spriteSheetForImage:[[PackedSpriteSheet packedSpriteSheetForImageNamed:@"TEORNPCSpriteSheets.png" controlFile:@"TEORNPCSpriteSheets" imageFilter:GL_LINEAR] imageForKey:@"EnemySwordman.png"] sheetKey:@"EnemySwordman.png" spriteSize:CGSizeMake(30, 40) spacing:10 margin:0]; 
		float delay = 0.14;
		
		[leftAnimation addFrameWithImage:[esmSheet spriteImageAtCoords:CGPointMake(0, 2)] delay:delay];
		[leftAnimation addFrameWithImage:[esmSheet spriteImageAtCoords:CGPointMake(1, 2)] delay:delay];
		[leftAnimation addFrameWithImage:[esmSheet spriteImageAtCoords:CGPointMake(2, 2)] delay:delay];
		[leftAnimation addFrameWithImage:[esmSheet spriteImageAtCoords:CGPointMake(3, 2)] delay:delay];
		
		[rightAnimation addFrameWithImage:[esmSheet spriteImageAtCoords:CGPointMake(0, 3)] delay:delay];
		[rightAnimation addFrameWithImage:[esmSheet spriteImageAtCoords:CGPointMake(1, 3)] delay:delay];
		[rightAnimation addFrameWithImage:[esmSheet spriteImageAtCoords:CGPointMake(2, 3)] delay:delay];
		[rightAnimation addFrameWithImage:[esmSheet spriteImageAtCoords:CGPointMake(3, 3)] delay:delay];
		
		[upAnimation addFrameWithImage:[esmSheet spriteImageAtCoords:CGPointMake(0, 0)] delay:delay];
		[upAnimation addFrameWithImage:[esmSheet spriteImageAtCoords:CGPointMake(1, 0)] delay:delay];
		[upAnimation addFrameWithImage:[esmSheet spriteImageAtCoords:CGPointMake(2, 0)] delay:delay];
		[upAnimation addFrameWithImage:[esmSheet spriteImageAtCoords:CGPointMake(3, 0)] delay:delay];
		
		[downAnimation addFrameWithImage:[esmSheet spriteImageAtCoords:CGPointMake(0, 1)] delay:delay];
		[downAnimation addFrameWithImage:[esmSheet spriteImageAtCoords:CGPointMake(1, 1)] delay:delay];
		[downAnimation addFrameWithImage:[esmSheet spriteImageAtCoords:CGPointMake(2, 1)] delay:delay];
		[downAnimation addFrameWithImage:[esmSheet spriteImageAtCoords:CGPointMake(3, 1)] delay:delay];
		
		
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
		currentAnimation = downAnimation;
        stage = 6;
		
	}
	return self;
}	

- (id)initAtTile:(CGPoint)aTile {
    
    self = [super initAtTile:aTile];
    if (self) {
        
        SpriteSheet *esmSheet = [SpriteSheet spriteSheetForImage:[[PackedSpriteSheet packedSpriteSheetForImageNamed:@"TEORNPCSpriteSheets.png" controlFile:@"TEORNPCSpriteSheets" imageFilter:GL_LINEAR] imageForKey:@"EnemySwordman.png"] sheetKey:@"EnemySwordman.png" spriteSize:CGSizeMake(30, 40) spacing:10 margin:0]; 
		float delay = 0.14;
		
		[leftAnimation addFrameWithImage:[esmSheet spriteImageAtCoords:CGPointMake(0, 2)] delay:delay];
		[leftAnimation addFrameWithImage:[esmSheet spriteImageAtCoords:CGPointMake(1, 2)] delay:delay];
		[leftAnimation addFrameWithImage:[esmSheet spriteImageAtCoords:CGPointMake(2, 2)] delay:delay];
		[leftAnimation addFrameWithImage:[esmSheet spriteImageAtCoords:CGPointMake(3, 2)] delay:delay];
		
		[rightAnimation addFrameWithImage:[esmSheet spriteImageAtCoords:CGPointMake(0, 3)] delay:delay];
		[rightAnimation addFrameWithImage:[esmSheet spriteImageAtCoords:CGPointMake(1, 3)] delay:delay];
		[rightAnimation addFrameWithImage:[esmSheet spriteImageAtCoords:CGPointMake(2, 3)] delay:delay];
		[rightAnimation addFrameWithImage:[esmSheet spriteImageAtCoords:CGPointMake(3, 3)] delay:delay];
		
		[upAnimation addFrameWithImage:[esmSheet spriteImageAtCoords:CGPointMake(0, 0)] delay:delay];
		[upAnimation addFrameWithImage:[esmSheet spriteImageAtCoords:CGPointMake(1, 0)] delay:delay];
		[upAnimation addFrameWithImage:[esmSheet spriteImageAtCoords:CGPointMake(2, 0)] delay:delay];
		[upAnimation addFrameWithImage:[esmSheet spriteImageAtCoords:CGPointMake(3, 0)] delay:delay];
		
		[downAnimation addFrameWithImage:[esmSheet spriteImageAtCoords:CGPointMake(0, 1)] delay:delay];
		[downAnimation addFrameWithImage:[esmSheet spriteImageAtCoords:CGPointMake(1, 1)] delay:delay];
		[downAnimation addFrameWithImage:[esmSheet spriteImageAtCoords:CGPointMake(2, 1)] delay:delay];
		[downAnimation addFrameWithImage:[esmSheet spriteImageAtCoords:CGPointMake(3, 1)] delay:delay];
		
		
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
		currentAnimation = downAnimation;
        stage = 6;
    }
    return self;
}

- (void)youWereTapped {
    
    Textbox *tb = [[Textbox alloc] initWithRect:CGRectMake(0, 0, 480, 100) color:Color4fMake(0.6, 0, 0, 0.5) duration:-1 animating:YES text:@"I am an enemy swordman and I am going to move to the right."];
    [sharedGameController.currentScene addObjectToActiveObjects:tb];
    [tb release];
    [[InputManager sharedInputManager] setState:kWalkingAround_TextboxOnScreen];
    [self moveToPoint:CGPointMake(currentLocation.x + 200, currentLocation.y) duration:1];
    [super youWereTapped];
}

@end

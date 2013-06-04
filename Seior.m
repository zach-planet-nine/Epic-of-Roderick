//
//  Seior.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/26/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "Seior.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "InputManager.h"
#import "Image.h"
#import "Animation.h"
#import "Textbox.h"
#import "SpriteSheet.h"

@implementation Seior

- (id)initAtLocation:(CGPoint)aLocation
{
    self = [super init];
    if (self) {
        SpriteSheet *seiorSheet = [[SpriteSheet alloc] initWithImageNamed:@"wizard_spritesheet.png" spriteSize:CGSizeMake(40, 40) spacing:10 margin:0 imageFilter:GL_LINEAR];
		float delay = 0.14;
		
		[leftAnimation addFrameWithImage:[seiorSheet spriteImageAtCoords:CGPointMake(0, 3)] delay:delay];
		[leftAnimation addFrameWithImage:[seiorSheet spriteImageAtCoords:CGPointMake(1, 3)] delay:delay];
		[leftAnimation addFrameWithImage:[seiorSheet spriteImageAtCoords:CGPointMake(2, 3)] delay:delay];
		[leftAnimation addFrameWithImage:[seiorSheet spriteImageAtCoords:CGPointMake(3, 3)] delay:delay];
		
		[rightAnimation addFrameWithImage:[seiorSheet spriteImageAtCoords:CGPointMake(0, 2)] delay:delay];
		[rightAnimation addFrameWithImage:[seiorSheet spriteImageAtCoords:CGPointMake(1, 2)] delay:delay];
		[rightAnimation addFrameWithImage:[seiorSheet spriteImageAtCoords:CGPointMake(2, 2)] delay:delay];
		[rightAnimation addFrameWithImage:[seiorSheet spriteImageAtCoords:CGPointMake(3, 2)] delay:delay];
		
		[upAnimation addFrameWithImage:[seiorSheet spriteImageAtCoords:CGPointMake(0, 1)] delay:delay];
		[upAnimation addFrameWithImage:[seiorSheet spriteImageAtCoords:CGPointMake(1, 1)] delay:delay];
		[upAnimation addFrameWithImage:[seiorSheet spriteImageAtCoords:CGPointMake(2, 1)] delay:delay];
		[upAnimation addFrameWithImage:[seiorSheet spriteImageAtCoords:CGPointMake(3, 1)] delay:delay];
		
		[downAnimation addFrameWithImage:[seiorSheet spriteImageAtCoords:CGPointMake(0, 0)] delay:delay];
		[downAnimation addFrameWithImage:[seiorSheet spriteImageAtCoords:CGPointMake(1, 0)] delay:delay];
		[downAnimation addFrameWithImage:[seiorSheet spriteImageAtCoords:CGPointMake(2, 0)] delay:delay];
		[downAnimation addFrameWithImage:[seiorSheet spriteImageAtCoords:CGPointMake(3, 0)] delay:delay];
		
		
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
    
    self = [super initAtTile:aTile];
    if (self) {
        SpriteSheet *seiorSheet = [[SpriteSheet alloc] initWithImageNamed:@"wizard_spritesheet.png" spriteSize:CGSizeMake(40, 40) spacing:10 margin:0 imageFilter:GL_LINEAR];
		float delay = 0.14;
		
		[leftAnimation addFrameWithImage:[seiorSheet spriteImageAtCoords:CGPointMake(0, 3)] delay:delay];
		[leftAnimation addFrameWithImage:[seiorSheet spriteImageAtCoords:CGPointMake(1, 3)] delay:delay];
		[leftAnimation addFrameWithImage:[seiorSheet spriteImageAtCoords:CGPointMake(2, 3)] delay:delay];
		[leftAnimation addFrameWithImage:[seiorSheet spriteImageAtCoords:CGPointMake(3, 3)] delay:delay];
		
		[rightAnimation addFrameWithImage:[seiorSheet spriteImageAtCoords:CGPointMake(0, 2)] delay:delay];
		[rightAnimation addFrameWithImage:[seiorSheet spriteImageAtCoords:CGPointMake(1, 2)] delay:delay];
		[rightAnimation addFrameWithImage:[seiorSheet spriteImageAtCoords:CGPointMake(2, 2)] delay:delay];
		[rightAnimation addFrameWithImage:[seiorSheet spriteImageAtCoords:CGPointMake(3, 2)] delay:delay];
		
		[upAnimation addFrameWithImage:[seiorSheet spriteImageAtCoords:CGPointMake(0, 1)] delay:delay];
		[upAnimation addFrameWithImage:[seiorSheet spriteImageAtCoords:CGPointMake(1, 1)] delay:delay];
		[upAnimation addFrameWithImage:[seiorSheet spriteImageAtCoords:CGPointMake(2, 1)] delay:delay];
		[upAnimation addFrameWithImage:[seiorSheet spriteImageAtCoords:CGPointMake(3, 1)] delay:delay];
		
		[downAnimation addFrameWithImage:[seiorSheet spriteImageAtCoords:CGPointMake(0, 0)] delay:delay];
		[downAnimation addFrameWithImage:[seiorSheet spriteImageAtCoords:CGPointMake(1, 0)] delay:delay];
		[downAnimation addFrameWithImage:[seiorSheet spriteImageAtCoords:CGPointMake(2, 0)] delay:delay];
		[downAnimation addFrameWithImage:[seiorSheet spriteImageAtCoords:CGPointMake(3, 0)] delay:delay];
		
		
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
        currentLocation = CGPointMake(aTile.x * 40.5, aTile.y * 40.5);
        stage = 6;
        active = YES;    }
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

+ (void)seiorAppearAt:(CGPoint)aLocation move:(int)aDirection andFace:(int)aFacing {
    
    Seior *seior = [[Seior alloc] initAtLocation:aLocation];
    [seior fadeIn];
    switch (aDirection) {
        case kMovingUp:
            [seior moveToPoint:CGPointMake(aLocation.x, aLocation.y + 40) duration:1];
            break;
        case kMovingDown:
            [seior moveToPoint:CGPointMake(aLocation.x, aLocation.y - 40) duration:1];
            break;
        case kMovingRight:
            [seior moveToPoint:CGPointMake(aLocation.x + 40, aLocation.y) duration:1];
            break;
        case kMovingLeft:
            [seior moveToPoint:CGPointMake(aLocation.x - 40, aLocation.y) duration:1];
            break;
            
        default:
            break;
    }
    switch (aFacing) {
        case kMovingUp:
            [seior faceUp];
            break;
        case kMovingDown:
            [seior faceDown];
            break;
        case kMovingRight:
            [seior faceRight];
            break;
        case kMovingLeft:
            [seior faceLeft];
            break;
            
        default:
            break;
    }
    [[GameController sharedGameController].currentScene addEntityToActiveEntities:seior];
    [seior release];
}

+ (void)joinParty {
    
    for (Seior *seior in [GameController sharedGameController].currentScene.activeEntities) {
        if ([seior isMemberOfClass:[Seior class]]) {
            [seior moveToPoint:[GameController sharedGameController].player.currentLocation duration:1];
            [seior fadeOut];
        }
    }
}

+ (void)move:(int)aDirection {
    for (Seior *seior in [GameController sharedGameController].currentScene.activeEntities) {
        if ([seior isMemberOfClass:[Seior class]]) {
            switch (aDirection) {
                case kMovingUp:
                    [seior moveToPoint:CGPointMake(seior.currentLocation.x, seior.currentLocation.y + 40) duration:1];
                    break;
                case kMovingDown:
                    [seior moveToPoint:CGPointMake(seior.currentLocation.x, seior.currentLocation.y - 40) duration:1];
                    break;
                case kMovingRight:
                    [seior moveToPoint:CGPointMake(seior.currentLocation.x + 40, seior.currentLocation.y) duration:1];
                    break;
                case kMovingLeft:
                    [seior moveToPoint:CGPointMake(seior.currentLocation.x - 40, seior.currentLocation.y) duration:1];
                    break;
                    
                default:
                    break;
            }
            
        }
    }
    
}


@end

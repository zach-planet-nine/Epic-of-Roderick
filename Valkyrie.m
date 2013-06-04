//
//  Valkyrie.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/16/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "Valkyrie.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "PackedSpriteSheet.h"
#import "Animation.h"
#import "Image.h"
#import "SpriteSheet.h"

@implementation Valkyrie

- (id)initAtLocation:(CGPoint)aLocation
{
    self = [super init];
    if (self) {
        
        SpriteSheet *valkSheet = [SpriteSheet spriteSheetForImage:[[PackedSpriteSheet packedSpriteSheetForImageNamed:@"TEORNPCSpriteSheets.png" controlFile:@"TEORNPCSpriteSheets" imageFilter:GL_LINEAR] imageForKey:@"valkyrie_spritesheet.png"] sheetKey:@"valkyrie_spritesheet.png" spriteSize:CGSizeMake(30, 40) spacing:10 margin:0];
		float delay = 0.14;
		
		[leftAnimation addFrameWithImage:[valkSheet spriteImageAtCoords:CGPointMake(4, 2)] delay:delay];
		[leftAnimation addFrameWithImage:[valkSheet spriteImageAtCoords:CGPointMake(5, 2)] delay:delay];
		[leftAnimation addFrameWithImage:[valkSheet spriteImageAtCoords:CGPointMake(6, 2)] delay:delay];
		[leftAnimation addFrameWithImage:[valkSheet spriteImageAtCoords:CGPointMake(7, 2)] delay:delay];
		
		[rightAnimation addFrameWithImage:[valkSheet spriteImageAtCoords:CGPointMake(4, 3)] delay:delay];
		[rightAnimation addFrameWithImage:[valkSheet spriteImageAtCoords:CGPointMake(5, 3)] delay:delay];
		[rightAnimation addFrameWithImage:[valkSheet spriteImageAtCoords:CGPointMake(6, 3)] delay:delay];
		[rightAnimation addFrameWithImage:[valkSheet spriteImageAtCoords:CGPointMake(7, 3)] delay:delay];
		
		[upAnimation addFrameWithImage:[valkSheet spriteImageAtCoords:CGPointMake(0, 0)] delay:delay];
		[upAnimation addFrameWithImage:[valkSheet spriteImageAtCoords:CGPointMake(1, 0)] delay:delay];
		[upAnimation addFrameWithImage:[valkSheet spriteImageAtCoords:CGPointMake(2, 0)] delay:delay];
		[upAnimation addFrameWithImage:[valkSheet spriteImageAtCoords:CGPointMake(3, 0)] delay:delay];
		
		[downAnimation addFrameWithImage:[valkSheet spriteImageAtCoords:CGPointMake(4, 1)] delay:delay];
		[downAnimation addFrameWithImage:[valkSheet spriteImageAtCoords:CGPointMake(5, 1)] delay:delay];
		[downAnimation addFrameWithImage:[valkSheet spriteImageAtCoords:CGPointMake(6, 1)] delay:delay];
		[downAnimation addFrameWithImage:[valkSheet spriteImageAtCoords:CGPointMake(7, 1)] delay:delay];
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
        
        SpriteSheet *valkSheet = [SpriteSheet spriteSheetForImage:[[PackedSpriteSheet packedSpriteSheetForImageNamed:@"TEORNPCSpriteSheets.png" controlFile:@"TEORNPCSpriteSheets" imageFilter:GL_LINEAR] imageForKey:@"valkyrie_spritesheet.png"] sheetKey:@"valkyrie_spritesheet.png" spriteSize:CGSizeMake(30, 40) spacing:10 margin:0];
		float delay = 0.14;
		
		[leftAnimation addFrameWithImage:[valkSheet spriteImageAtCoords:CGPointMake(4, 2)] delay:delay];
		[leftAnimation addFrameWithImage:[valkSheet spriteImageAtCoords:CGPointMake(5, 2)] delay:delay];
		[leftAnimation addFrameWithImage:[valkSheet spriteImageAtCoords:CGPointMake(6, 2)] delay:delay];
		[leftAnimation addFrameWithImage:[valkSheet spriteImageAtCoords:CGPointMake(7, 2)] delay:delay];
		
		[rightAnimation addFrameWithImage:[valkSheet spriteImageAtCoords:CGPointMake(4, 3)] delay:delay];
		[rightAnimation addFrameWithImage:[valkSheet spriteImageAtCoords:CGPointMake(5, 3)] delay:delay];
		[rightAnimation addFrameWithImage:[valkSheet spriteImageAtCoords:CGPointMake(6, 3)] delay:delay];
		[rightAnimation addFrameWithImage:[valkSheet spriteImageAtCoords:CGPointMake(7, 3)] delay:delay];
		
		[upAnimation addFrameWithImage:[valkSheet spriteImageAtCoords:CGPointMake(0, 0)] delay:delay];
		[upAnimation addFrameWithImage:[valkSheet spriteImageAtCoords:CGPointMake(1, 0)] delay:delay];
		[upAnimation addFrameWithImage:[valkSheet spriteImageAtCoords:CGPointMake(2, 0)] delay:delay];
		[upAnimation addFrameWithImage:[valkSheet spriteImageAtCoords:CGPointMake(3, 0)] delay:delay];
		
		[downAnimation addFrameWithImage:[valkSheet spriteImageAtCoords:CGPointMake(4, 1)] delay:delay];
		[downAnimation addFrameWithImage:[valkSheet spriteImageAtCoords:CGPointMake(5, 1)] delay:delay];
		[downAnimation addFrameWithImage:[valkSheet spriteImageAtCoords:CGPointMake(6, 1)] delay:delay];
		[downAnimation addFrameWithImage:[valkSheet spriteImageAtCoords:CGPointMake(7, 1)] delay:delay];
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

+ (void)valkyrieAppearAt:(CGPoint)aLocation move:(int)aDirection andFace:(int)aFacing {
    
    Valkyrie *valk = [[Valkyrie alloc] initAtLocation:aLocation];
    [valk fadeIn];
    switch (aDirection) {
        case kMovingUp:
            [valk moveToPoint:CGPointMake(aLocation.x, aLocation.y + 40) duration:1];
            break;
        case kMovingDown:
            [valk moveToPoint:CGPointMake(aLocation.x, aLocation.y - 40) duration:1];
            break;
        case kMovingRight:
            [valk moveToPoint:CGPointMake(aLocation.x + 40, aLocation.y) duration:1];
            break;
        case kMovingLeft:
            [valk moveToPoint:CGPointMake(aLocation.x - 40, aLocation.y) duration:1];
            break;
            
        default:
            break;
    }
    switch (aFacing) {
        case kMovingUp:
            [valk faceUp];
            break;
        case kMovingDown:
            [valk faceDown];
            break;
        case kMovingRight:
            [valk faceRight];
            break;
        case kMovingLeft:
            [valk faceLeft];
            break;
            
        default:
            break;
    }
    [[GameController sharedGameController].currentScene addEntityToActiveEntities:valk];
    [valk release];
}

+ (void)joinParty {
    
    for (Valkyrie *valk in [GameController sharedGameController].currentScene.activeEntities) {
        if ([valk isMemberOfClass:[Valkyrie class]]) {
            [valk moveToPoint:[GameController sharedGameController].player.currentLocation duration:1];
            [valk fadeOut];
        }
    }
}

+ (void)move:(int)aDirection {
    for (Valkyrie *valk in [GameController sharedGameController].currentScene.activeEntities) {
        if ([valk isMemberOfClass:[Valkyrie class]]) {
            switch (aDirection) {
                case kMovingUp:
                    [valk moveToPoint:CGPointMake(valk.currentLocation.x, valk.currentLocation.y + 40) duration:1];
                    break;
                case kMovingDown:
                    [valk moveToPoint:CGPointMake(valk.currentLocation.x, valk.currentLocation.y - 40) duration:1];
                    break;
                case kMovingRight:
                    [valk moveToPoint:CGPointMake(valk.currentLocation.x + 40, valk.currentLocation.y) duration:1];
                    break;
                case kMovingLeft:
                    [valk moveToPoint:CGPointMake(valk.currentLocation.x - 40, valk.currentLocation.y) duration:1];
                    break;
                    
                default:
                    break;
            }

        }
    }

}

@end

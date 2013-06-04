//
//  AbstractEntity.m
//  TEORCutSceneTest
//
//  Created by Zach Babb on 5/24/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "AbstractEntity.h"
#import "InputManager.h"
#import "Animation.h"
#import "MoveMap.h"
#import "GameController.h"
#import "Global.h"
#import "AbstractScene.h"
#import "TouchManager.h"
#import "SoundManager.h"
#import "Image.h"


@implementation AbstractEntity

@synthesize leftAnimation;
@synthesize rightAnimation;
@synthesize upAnimation;
@synthesize downAnimation;
@synthesize currentAnimation;
@synthesize currentLocation;
@synthesize currentTile;
@synthesize rect;
@synthesize destination;
@synthesize moving;
@synthesize active;
@synthesize message;
@synthesize triggerNextStage;

- (id)init {
	
	if (self = [super init]) {
		NSLog(@"Trying to init an Abstract Entity");
		sharedGameController = [GameController sharedGameController];
		sharedTouchManager = [TouchManager sharedTouchManager];
		sharedSoundManager = [SoundManager sharedSoundManager];
        sharedInputManager = [InputManager sharedInputManager];
		
		leftAnimation = [[Animation alloc] init];
		rightAnimation = [[Animation alloc] init];
		upAnimation = [[Animation alloc] init];
		downAnimation = [[Animation alloc] init];
		currentAnimation = upAnimation;
		movementSpeed = 40;
		velocity = Vector2fMake(0, 0);
		currentLocation = CGPointMake(0, 0);
		destination = CGPointMake(0, 0);
		
        isFadingOut = NO;
		moving = kNotMoving;
		active = YES;
        triggerNextStage = NO;
		stage = 0;
        // Added for testing
        tileOverlay = [[Image alloc] initWithImageNamed:@"Tile.png" filter:GL_NEAREST];
	}
	
	return self;
}

- (id)initAtLocation:(CGPoint)aLocation {
    
    if (self = [super init]) {
		
		sharedGameController = [GameController sharedGameController];
		sharedTouchManager = [TouchManager sharedTouchManager];
		sharedSoundManager = [SoundManager sharedSoundManager];
        sharedInputManager = [InputManager sharedInputManager];
		
		leftAnimation = [[Animation alloc] init];
		rightAnimation = [[Animation alloc] init];
		upAnimation = [[Animation alloc] init];
		downAnimation = [[Animation alloc] init];
		currentAnimation = upAnimation;
		movementSpeed = 40;
		velocity = Vector2fMake(0, 0);
		currentLocation = aLocation;
		destination = CGPointMake(0, 0);
		
        isFadingOut = NO;
		moving = kNotMoving;
		active = YES;
        triggerNextStage = NO;
		stage = 0;
        // Added for testing
        tileOverlay = [[Image alloc] initWithImageNamed:@"Tile.png" filter:GL_NEAREST];
	}
	
	return self;
}

- (id)initAtTile:(CGPoint)aTile {
    
    if (self = [super init]) {
		
		sharedGameController = [GameController sharedGameController];
		sharedTouchManager = [TouchManager sharedTouchManager];
		sharedSoundManager = [SoundManager sharedSoundManager];
        sharedInputManager = [InputManager sharedInputManager];
		
		leftAnimation = [[Animation alloc] init];
		rightAnimation = [[Animation alloc] init];
		upAnimation = [[Animation alloc] init];
		downAnimation = [[Animation alloc] init];
		currentAnimation = upAnimation;
		movementSpeed = 40;
		velocity = Vector2fMake(0, 0);
		currentTile = aTile;
        currentLocation = CGPointMake(currentTile.x * 40 + 20, currentTile.y * 40 + 20);
		destination = CGPointMake(0, 0);
		
        isFadingOut = NO;
		moving = kNotMoving;
		active = YES;
        triggerNextStage = NO;
		stage = 0;
        // Added for testing
        tileOverlay = [[Image alloc] initWithImageNamed:@"Tile.png" filter:GL_NEAREST];
	}
	
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
    if (active && wait && waitTimer != -1) {
        waitTimer -= aDelta;
        if (waitTimer < 0) {
            wait = NO;
        }
    }
    if (active && !wait) {
        currentTile = CGPointMake((int)((currentLocation.x) / 40), (int)((currentLocation.y) / 40));
        if (moving == kMovingAutomated) {
            if (currentLocation.x != destination.x || currentLocation.y != destination.y) {
                currentLocation = CGPointMake(currentLocation.x + (velocity.x * aDelta), currentLocation.y + (velocity.y * aDelta));
            }
            if (abs(currentLocation.x - destination.x) < 5 && abs(currentLocation.y - destination.y) < 5) {
                currentLocation = destination;
                currentAnimation.state = kAnimationState_Stopped;
                moving = kNotMoving;
                if (wander) {
                    BOOL choiceIsMade = NO;
                    wait = YES;
                    waitTimer = 1;
                    while (!choiceIsMade) {
                        float roll = RANDOM_0_TO_1();
                        if (roll < 0.25) {
                            if (wanderRect.origin.x < currentTile.x) {
                                //[self moveToPoint:CGPointMake(currentLocation.x - 40, currentLocation.y) duration:(40 / movementSpeed)];
                                [self moveToTile:CGPointMake(currentTile.x - 1, currentTile.y) duration:40 / movementSpeed];
                                choiceIsMade = YES;
                            }
                        }
                        if (roll < 0.5 && roll >= 0.25) {
                            if (wanderRect.origin.x + wanderRect.size.width > currentTile.x) {
                                //[self moveToPoint:CGPointMake(currentLocation.x + 40, currentLocation.y) duration:(40 / movementSpeed)];
                                [self moveToTile:CGPointMake(currentTile.x + 1, currentTile.y) duration:40 / movementSpeed];
                                choiceIsMade = YES;
                            }
                        }
                        if (roll < 0.75 && roll >= 0.5) {
                            if (wanderRect.origin.y < currentTile.y) {
                                //[self moveToPoint:CGPointMake(currentLocation.x, currentLocation.y - 40) duration:(40 / movementSpeed)];
                                [self moveToTile:CGPointMake(currentTile.x, currentTile.y - 1) duration:40 / movementSpeed];
                                choiceIsMade = YES;
                            }
                        }
                        if (roll < 1 && roll >= 0.75) {
                            if (wanderRect.origin.y + wanderRect.size.height > currentTile.y) {
                                //[self moveToPoint:CGPointMake(currentLocation.x, currentLocation.y + 40) duration:(40 / movementSpeed)];
                                [self moveToTile:CGPointMake(currentTile.x, currentTile.y + 1) duration:40 / movementSpeed];
                                choiceIsMade = YES;
                            }
                        }
                    }
                }
               // //NSLog(@"Blue Robo should stop with stage: %d.", stage);
            }
        }
        
        if (moving != kNotMoving && (moving != kMovingAutomated || wander)) {
            CGPoint leftTile = CGPointMake(currentTile.x - 1, currentTile.y);
            CGPoint rightTile = CGPointMake(currentTile.x + 1, currentTile.y);
            CGPoint upTile = CGPointMake(currentTile.x, currentTile.y + 1);
            CGPoint downTile = CGPointMake(currentTile.x, currentTile.y - 1);
            /*CGPoint extraLeftTile;
            CGPoint extraRightTile;
            if ((int)currentLocation.y % 40 > 20) {
                extraLeftTile = CGPointMake(currentTile.x - 1, currentTile.y + 1);
                extraRightTile = CGPointMake(currentTile.x + 1, currentTile.y + 1);
            } else {
                extraLeftTile = CGPointMake(currentTile.x - 1, currentTile.y - 1);
                extraRightTile = CGPointMake(currentTile.x + 1, currentTile.y - 1);
            }*/
            
            BOOL canMoveLeft = YES;
            BOOL canMoveRight = YES;
            BOOL canMoveUp = YES;
            BOOL canMoveDown = YES;
            
            for (AbstractEntity *entity in sharedGameController.currentScene.activeEntities) {
                if ([entity isKindOfClass:[AbstractEntity class]] && entity.active) {
                    if ((leftTile.x == entity.currentTile.x && leftTile.y == entity.currentTile.y) || [sharedGameController.currentScene isBlocked:leftTile.x y:leftTile.y]) {
                        if (currentTile.x * 40 + 19 > currentLocation.x) {
                            canMoveLeft = NO;
                        }
                    }
                    if ((rightTile.x == entity.currentTile.x && rightTile.y == entity.currentTile.y) || [sharedGameController.currentScene isBlocked:rightTile.x y:rightTile.y]) {
                        if (currentTile.x * 40 + 21 < currentLocation.x) {
                            canMoveRight = NO;
                        }                  
                    }
                    if ((upTile.x == entity.currentTile.x && upTile.y == entity.currentTile.y) || [sharedGameController.currentScene isBlocked:upTile.x y:upTile.y]) {
                        if (currentTile.y * 40 + 30 < currentLocation.y) {
                            canMoveUp = NO;
                        }    
                    }
                    if ((downTile.x == entity.currentTile.x && downTile.y == entity.currentTile.y) || [sharedGameController.currentScene isBlocked:downTile.x y:downTile.y]) {
                        if (currentTile.y * 40 + 15 > currentLocation.y) {
                            canMoveDown = NO;
                        }
                    }
                }
            }
            
            if ((canMoveLeft && velocity.x < 0) || (canMoveRight && velocity.x > 0)) {
                currentLocation = CGPointMake(currentLocation.x + (velocity.x * aDelta), currentLocation.y);
            }
            if ((canMoveUp && velocity.y > 0) || (canMoveDown && velocity.y < 0)) {
                currentLocation = CGPointMake(currentLocation.x, currentLocation.y + (velocity.y * aDelta));
            }
            
            /*CGPoint previousLocation = currentLocation;
            currentLocation = CGPointMake(currentLocation.x + (velocity.x * aDelta), currentLocation.y + (velocity.y * aDelta));
            CGRect myRect = [self getRect];
            for (AbstractEntity *entity in [sharedGameController currentScene].activeEntities) {
                CGRect aRect = [entity getRect];
                if (CGRectIntersectsRect(aRect, myRect) && self != entity) {
                    currentLocation = previousLocation;
                }
            }
            CGRect bRect = [self getMovementBounds];
            BoundingBoxTileQuad bbtq = getTileCoordsForBoundingRect(bRect, CGSizeMake(40, 40));
            if ([sharedGameController.currentScene isBlocked:bbtq.x1 y:bbtq.y1] || [sharedGameController.currentScene isBlocked:bbtq.x2 y:bbtq.y2] || [sharedGameController.currentScene isBlocked:bbtq.x3 y:bbtq.y3] || [sharedGameController.currentScene isBlocked:bbtq.x4 y:bbtq.y4]) {
                currentLocation = previousLocation;
            }*/
        }
        
        if (isFadingOut) {
            fadeOutAlpha -= aDelta;
            if (fadeOutAlpha < 0) {
                active = NO;
                isFadingOut = NO;
            }
        }
        
        if (isFadingIn) {
            fadeInAlpha += aDelta;
            [currentAnimation currentFrameImage].color = Color4fMake(1, 1, 1, fadeInAlpha);
            if (fadeInAlpha > 1) {
                fadeInAlpha = 1;
                isFadingIn = NO;
            }
        }
        
        
        [currentAnimation updateWithDelta:aDelta];
    }
	
}

- (void)render {
	
    if (active) {
        if (isFadingOut) {
            [currentAnimation currentFrameImage].color = Color4fMake(1, 1, 1, fadeOutAlpha);
        }
        if (isFadingIn) {
            [currentAnimation currentFrameImage].color = Color4fMake(1, 1, 1, fadeInAlpha);
        }
        [currentAnimation renderCenteredAtPoint:currentLocation];
        [currentAnimation currentFrameImage].color = Color4fMake(1, 1, 1, 1);
        /*CGPoint leftTile = CGPointMake(currentTile.x - 1, currentTile.y);
        CGPoint rightTile = CGPointMake(currentTile.x + 1, currentTile.y);
        CGPoint upTile = CGPointMake(currentTile.x, currentTile.y + 1);
        CGPoint downTile = CGPointMake(currentTile.x, currentTile.y - 1);
        CGPoint extraLeftTile;
        CGPoint extraRightTile;
        if ((int)currentLocation.y % 40 > 20) {
            extraLeftTile = CGPointMake(currentTile.x - 1, currentTile.y + 1);
            extraRightTile = CGPointMake(currentTile.x + 1, currentTile.y + 1);
        } else {
            extraLeftTile = CGPointMake(currentTile.x - 1, currentTile.y - 1);
            extraRightTile = CGPointMake(currentTile.x + 1, currentTile.y - 1);
        }
        [tileOverlay renderAtPoint:CGPointMake(leftTile.x * 40, leftTile.y * 40)];
        [tileOverlay renderAtPoint:CGPointMake(rightTile.x * 40, rightTile.y * 40)];
        [tileOverlay renderAtPoint:CGPointMake(upTile.x * 40, upTile.y * 40)];
        [tileOverlay renderAtPoint:CGPointMake(downTile.x * 40, downTile.y * 40)];
        [tileOverlay renderAtPoint:CGPointMake(extraLeftTile.x * 40, extraLeftTile.y * 40)];
        [tileOverlay renderAtPoint:CGPointMake(extraRightTile.x * 40, extraRightTile.y * 40)];*/
    }
}

- (void)moveToPoint:(CGPoint)aPoint duration:(float)aDuration {
	
	destination = aPoint;
	velocity = Vector2fMake((destination.x - currentLocation.x) / aDuration, (destination.y - currentLocation.y) / aDuration);
	if (abs(velocity.x) < abs(velocity.y)) {
		if (velocity.y > 0) {
			currentAnimation = upAnimation;
		} else {
			currentAnimation = downAnimation;
		}
	} else {
		if (velocity.x > 0) {
			currentAnimation = rightAnimation;
		} else {
			currentAnimation = leftAnimation;
		}
	}
    if (currentAnimation) {
        //NSLog(@"Current animation has state: %d", currentAnimation.state);
    }
	currentAnimation.state = kAnimationState_Running;
	moving = kMovingAutomated;

}

- (void)moveToTile:(CGPoint)aTile duration:(float)aDuration {
    
    [self moveToPoint:CGPointMake(aTile.x * 40 + 20, aTile.y * 40 + 20) duration:aDuration];
}

- (void)teleportToTile:(CGPoint)aTile {
    
    [self stopMoving];
    currentTile = aTile;
    currentLocation = CGPointMake(currentTile.x * 40 + 20, currentTile.y * 40 + 20);
}

- (void)moveWithMapToPoint:(CGPoint)aPoint duration:(float)aDuration {
	
	MoveMap *moveMap = [[MoveMap alloc] initMoveFromMapXY:CGPointMake((int)(currentLocation.x / 40), (int)(currentLocation.y / 40)) to:CGPointMake((int)(aPoint.x / 40), (int)(aPoint.y / 40)) withDuration:aDuration];
	[[sharedGameController currentScene] addObjectToActiveObjects:moveMap];
	[moveMap release];
	[self moveToPoint:aPoint duration:aDuration];
}
	

- (void)setCurrentLocation:(CGPoint)aPoint {
	
	currentLocation = aPoint;
	destination = aPoint;
}

- (void)stopAnimation {
	
	currentAnimation.state = kAnimationState_Stopped;
}

- (void)startAnimation {
	
	currentAnimation.state = kAnimationState_Running;
}
- (void)faceLeft {
	
	currentAnimation = leftAnimation;
    currentAnimation.state = kAnimationState_Stopped;
}

- (void)faceRight {

	currentAnimation = rightAnimation;
    currentAnimation.state = kAnimationState_Stopped;
}

- (void)faceUp {

	currentAnimation = upAnimation;
    currentAnimation.state = kAnimationState_Stopped;
}

- (void)faceDown {

	currentAnimation = downAnimation;
    currentAnimation.state = kAnimationState_Stopped;
}
	
- (void)startMoving:(int)aDirection {
	
	moving = aDirection;
	
	switch (aDirection) {
		case kMovingLeft:
			[self faceLeft];
			velocity = Vector2fMake(-(movementSpeed), 0);
			break;
		case kMovingRight:
			[self faceRight];
			velocity = Vector2fMake(movementSpeed, 0);
			break;
		case kMovingUp:
			[self faceUp];
			velocity = Vector2fMake(0, movementSpeed);
			break;
		case kMovingDown:
			[self faceDown];
			velocity = Vector2fMake(0, -(movementSpeed));
			break;
		case kMovingUpLeft:
			if (![currentAnimation isEqual:upAnimation] && ![currentAnimation isEqual:leftAnimation]) {
				[self faceUp];
			}
			velocity = Vector2fMake(-(movementSpeed / 1.5), movementSpeed / 1.5);
			break;
		case kMovingUpRight:
			if (currentAnimation != upAnimation && currentAnimation != rightAnimation) {
				[self faceUp];
			}
			velocity = Vector2fMake(movementSpeed / 1.5, movementSpeed / 1.5);
			break;
		case kMovingDownRight:
			if (currentAnimation != downAnimation && currentAnimation != rightAnimation) {
				[self faceDown];
			}
			velocity = Vector2fMake(movementSpeed / 1.5, -(movementSpeed / 1.5));
			break;
		case kMovingDownLeft:
			if (currentAnimation != downAnimation && currentAnimation != leftAnimation) {
				[self faceDown];
			}
			velocity = Vector2fMake(-(movementSpeed / 1.5), -(movementSpeed / 1.5));
			break;
		default:
			break;
	}
	if (currentAnimation.state == kAnimationState_Stopped) {
		[self startAnimation];
	}
	
}

- (void)stopMoving
{
	[self stopAnimation];
	velocity = Vector2fMake(0, 0);
}

- (CGRect)getRect {
	
	return CGRectMake(currentLocation.x - 21, currentLocation.y - 21, 42, 42);
}

- (void)youWereTapped {
	
	//Override in subclasses to receive taps from touchmanager
    if (wander) {
        wait = YES;
    }
    if (triggerNextStage) {
        triggerNextStage = NO;
        [sharedGameController.currentScene moveToNextStageInScene];
    }
}

- (void)facePlayerAndStop {
	
	Vector2f vector = Vector2fMake(currentLocation.x - sharedGameController.player.currentLocation.x, currentLocation.y - sharedGameController.player.currentLocation.y);
	
	if (abs(vector.x) < abs(vector.y)) {
		if (vector.y > 0) {
			currentAnimation = downAnimation;
		} else {
			currentAnimation = upAnimation;
		}
	} else {
		if (vector.x > 0) {
			currentAnimation = leftAnimation;
		} else {
			currentAnimation = rightAnimation;
		}
	}
	currentAnimation.state = kAnimationState_Stopped;
	moving = kNotMoving;
}
	
- (void)faceEntity:(AbstractEntity *)aEntity {
	
	Vector2f vector = Vector2fMake(currentLocation.x - aEntity.currentLocation.x, currentLocation.y - aEntity.currentLocation.y);
	
	if (abs(vector.x) < abs(vector.y)) {
		if (vector.y > 0) {
			currentAnimation = downAnimation;
		} else {
			currentAnimation = upAnimation;
		}
	} else {
		if (vector.x > 0) {
			currentAnimation = leftAnimation;
		} else {
			currentAnimation = rightAnimation;
		}
	}
	currentAnimation.state = kAnimationState_Stopped;
	moving = kNotMoving;
}

- (void)fadeOut {
    
    isFadingOut = YES;
    isFadingIn = NO;
    fadeOutAlpha = 1;
}

- (void)fadeIn {
    
    isFadingIn = YES;
    isFadingOut = NO;
    active = YES;
    fadeInAlpha = 0;
    currentAnimation.currentFrameImage.color = Color4fMake(1, 1, 1, 0);
}

- (CGRect)getMovementBounds {
    
    return CGRectMake(currentLocation.x - 15, currentLocation.y, 30, 20);
}

- (void)setWanderInRect:(CGRect)aRect {
    
    wander = YES;
    //[self moveToPoint:CGPointMake(currentLocation.x + 40, currentLocation.y) duration:40 / movementSpeed];
    [self moveToTile:CGPointMake(currentTile.x + 1, currentTile.y) duration:40 / movementSpeed];
    wanderRect = aRect;
}

BoundingBoxTileQuad getTileCoordsForBoundingRect(CGRect aRect, CGSize aTileSize) {
    
    BoundingBoxTileQuad bbtq;
	
	// Bottom left
	bbtq.x1 = (int)(aRect.origin.x / aTileSize.width);
	bbtq.y1 = (int)(aRect.origin.y / aTileSize.height) - 1;
	
	// Bottom right
	bbtq.x2 = (int)((aRect.origin.x + aRect.size.width) / aTileSize.width);
	bbtq.y2 = bbtq.y1;
	
	// Top right
	bbtq.x3 = bbtq.x2;
    bbtq.y3 = (int)((aRect.origin.y + aRect.size.height) / aTileSize.height) - 1;
	
	// Top left
	bbtq.x4 = bbtq.x1;
	bbtq.y4 = bbtq.y3;
	
	return bbtq;
}
@end

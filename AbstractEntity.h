//
//  AbstractEntity.h
//  TEORCutSceneTest
//
//  Created by Zach Babb on 5/24/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Global.h"

@class Animation;
@class GameController;
@class TouchManager;
@class SoundManager;
@class InputManager;

@interface AbstractEntity : NSObject {

	GameController *sharedGameController;
	TouchManager *sharedTouchManager;
    InputManager *sharedInputManager;
	SoundManager *sharedSoundManager;
	Animation *leftAnimation;
	Animation *rightAnimation;
	Animation *upAnimation;
	Animation *downAnimation;
    BOOL wander;
    CGRect wanderRect;
	CGPoint currentLocation;
    CGPoint currentTile;
	CGPoint destination;
	CGRect rect;
	Animation *currentAnimation;
	float movementSpeed;
	Vector2f velocity;
	int moving;
	BOOL active;
    BOOL wait;
    float waitTimer;
    BOOL isFadingOut;
    float fadeOutAlpha;
    BOOL isFadingIn;
    float fadeInAlpha;
	int stage;
    NSString *message;
    BOOL triggerNextStage;
    
    //Added for testing
    Image *tileOverlay;
	
}

@property (nonatomic, retain) Animation *leftAnimation;
@property (nonatomic, retain) Animation *rightAnimation;
@property (nonatomic, retain) Animation *upAnimation;
@property (nonatomic, retain) Animation *downAnimation;
@property (nonatomic, retain) Animation *currentAnimation;
@property (nonatomic, assign) CGPoint currentLocation;
@property (nonatomic, assign) CGPoint currentTile;
@property (nonatomic, assign) CGPoint destination;
@property (nonatomic, assign) CGRect rect;
@property (nonatomic, assign) int moving;
@property (nonatomic, assign) BOOL active;
@property (nonatomic, retain) NSString *message;
@property (nonatomic, assign) BOOL triggerNextStage;

- (id)initAtLocation:(CGPoint)aLocation;

- (id)initAtTile:(CGPoint)aTile;

- (void)updateWithDelta:(float)aDelta;

- (void)render;

- (void)moveToPoint:(CGPoint)aPoint duration:(float)aDuration;

- (void)moveToTile:(CGPoint)aTile duration:(float)aDuration;

- (void)teleportToTile:(CGPoint)aTile;

- (void)moveWithMapToPoint:(CGPoint)aPoint duration:(float)aDuration;

- (void)stopAnimation;

- (void)startAnimation;

- (void)faceLeft;

- (void)faceRight;

- (void)faceUp;

- (void)faceDown;

- (void)startMoving:(int)aDirection;

- (void)stopMoving;

- (CGRect)getRect;

- (void)youWereTapped;

- (void)facePlayerAndStop;

- (void)faceEntity:(AbstractEntity *)aEntity;

- (void)fadeOut;

- (void)fadeIn;

- (CGRect)getMovementBounds;

- (void)setWanderInRect:(CGRect)aRect;

BoundingBoxTileQuad getTileCoordsForBoundingRect(CGRect aRect, CGSize aTileSize);

@end

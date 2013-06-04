//
//  AnimationManagementTest.h
//  TEORBattleTest
//
//  Created by Zach Babb on 5/22/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractScene.h"

@class Projectile;
@class Animation;
@class SpriteSheet;
@class ImageRenderManager;
@class TouchManager;
@class BitmapFont;
@class Image;

@interface AnimationManagementTest : AbstractScene {
	
	//NSMutableArray *drawingImages;
	int objects;
	Projectile *fireball;
	Animation *walkerAnimation;
	SpriteSheet *walkerSpriteSheet;
	BitmapFont *bmf;
	CGPoint whereWasTouch;
	NSString *where;
	Image *enemy;
	Image *timer;
	Image *timerRect;
	float player1Timer;
	float player2Timer;
	float player3Timer;
	float player1agi;
	float player2agi;
	float player3agi;
	Image *pond;
}

@property CGPoint whereWasTouch;

- (void)addObjectToActiveObjects:(id)aObject;

- (void)addImageToActiveImages:(id)aImage;

- (void)removeDrawingImages;

- (void)removeRuneObject;

- (void)resetPlayer1Timer;

- (void)removeObject:(id)aObject;

- (void)drawLineFrom:(CGPoint)aFromPoint to:(CGPoint)aToPoint;

- (void)drawLineOff;

@end

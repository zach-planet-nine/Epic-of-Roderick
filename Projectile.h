//
//  Projectile.h
//  TEORBattleTest
//
//  Created by Zach Babb on 5/21/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractGameObject.h"
#import "Global.h"

#define MAXIMUM_UPDATE_RATE 60

@class Image;

@interface Projectile : AbstractGameObject {
	
	//Initialized values
	Image *image;
	Vector2f fromPoint;
	Vector2f toPoint;
	Color4f startColor;
	Scale2f startSize;
	GLfloat startAngle;
	GLfloat startRotation;
	BOOL revolving;
	BOOL isBoomerang;
	
	//Calculated values
	Vector2f startVelocity;
	Scale2f finishSize;
	Color4f finishColor;
	GLfloat finishAngle;
	GLfloat elapsedTime;
	Vector2f gravity;
	GLfloat sizeVelocity;
	GLfloat revolutionVelocity;
	
	//Current values
	Vector2f velocity;
	Color4f color;
	CGPoint currentPoint;
	Scale2f size;
	GLfloat rotation;
	Vector2f imageRotationCorrection;
	
	
}

@property GLfloat elapsedTime;
@property BOOL isBoomerang;
@property BOOL revolving;
@property CGPoint currentPoint;
@property (nonatomic, retain) Image *image;

- (id)initProjectileFrom:(Vector2f)aFromPoint to:(Vector2f)aToPoint 
withImageFromSpriteSheet:(Image *)aImage lasting:(GLfloat)aDuration
		  withStartAngle:(GLfloat)aAngle 
		   withStartSize:(Scale2f)aStartSize 
			toFinishSize:(Scale2f)aFinishSize;

- (id)initProjectileFrom:(Vector2f)aFromPoint to:(Vector2f)aToPoint 
			   withImage:(NSString *)aImage lasting:(GLfloat)aDuration
		  withStartAngle:(GLfloat)aAngle
		   withStartSize:(Scale2f)aStartSize toFinishSize:(Scale2f)aFinishSize;

- (id)initProjectileFrom:(Vector2f)aFromPoint to:(Vector2f)aToPoint 
			   withImage:(NSString *)aImage lasting:(GLfloat)aDuration
		  withStartAngle:(GLfloat)aAngle 
		   withStartSize:(Scale2f)aStartSize 
			toFinishSize:(Scale2f)aFinishSize
			   revolving:(BOOL)aRevolving;

- (id)initProjectileFrom:(Vector2f)aFromPoint to:(Vector2f)aToPoint 
             withSSImage:(Image *)aImage lasting:(GLfloat)aDuration 
		  withStartAngle:(GLfloat)aAngle 
		   withStartSize:(Scale2f)aStartSize 
			toFinishSize:(Scale2f)aFinishSize 
			   revolving:(BOOL)aRevolving;

- (void)render;

- (void)renderProjectiles;

- (void)updateWithDelta:(GLfloat)aDelta;

@end

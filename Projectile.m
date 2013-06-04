//
//  Projectile.m
//  TEORBattleTest
//
//  Created by Zach Babb on 5/21/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "Projectile.h"
#import "Image.h"

@interface Projectile (Private)

- (void)calculateValues;

@end

@implementation Projectile

@synthesize elapsedTime;
@synthesize isBoomerang;
@synthesize revolving;
@synthesize currentPoint;
@synthesize image;

- (void)dealloc {
	
		
	[super dealloc];
}

- (id)initProjectileFrom:(Vector2f)aFromPoint to:(Vector2f)aToPoint 
			   withImageFromSpriteSheet:(Image *)aImage lasting:(GLfloat)aDuration
		  withStartAngle:(GLfloat)aAngle 
		   withStartSize:(Scale2f)aStartSize 
			toFinishSize:(Scale2f)aFinishSize {
	
	if (self = [super init]) {
		//Initialized values
		image = [[aImage imageDuplicate] retain];
		image.rotationPoint = CGPointMake(image.imageSize.width / 2, image.imageSize.height / 2);
		fromPoint = aFromPoint;
		toPoint = aToPoint;
		startColor = Color4fOnes;
		startSize = aStartSize;
		startAngle = aAngle;
		if (startAngle < 0) {
			startAngle += 360;
		}
		duration = aDuration;
		
		//We set the current values that we can as we go.
		currentPoint = CGPointMake(fromPoint.x, fromPoint.y);
		rotation = startAngle;
		size = startSize;
		color = startColor;
		elapsedTime = 0.0f;
		
		//With this method, size and color do not change so we set the finish size
		//and finish color to be the same as the start size and color.
		
		finishColor = startColor;
		finishSize = aFinishSize;
		
		//Now get calculated values.
		[self calculateValues];
		revolving = NO;
	}
	
	return self;
}


- (id)initProjectileFrom:(Vector2f)aFromPoint to:(Vector2f)aToPoint 
			   withImage:(NSString *)aImage lasting:(GLfloat)aDuration
		  withStartAngle:(GLfloat)aAngle 
		   withStartSize:(Scale2f)aStartSize 
			toFinishSize:(Scale2f)aFinishSize {
	
	if (self = [super init]) {
		//Initialized values
		image = [[Image alloc] initWithImageNamed:aImage filter:GL_LINEAR];
		image.rotationPoint = CGPointMake(image.imageSize.width / 2, image.imageSize.height / 2);
		fromPoint = aFromPoint;
		toPoint = aToPoint;
		startColor = Color4fOnes;
		startSize = aStartSize;
		startAngle = aAngle;
		if (startAngle < 0) {
			startAngle += 360;
		}
		duration = aDuration;
		
		//We set the current values that we can as we go.
		currentPoint = CGPointMake(fromPoint.x, fromPoint.y);
		rotation = startAngle;
		size = startSize;
		color = startColor;
		elapsedTime = 0.0f;
		
		//With this method, size and color do not change so we set the finish size
		//and finish color to be the same as the start size and color.
		
		finishColor = startColor;
		finishSize = aFinishSize;
		
		//Now get calculated values.
		[self calculateValues];
		revolving = NO;
	}
	
	return self;
}

- (id)initProjectileFrom:(Vector2f)aFromPoint to:(Vector2f)aToPoint 
			   withImage:(NSString *)aImage lasting:(GLfloat)aDuration 
		  withStartAngle:(GLfloat)aAngle 
		   withStartSize:(Scale2f)aStartSize 
			toFinishSize:(Scale2f)aFinishSize 
			   revolving:(BOOL)aRevolving {
	
	self = [self initProjectileFrom:aFromPoint to:aToPoint withImage:aImage lasting:aDuration withStartAngle:aAngle withStartSize:aStartSize toFinishSize:aFinishSize];
	
	if (aRevolving) {
		revolving = YES;
		revolutionVelocity = 1440 / aDuration;
	}
	
	return self;
}

- (id)initProjectileFrom:(Vector2f)aFromPoint to:(Vector2f)aToPoint 
			   withSSImage:(Image *)aImage lasting:(GLfloat)aDuration 
		  withStartAngle:(GLfloat)aAngle 
		   withStartSize:(Scale2f)aStartSize 
			toFinishSize:(Scale2f)aFinishSize 
			   revolving:(BOOL)aRevolving {
	
	self = [self initProjectileFrom:aFromPoint to:aToPoint withImageFromSpriteSheet:aImage lasting:aDuration withStartAngle:aAngle withStartSize:aStartSize toFinishSize:aFinishSize];
	
	if (aRevolving) {
		revolving = YES;
		revolutionVelocity = 1440 / aDuration;
	}
	
	return self;
}


- (void)render {
	[self renderProjectiles];
}

- (void)renderProjectiles {
	
	image.rotation = rotation;
	image.scale = size;
	//image.color = color;
	if (elapsedTime < duration) {
		[image renderCenteredAtPoint:currentPoint];
	}
}

- (void)updateWithDelta:(GLfloat)aDelta {
	
	//First calculate a new velocity and position
	elapsedTime += aDelta;
	if (elapsedTime > duration && isBoomerang) {
		isBoomerang = NO;
		toPoint = fromPoint;
		fromPoint = Vector2fMake(currentPoint.x, currentPoint.y);
		startAngle += 180;
		[self calculateValues];
		elapsedTime = 0;
	}
	Vector2f tmp = Vector2fMultiply(gravity, aDelta);
	////NSLog(@"Tmp is, ('%f', '%f').", tmp.x, tmp.y);
	velocity = Vector2fAdd(velocity, tmp);
	tmp = Vector2fMultiply(velocity, aDelta);
	////NSLog(@"New velocity is, ('%f', '%f').", velocity.x, velocity.y);
	Vector2f position = Vector2fMake(currentPoint.x, currentPoint.y);
	position = Vector2fAdd(position, tmp);
	currentPoint = CGPointMake(position.x, position.y);
	
	
	//Next we calculate the new rotation
	/*if (elapsedTime <= duration / 1.5) {
	 rotation += rotationVelocity * aDelta;
	 }*/
	
	if (!revolving) {
		rotation = atanf(velocity.y / velocity.x) * 57.2957795;
		if (rotation < 0 && velocity.x < 0) {
			rotation = 180 + rotation;
		}
		if (rotation < 0 && velocity.y < 0) {
			rotation = 360 + rotation;
		}
		if (velocity.x < 0 && velocity.y < 0) {
			rotation = 180 + rotation;
		}
	}
	
	if (revolving) {
		rotation += revolutionVelocity * aDelta;
	}
	
	
	////NSLog(@"Rotation: '%f'.", rotation);
	
	size = Scale2fMake(size.x + (sizeVelocity * aDelta), size.y + (sizeVelocity * aDelta));
	
	//Color not implemented yet
	//color = ?
	
}

@end

@implementation Projectile (Private)

- (void)calculateValues {
	
	
	//First we calculate what everything would be if the projectile went straight
	//to the target. From there we can just adjust everything by the angle
	//to find the correct values.
	Vector2f straightVelocity;
	straightVelocity = Vector2fMake(((toPoint.x - fromPoint.x) / duration), ((toPoint.y - fromPoint.y) / duration));
	startAngle = DEGREES_TO_RADIANS(startAngle);
	Vector2f vector = Vector2fMake(cosf(startAngle), sinf(startAngle));
	float speed = sqrtf(powf(straightVelocity.x, 2) + powf(straightVelocity.y, 2));
	startVelocity = Vector2fMultiply(vector, speed);
	////NSLog(@"StartVelocity is: ('%f', '%f').", startVelocity.x, startVelocity.y);
	velocity = Vector2fMake(startVelocity.x, startVelocity.y);
	
	//Now that we have the velocity we can calculate the gravity which is the acceleration
	//the projectile undergoes as it flies through the screen.
	GLfloat gravityX;
	GLfloat gravityY;
	gravityX = (2 * (toPoint.x - fromPoint.x - ((startVelocity.x) * duration)) / (powf(duration, 2)));
	gravityY = (2 * (toPoint.y - fromPoint.y - ((startVelocity.y) * duration)) / (powf(duration, 2)));
	gravity = Vector2fMake(gravityX, gravityY);
	
	sizeVelocity = (finishSize.x - startSize.x) / duration;
	
	//Finally we calculate finish angle. We want the finish angle to be proportional to 
	//the start angle with respect to the straight angle, but we want to condense it to 
	// a range of 90 degrees. 
	
	//For testing
	////NSLog(@"speed is: '%f'.", speed);
	////NSLog(@"velocity is: ('%f', '%f').", velocity.x, velocity.y);
	////NSLog(@"gravity is: ('%f', '%f').", gravity.x, gravity.y);
}

@end



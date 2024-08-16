//
//  ParticleEmitter.m
//  TEORBattleTest
//
//  Created by Zach Babb on 5/21/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "ParticleEmitter.h"
#import "GameController.h"
#import "Image.h"
#import "TBXML.h"
#import "TBXMLParticleAdditions.h"
#import "Texture2D.h"
#import "ImageRenderManager.h"

@interface ParticleEmitter (Private)

- (BOOL)addParticle;

- (void)initParticle:(Particle *)aParticle;

- (void)parseParticleConfig:(TBXML *)aConfig;

- (void)setupArrays;

@end

@implementation ParticleEmitter

@synthesize sourcePosition;
@synthesize particleCount;
@synthesize maxParticles;
@synthesize angle;
@synthesize speed;
@synthesize startColor;
@synthesize startColorVariance;
@synthesize finishColor;
@synthesize finishColorVariance;
@synthesize destination;
@synthesize maxRadius;
@synthesize gravity;
@synthesize stoppingPlane;
@synthesize startParticleSize;
@synthesize finishParticleSize;

- (void)dealloc {
	
	if (vertices) {
		free(vertices);
	}
	if (particles) {
		free(particles);
	}
	if (texture) {
		[texture release];
	}
	glDeleteBuffers(1, &verticesID);
	
	[super dealloc];
}

- (id)initParticleEmitterWithFile:(NSString *)aFileName {
	
	self = [super init];
	if (self != nil) {
		TBXML *particleXML = [[TBXML alloc] initWithXMLFile:aFileName];
		
		[self parseParticleConfig:particleXML];
		[self setupArrays];
		[particleXML release];
		sharedImageRenderManager = [ImageRenderManager sharedImageRenderManager];
        active = YES;
	}
	
	return self;
}

//Added code for projectile emitter.
- (id)initProjectileEmitterWithFile:(NSString *)aFileName fromPoint:(CGPoint)aFromPoint toPoint:(CGPoint)aToPoint {
	
	if (self = [super init]) {
		self = [self initParticleEmitterWithFile:aFileName];
		isProjectileEmitter = YES;
		Vector2f fromVector = Vector2fMake(aFromPoint.x, aFromPoint.y);
		sourcePosition = fromVector;
		destination = aToPoint;
	}
	
	return self;
}

//Added code for sin wave emitter.
- (id)initSinWaveEmitterWithFile:(NSString *)aFileName fromPoint:(CGPoint)aFromPoint toPoint:(CGPoint)aToPoint {
	
	if (self = [super init]) {
		self = [self initParticleEmitterWithFile:aFileName];
		isSinWaveEmitter = YES;
		Vector2f fromVector = Vector2fMake((aToPoint.x + aFromPoint.x) / 2, aFromPoint.y);
		sourcePosition = fromVector;
		sourcePositionVariance = Vector2fMake((aToPoint.x - aFromPoint.x) / 2, sourcePositionVariance.y);
        destination = aToPoint;
	}
	return self;
}

- (void)updateWithDelta:(GLfloat)aDelta {
	
	if (active && emissionRate) {
		float rate = 1.0f / emissionRate;
		emitCounter += aDelta;
		while (particleCount < maxParticles && emitCounter > rate) {
			[self addParticle];
			emitCounter -= rate;
		}
		
		elapsedTime += aDelta;
		if (duration != -1 && duration < elapsedTime) {
			[self stopParticleEmitter];
		}
	}
	
	particleIndex = 0;
	
	while (particleIndex < particleCount) {
		Particle *currentParticle = &particles[particleIndex];
        
        if (stoppingPlane.x != 0 || stoppingPlane.y != 0) {
            if (currentParticle->position.x > stoppingPlane.x || currentParticle->position.y < stoppingPlane.y) {
                currentParticle->direction = Vector2fMake(0, 0);
                currentParticle->gravity = Vector2fMake(0, 0);
            }
        }
		
		if (currentParticle->timeToLive > 0) {
			if (maxRadius > 0) {
				Vector2f tmp;
				tmp.x = sourcePosition.x - cosf(currentParticle->angle) * currentParticle->radius;
				tmp.y = sourcePosition.y - sinf(currentParticle->angle) * currentParticle->radius;
				currentParticle->position = tmp;
				
				currentParticle->angle += currentParticle->degreesPerSecond * aDelta;
				currentParticle->radius -= currentParticle->radiusDelta;
				if (currentParticle->radius < minRadius) {
					currentParticle->timeToLive = 0;
				}
			} else {
				/* original code: Vector2f tmp = Vector2fMultiply(gravity, aDelta);
				currentParticle->direction = Vector2fAdd(currentParticle->direction, tmp);
				tmp = Vector2fMultiply(currentParticle->direction, aDelta);
				currentParticle->position = Vector2fAdd(currentParticle->position, tmp);*/
				Vector2f tmp = Vector2fMultiply(currentParticle->gravity, aDelta);
				currentParticle->direction = Vector2fAdd(currentParticle->direction, tmp);
				tmp = Vector2fMultiply(currentParticle->direction, aDelta);
				currentParticle->position = Vector2fAdd(currentParticle->position, tmp);
			}
			
			currentParticle->color.red += currentParticle->deltaColor.red;
			currentParticle->color.green += currentParticle->deltaColor.green;
			currentParticle->color.blue += currentParticle->deltaColor.blue;
			currentParticle->color.alpha += currentParticle->deltaColor.alpha;
			
			currentParticle->timeToLive -= aDelta;
			
			vertices[particleIndex].x = currentParticle->position.x;
			vertices[particleIndex].y = currentParticle->position.y;
			
			currentParticle->particleSize += currentParticle->particleSizeDelta;
			vertices[particleIndex].size = MAX(0, currentParticle->particleSize);
			
			vertices[particleIndex].color = currentParticle->color;
			
			particleIndex++;
		} else {
			if (particleIndex != particleCount - 1) {
				particles[particleIndex] = particles[particleCount - 1];
			}
			particleCount--;
		}
	}
}

- (void)stopParticleEmitter {
	active = NO;
	elapsedTime = 0;
	emitCounter = 0;
}

- (void)render {
	[self renderParticles];
}

- (void)renderParticles {
	
	glDisableClientState(GL_TEXTURE_COORD_ARRAY);
	
	glBindBuffer(GL_ARRAY_BUFFER, verticesID);
	glBufferData(GL_ARRAY_BUFFER, sizeof(PointSprite) * maxParticles, vertices, GL_DYNAMIC_DRAW);
	
	glVertexPointer(2, GL_FLOAT, sizeof(PointSprite), 0);
	glColorPointer(4, GL_FLOAT, sizeof(PointSprite), (GLvoid *) (sizeof(GLfloat) * 3));
	
	glBindTexture(GL_TEXTURE_2D, texture.name);
	
	glEnableClientState(GL_POINT_SIZE_ARRAY_OES);
	
	glPointSizePointerOES(GL_FLOAT, sizeof(PointSprite), (GLvoid *) (sizeof(GL_FLOAT) * 2));
	
	glBlendFunc(blendSource, blendDestination);

	
	glEnable(GL_POINT_SPRITE_OES);
	glTexEnvi(GL_POINT_SPRITE_OES, GL_COORD_REPLACE_OES, GL_TRUE);
	
	glDrawArrays(GL_POINTS, 0, particleIndex);
	
	glBindBuffer(GL_ARRAY_BUFFER, 0);
	
	glDisableClientState(GL_POINT_SIZE_ARRAY_OES);
	glDisable(GL_POINT_SPRITE_OES);
	
	
	glEnableClientState(GL_TEXTURE_COORD_ARRAY);

	glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

}

- (void)renderParticlesWithImage:(Image *)aImage {
	[sharedImageRenderManager renderImages];
	glBlendFunc(blendSource, blendDestination);

	[aImage renderAtPoint:aImage.renderPoint];
	[sharedImageRenderManager renderImages];
	glDisableClientState(GL_TEXTURE_COORD_ARRAY);
	
	glBindBuffer(GL_ARRAY_BUFFER, verticesID);
	glBufferData(GL_ARRAY_BUFFER, sizeof(PointSprite) * maxParticles, vertices, GL_DYNAMIC_DRAW);
	
	glVertexPointer(2, GL_FLOAT, sizeof(PointSprite), 0);
	glColorPointer(4, GL_FLOAT, sizeof(PointSprite), (GLvoid *) (sizeof(GLfloat) * 3));
	
	glBindTexture(GL_TEXTURE_2D, texture.name);
	
	glEnableClientState(GL_POINT_SIZE_ARRAY_OES);
	
	glPointSizePointerOES(GL_FLOAT, sizeof(PointSprite), (GLvoid *) (sizeof(GL_FLOAT) * 2));
	
	glBlendFunc(blendSource, blendDestination);
	
	
	glEnable(GL_POINT_SPRITE_OES);
	glTexEnvi(GL_POINT_SPRITE_OES, GL_COORD_REPLACE_OES, GL_TRUE);
	
	glDrawArrays(GL_POINTS, 0, particleIndex);
	
	glBindBuffer(GL_ARRAY_BUFFER, 0);
	
	glDisableClientState(GL_POINT_SIZE_ARRAY_OES);
	glDisable(GL_POINT_SPRITE_OES);
	
	
	glEnableClientState(GL_TEXTURE_COORD_ARRAY);
	
	glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
}

- (void)particlesBecomeProjectilesTo:(CGPoint)aPoint withDuration:(float)aDuration {
    
    isProjectileEmitter = YES;
    destination = aPoint;
    particleIndex = 0;
	
	while (particleIndex < particleCount) {
		Particle *currentParticle = &particles[particleIndex];
        currentParticle->timeToLive = elapsedTime + aDuration;
        GLfloat gravityX = (2 * (destination.x - currentParticle->position.x - ((currentParticle->direction.x) * aDuration)) / (powf(aDuration, 2)));
		GLfloat gravityY = (2 * (destination.y - currentParticle->position.y - ((currentParticle->direction.y) * aDuration)) / (powf(aDuration, 2)));
		gravity = Vector2fMake(gravityX, gravityY);
        currentParticle->gravity = gravity;
        particleIndex++;
    }
    
}
	

@end

@implementation ParticleEmitter (Private)

- (BOOL)addParticle {
	
	if (particleCount == maxParticles) {
		return NO;
	}
	
	Particle *particle = &particles[particleCount];
	[self initParticle:particle];
	
	particleCount++;
	
	return YES;
}

- (void)initParticle:(Particle *)aParticle {
	
	aParticle->position.x = sourcePosition.x + sourcePositionVariance.x * RANDOM_MINUS_1_TO_1();
	
	//Added to test sin function
	if (!isSinWaveEmitter) {
		aParticle->position.y = sourcePosition.y + sourcePositionVariance.y * RANDOM_MINUS_1_TO_1();
	} else {
		//Have fun with this
        float localAngle = atanf((destination.y - sourcePosition.y) / ((destination.x - (sourcePosition.x - sourcePositionVariance.x)) + 0.2));
       // //NSLog(@"Angle is: %f", localAngle);
		aParticle->position.y = (sourcePosition.y + ((aParticle->position.x - (sourcePosition.x - sourcePositionVariance.x)) * tanf(localAngle))) + (sourcePositionVariance.y * RANDOM_0_TO_1() * sinf(RANDOM_0_TO_1() * 3.14 * cosf(0.3 * aParticle->position.x)));
        ////NSLog(@"So position y is: %f", aParticle->position.y);
	}

	
	aParticle->timeToLive = MAX(0, particleLifespan + particleLifespanVariance * RANDOM_MINUS_1_TO_1());
	
	float newAngle = (GLfloat)DEGREES_TO_RADIANS(angle + angleVariance * RANDOM_MINUS_1_TO_1());
	
	//Added so that angle is only calculated once.
	aParticle->angle = newAngle;
	
	Vector2f vector = Vector2fMake(cosf(newAngle), sinf(newAngle));
	
	float vectorSpeed = speed + speedVariance * RANDOM_MINUS_1_TO_1();
	
	aParticle->direction = Vector2fMultiply(vector, vectorSpeed);
	
	//This is added code for projectiles.
	if (isProjectileEmitter == YES) {
		aParticle->gravity = gravity;
		GLfloat gravityX = (2 * (destination.x - aParticle->position.x - ((aParticle->direction.x) * aParticle->timeToLive)) / (powf(aParticle->timeToLive, 2)));
		GLfloat gravityY = (2 * (destination.y - aParticle->position.y - ((aParticle->direction.y) * aParticle->timeToLive)) / (powf(aParticle->timeToLive, 2)));
		gravity = Vector2fMake(gravityX, gravityY);
	}
	
	aParticle->gravity = gravity;
	//End projectile code
	
	
	
	aParticle->radius = maxRadius + maxRadiusVariance * RANDOM_MINUS_1_TO_1();
	aParticle->radiusDelta = (maxRadius / particleLifespan) * (1.0 / MAXIMUM_UPDATE_RATE);
	//I'm pretty sure this calculates the angle twice so instead just set angle to newAngle and it'll be one time.
	//aParticle->angle = DEGREES_TO_RADIANS(angle + angleVariance * RANDOM_MINUS_1_TO_1());
	aParticle->degreesPerSecond = DEGREES_TO_RADIANS(rotatePerSecond + rotatePerSecondVariance * RANDOM_MINUS_1_TO_1());
		
	GLfloat particleStartSize = startParticleSize + startParticleSizeVariance * RANDOM_MINUS_1_TO_1();
	GLfloat particleFinishSize = finishParticleSize + finishParticleSizeVariance * RANDOM_MINUS_1_TO_1();
	aParticle->particleSizeDelta = ((particleFinishSize - particleStartSize) / aParticle->timeToLive) * (1.0 / MAXIMUM_UPDATE_RATE);
	aParticle->particleSize = MAX(0, particleStartSize);
	
	Color4f start = {0, 0, 0, 0};
	start.red = startColor.red + startColorVariance.red * RANDOM_MINUS_1_TO_1();
	start.green = startColor.green + startColorVariance.green * RANDOM_MINUS_1_TO_1();
	start.blue = startColor.blue + startColorVariance.blue * RANDOM_MINUS_1_TO_1();
	start.alpha = startColor.alpha + startColorVariance.alpha * RANDOM_MINUS_1_TO_1();
	
	Color4f end = {0, 0, 0, 0};
	end.red = finishColor.red + finishColorVariance.red * RANDOM_MINUS_1_TO_1();
	end.green = finishColor.green + finishColorVariance.green * RANDOM_MINUS_1_TO_1();
	end.blue = finishColor.blue + finishColorVariance.blue * RANDOM_MINUS_1_TO_1();
	end.alpha = finishColor.alpha + finishColorVariance.alpha * RANDOM_MINUS_1_TO_1();
	
	aParticle->color = start;
	aParticle->deltaColor.red = ((end.red - start.red) / aParticle->timeToLive) * (1.0 / MAXIMUM_UPDATE_RATE);
	aParticle->deltaColor.green = ((end.green- start.green) / aParticle->timeToLive) * (1.0 / MAXIMUM_UPDATE_RATE);
	aParticle->deltaColor.blue = ((end.blue - start.blue) / aParticle->timeToLive) * (1.0 / MAXIMUM_UPDATE_RATE);
	aParticle->deltaColor.alpha = ((end.alpha - start.alpha) / aParticle->timeToLive) * (1.0 / MAXIMUM_UPDATE_RATE);
	
}

- (void)parseParticleConfig:(TBXML *)aConfig {
	
	TBXMLElement *rootXMLElement = aConfig.rootXMLElement;
	
	if (!rootXMLElement) {
		//NSLog(@"ERROR - ParticleEmitter: Could not find root element in config file.");
	}
	
	TBXMLElement *element = [TBXML childElementNamed:@"texture" parentElement:rootXMLElement];
	if (element) {
		NSString *fileName = [TBXML valueOfAttributeNamed:@"name" forElement:element];
        NSString *fileData = [TBXML valueOfAttributeNamed:@"data" forElement:element];
		
		if (fileName && !fileData) {		
			// Create a new texture which is going to be used as the texture for the point sprites. As there is
            // no texture data in the file, this is done using an external image file
			texture = [[Texture2D alloc] initWithImage:[UIImage imageNamed:fileName] filter:GL_LINEAR];
		}
        
        // If texture data is present in the file then create the texture image from that data rather than an external file
        if (fileData) {
            texture = [[Texture2D alloc] initWithImage:[UIImage imageWithData:[[NSData dataWithBase64EncodedString:fileData] gzipInflate]] filter:GL_LINEAR];
        }
	}
		/*if (element) {
			NSString *fileName = [TBXML valueOfAttributeNamed:@"name" forElement:element];
			
			if (fileName) {
				texture = [[Image alloc] initWithImageNamed:fileName filter:GL_LINEAR];
			}
		}*/		
		
	
	sourcePosition = [aConfig vector2fFromChildElementNamed:@"sourcePosition" parentElement:rootXMLElement];
	sourcePositionVariance = [aConfig vector2fFromChildElementNamed:@"sourcePositionVariance" parentElement:rootXMLElement];
	speed = [aConfig floatValueFromChildElementNamed:@"speed" parentElement:rootXMLElement];
	speedVariance = [aConfig floatValueFromChildElementNamed:@"speedVariance" parentElement:rootXMLElement];
	particleLifespan = [aConfig floatValueFromChildElementNamed:@"particleLifeSpan" parentElement:rootXMLElement];
	particleLifespanVariance = [aConfig floatValueFromChildElementNamed:@"particleLifespanVariance" parentElement:rootXMLElement];
	angle = [aConfig floatValueFromChildElementNamed:@"angle" parentElement:rootXMLElement];
	angleVariance = [aConfig floatValueFromChildElementNamed:@"angleVariance" parentElement:rootXMLElement];
	gravity = [aConfig vector2fFromChildElementNamed:@"gravity" parentElement:rootXMLElement];
	startColor = [aConfig color4fFromChildElementNamed:@"startColor" parentElement:rootXMLElement];
	startColorVariance = [aConfig color4fFromChildElementNamed:@"startColorVariance" parentElement:rootXMLElement];
	finishColor = [aConfig color4fFromChildElementNamed:@"finishColor" parentElement:rootXMLElement];
	finishColorVariance = [aConfig color4fFromChildElementNamed:@"finishColorVariance" parentElement:rootXMLElement];
	maxParticles = [aConfig floatValueFromChildElementNamed:@"maxParticles" parentElement:rootXMLElement];
	startParticleSize = [aConfig floatValueFromChildElementNamed:@"startParticleSize" parentElement:rootXMLElement];
	startParticleSizeVariance = [aConfig floatValueFromChildElementNamed:@"startParticleSizeVariance" parentElement:rootXMLElement];
	finishParticleSize = [aConfig floatValueFromChildElementNamed:@"finishParticleSize" parentElement:rootXMLElement];
	finishParticleSizeVariance = [aConfig floatValueFromChildElementNamed:@"finishParticleSizeVariance" parentElement:rootXMLElement];
	duration = [aConfig floatValueFromChildElementNamed:@"duration" parentElement:rootXMLElement];
	//blendAdditive = [aConfig boolValueFromChildElementNamed:@"blendAdditive" parentElement:rootXMLElement];
	
	blendSource = [aConfig intValueFromChildElementNamed:@"blendFuncSource" parentElement:rootXMLElement];
	blendDestination = [aConfig intValueFromChildElementNamed:@"blendFuncDestination" parentElement:rootXMLElement];
	
	maxRadius = [aConfig floatValueFromChildElementNamed:@"maxRadius" parentElement:rootXMLElement];
	maxRadiusVariance = [aConfig floatValueFromChildElementNamed:@"maxRadiusVariance" parentElement:rootXMLElement];
	radiusSpeed = [aConfig floatValueFromChildElementNamed:@"radiusSpeed" parentElement:rootXMLElement];
	minRadius = [aConfig floatValueFromChildElementNamed:@"minRadius" parentElement:rootXMLElement];
	rotatePerSecond = [aConfig floatValueFromChildElementNamed:@"rotatePerSecond" parentElement:rootXMLElement];
	rotatePerSecondVariance = [aConfig floatValueFromChildElementNamed:@"rotatePerSecondVariance" parentElement:rootXMLElement];
	
	emissionRate = maxParticles / particleLifespan;
	//NSLog(@"Gravity is: (%f, %f).", gravity.x, gravity.y);
}

- (void)setupArrays {
	
	particles = malloc(sizeof(Particle) * maxParticles);
	vertices = malloc(sizeof(PointSprite) * maxParticles);
	
	NSAssert(particles && vertices, @"ERROR - ParticleEmitter: Could not allocate arrays.");
	
	glGenBuffers(1, &verticesID);
	
	active = YES;
	particleCount = 0;
	elapsedTime = 0;
}

@end



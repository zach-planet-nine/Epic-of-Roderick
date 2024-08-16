//
//  ParticleEmitter.h
//  TEORBattleTest
//
//  Created by Zach Babb on 5/21/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractGameObject.h"
#import "Global.h"

@class GameController;
@class Image;
@class Texture2D;
@class ImageRenderManager;

typedef struct {
	GLfloat x;
	GLfloat y;
	GLfloat size;
	Color4f color;
} PointSprite;

typedef struct {
	Vector2f position;
	Vector2f direction;
	Vector2f gravity;
	Color4f color;
	Color4f deltaColor;
	GLfloat radius;
	GLfloat radiusDelta;
	GLfloat angle;
	GLfloat degreesPerSecond;
	GLfloat particleSize;
	GLfloat particleSizeDelta;
	GLfloat timeToLive;
	GLfloat imageRotation;
} Particle;

#define MAXIMUM_UPDATE_RATE 60


@interface ParticleEmitter : AbstractGameObject {
	
	GameController *sharedGameController;
	ImageRenderManager *sharedImageRenderManager;
	
	Texture2D *texture;
	Vector2f sourcePosition, sourcePositionVariance;
	GLfloat angle, angleVariance;
	GLfloat speed, speedVariance;
	Vector2f gravity;
	GLfloat particleLifespan, particleLifespanVariance;
	Color4f startColor, startColorVariance;
	Color4f finishColor, finishColorVariance;
	GLfloat startParticleSize, startParticleSizeVariance;
	GLfloat finishParticleSize, finishParticleSizeVariance;
	GLuint maxParticles;
	GLint particleCount;
	GLfloat emissionRate;
	GLfloat emitCounter;
	GLfloat elapsedTime;
	GLint	blendSource;
	GLint	blendDestination;
	
	GLfloat maxRadius;
	GLfloat maxRadiusVariance;
	GLfloat radiusSpeed;
	GLfloat minRadius;
	GLfloat rotatePerSecond;
	GLfloat rotatePerSecondVariance;
    
    Vector2f stoppingPlane;
	
	BOOL useTexture;
	GLint particleIndex;
	
	GLuint verticesID;
	Particle *particles;
	PointSprite *vertices;
	
	//Added for projectiles
	BOOL isProjectileEmitter;
	CGPoint destination;
	
	//Added for sin waves
	BOOL isSinWaveEmitter;
	
}

@property (nonatomic, assign) Vector2f sourcePosition;
@property (nonatomic, assign) GLint particleCount;
@property (nonatomic, assign) GLuint maxParticles;
@property (nonatomic, assign) GLfloat angle;
@property (nonatomic, assign) GLfloat speed;
@property (nonatomic, assign) Color4f startColor;
@property (nonatomic, assign) Color4f finishColor;
@property (nonatomic, assign) Color4f startColorVariance;
@property (nonatomic, assign) Color4f finishColorVariance;
@property (nonatomic, assign) CGPoint destination;
@property (nonatomic, assign) GLfloat maxRadius;
@property (nonatomic, assign) Vector2f gravity;
@property (nonatomic, assign) Vector2f stoppingPlane;
@property (nonatomic, assign) GLfloat startParticleSize;
@property (nonatomic, assign) GLfloat finishParticleSize;

- (id)initParticleEmitterWithFile:(NSString *)aFileName;

- (id)initProjectileEmitterWithFile:(NSString *)aFileName fromPoint:(CGPoint)aFromPoint toPoint:(CGPoint)aToPoint;

- (id)initSinWaveEmitterWithFile:(NSString *)aFileName fromPoint:(CGPoint)aFromPoint toPoint:(CGPoint)aToPoint;

- (void)render;

- (void)renderParticles;

- (void)renderParticlesWithImage:(Image *)aImage;

- (void)updateWithDelta:(GLfloat)aDelta;

- (void)stopParticleEmitter;

- (void)particlesBecomeProjectilesTo:(CGPoint)aPoint withDuration:(float)aDuration;

@end

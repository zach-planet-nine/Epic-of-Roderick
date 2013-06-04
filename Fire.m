//
//  Fire.m
//  TEORBattleTest
//
//  Created by Zach Babb on 5/22/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "Fire.h"
#import "Image.h"
#import "Projectile.h"
#import "ParticleEmitter.h"
#import "BitmapFont.h"
#import "GameController.h"


@implementation Fire

@synthesize duration;

- (void)dealloc {
	if (image) {
		[image release];
	}
	if (projectile) {
		[projectile release];
	}
	if (particleEmitter) {
		[particleEmitter release];
	}
	if (battleFont) {
		[battleFont release];
	}
	[super dealloc];
}

- (id)initFromCharacter:(int)aCharacter toEnemy:(int)aEnemy {
	
	self = [super init];
	
	if (self != nil) {
		sharedGameController = [GameController sharedGameController];
		
		if (aCharacter == 1 && aEnemy == 1) {
			for (int i = 0; i < 4; i++) {
				float angle = 15 * (i * RANDOM_MINUS_1_TO_1());
				Projectile *fireball = [[Projectile alloc] initProjectileFrom:Vector2fMake(50, 250) 
																		   to:Vector2fMake(350, 150) 
																	withImage:@"fireball.png" 
																	  lasting:1.5 
															   withStartAngle:angle
																withStartSize:Scale2fMake(0.0, 0.0)
																 toFinishSize:Scale2fMake(1.0, 1.0)];
				[[sharedGameController currentScene] addObjectToActiveObjects:fireball];
				[fireball release];
				battleFont = [[BitmapFont alloc] initWithFontImageNamed:@"TimesNewRoman32.png" controlFile:@"TimesNewRoman32" scale:Scale2fMake(0.5, 0.5) filter:GL_LINEAR];
			}			
		}
		duration = 1.5;
		stage = 1;
		fontRenderPoint = CGPointMake(350, 150);
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	duration -= aDelta;
	////NSLog(@"Duration is: '%f'.", duration);
	if (stage == 3) {
		fontRenderPoint.y -= 10 * aDelta;
	}
	
	if (duration < 0) {
		switch (stage) {
			case 1:
				particleEmitter = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"appearingEmitter.pex"];
				particleEmitter.sourcePosition = Vector2fMake(350, 120);
				[[sharedGameController currentScene] addObjectToActiveObjects:particleEmitter];
				[particleEmitter release];
				stage = 2;
				duration = 2.0;
				break;
			case 2:
				stage = 3;
				duration = 2.5;
				break;
			case 3:
				[[sharedGameController currentScene] removeObject:self];
				break;
				
			default:
				break;
		}
	}
}

- (void)render {
	if (stage == 3) {
		[battleFont renderStringAt:fontRenderPoint text:@"Damage!"];
	}
}

@end

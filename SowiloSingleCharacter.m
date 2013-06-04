//
//  SowiloSingleCharacter.m
//  TEORBattleTest
//
//  Created by Zach Babb on 5/31/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "SowiloSingleCharacter.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleCharacter.h"
#import "ParticleEmitter.h"
#import "BattleValkyrie.h"



@implementation SowiloSingleCharacter

- (void)dealloc {
	
	if (sun) {
		[sun release];
	}
	if (sunsRays) {
		[sunsRays release];
	}
	[super dealloc];
}

- (id)initToCharacter:(AbstractBattleCharacter *)aCharacter {
	
	if (self = [super init]) {
		target1 = aCharacter;
		valkyrie = [sharedGameController.battleCharacters objectForKey:@"BattleValkyrie"];
		sun = [[ParticleEmitter alloc] initProjectileEmitterWithFile:@"Sun.pex" fromPoint:CGPointMake(200, 290) toPoint:CGPointMake(200, 290)];
		sunsRays = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"PowerIncreasedEmitterTextureNotEmbedded.pex"];
		sunsRays.startColor = Color4fMake(1, 1, 0, 0.5);
		sunsRays.finishColor = Color4fMake(0.38, 0.46, 0, 0);
		sunsRays.sourcePosition = Vector2fMake(target1.renderPoint.x, target1.renderPoint.y - 40);
		sunsRays.active = YES;
		sunsRays.duration = 0.6;
		stage = 0;
		active = YES;
		duration = 0.2;
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	duration -= aDelta;
	if (duration < 0) {
		switch (stage) {
			case 0:
				stage = 1;
				duration = 0.6;
				break;
				
			case 1:
				[self calculateEffectFrom:valkyrie to:target1];
				duration = 0.2;
				stage = 2;
				break;
			case 2:
				stage = 3;
				active = NO;
				break;
				
			default:
				break;
		}
	}
	if (active) {
		switch (stage) {
			case 0:
				[sun updateWithDelta:aDelta];
				break;
			case 1:
				[sun updateWithDelta:aDelta];
				[sunsRays updateWithDelta:aDelta];	
				break;
			default:
				break;
		}
	}
}

- (void)render {
	
	if (active) {
		switch (stage) {
			case 0:
				[sun renderParticles];
				break;
			case 1:
				[sun renderParticles];
				[sunsRays renderParticles];	
				break;
			case 2:
				[sun renderParticles];
				break;
				
				
			default:
				break;
		}
		
	}
}

- (void)calculateEffectFrom:(AbstractBattleEntity *)aOriginator to:(AbstractBattleEntity *)aTarget {
	
	float healing = (float)valkyrie.power * 2 * ((float)valkyrie.essence / (float)valkyrie.maxEssence);
	[target1 youWereHealed:(int)healing];
}

@end

//
//  PondHealAllCharacters.m
//  TEORBattleTest
//
//  Created by Zach Babb on 5/30/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "PondHealAllCharacters.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleEntity.h"
#import "Pond.h"
#import "ParticleEmitter.h"


@implementation PondHealAllCharacters

- (void)dealloc {
	
	if (bubbleEmitter) {
		[bubbleEmitter release];
	}
	[super dealloc];
}

- (id)initFrom:(Pond *)aPond {
	
	if (self = [super init]) {
		originator = aPond;
		
		bubbleEmitter = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"BubbleEmitter.pex"];
		
		float angle = atanf((0 - originator.renderPoint.y) / (0 - originator.renderPoint.x));
		angle *= 57.2957795;
		if (angle < 0 && 0 - originator.renderPoint.x < 0) {
			angle += 180;
		} else if (angle < 0 && 0 - originator.renderPoint.y < 0) {
			angle += 360;
		} else if (0 - originator.renderPoint.x < 0 && 0 - originator.renderPoint.y < 0) {
			angle += 180;
		}
		bubbleEmitter.sourcePosition = Vector2fMake(originator.renderPoint.x, originator.renderPoint.y);
		bubbleEmitter.angle = angle;
		Vector2f velocity = Vector2fMake((0 - originator.renderPoint.y) / 0.8, (0 - originator.renderPoint.y) / 0.8);
		bubbleEmitter.speed = Vector2fLength(velocity);
		bubbleEmitter.active = YES;
		duration = 0.6;
		stage = 0;
		active = YES;
		
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	duration -= aDelta;
	if (duration < 0) {
		switch (stage) {
			case 0:
				stage = 1;
				[self calculateEffectFrom:originator];
				duration = 0.3;
				break;
			case 1:
				stage = 2;
				active = NO;
				break;
				
			default:
				break;
		}
	}
	if (active) {
		switch (stage) {
			case 0:
				[bubbleEmitter updateWithDelta:aDelta];
				break;
			case 1:
				[bubbleEmitter updateWithDelta:aDelta];
				break;
				
			default:
				break;
		}
	}
}

- (void)render {
	
	if (active) {
		[bubbleEmitter renderParticles];
	}
}

- (void)calculateEffectFrom:(Pond *)aOriginator {
	
	for (AbstractBattleEntity *entity in sharedGameController.currentScene.activeEntities) {
		if ([entity isKindOfClass:[AbstractBattleCharacter class]] && entity.isAlive) {
			float healing = (float)originator.power * 2 * ((float)originator.essence / (float)originator.maxEssence) * 0.45;
			[entity youWereHealed:(int)healing];
		}
	}
}

@end

//
//  PondSingleCharacterHeal.m
//  TEORBattleTest
//
//  Created by Zach Babb on 5/30/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "PondSingleCharacterHeal.h"
#import "AbstractBattleCharacter.h"
#import "Pond.h"
#import "ParticleEmitter.h"


@implementation PondSingleCharacterHeal

- (void)dealloc {
	
	if (bubbleEmitter) {
		[bubbleEmitter release];
	}
	[super dealloc];
}

- (id)initToCharacter:(AbstractBattleCharacter *)aCharacter from:(Pond *)aPond {
	
	if (self = [super init]) {
		originator = aPond;
		target1 = aCharacter;
		
		bubbleEmitter = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"BubbleEmitter.pex"];
		
		float angle = atanf((target1.renderPoint.y - originator.renderPoint.y) / (target1.renderPoint.x - originator.renderPoint.x));
		angle *= 57.2957795;
		if (angle < 0 && target1.renderPoint.x - originator.renderPoint.x < 0) {
			angle += 180;
		} else if (angle < 0 && target1.renderPoint.y - originator.renderPoint.y < 0) {
			angle += 360;
		} else if (target1.renderPoint.x - originator.renderPoint.x < 0 && target1.renderPoint.y - originator.renderPoint.y < 0) {
			angle += 180;
		}
		bubbleEmitter.sourcePosition = Vector2fMake(originator.renderPoint.x, originator.renderPoint.y);
		bubbleEmitter.angle = angle;
		Vector2f velocity = Vector2fMake((target1.renderPoint.y - originator.renderPoint.y) / 0.6, (target1.renderPoint.y - originator.renderPoint.y) / 0.6);
		bubbleEmitter.speed = Vector2fLength(velocity);
		bubbleEmitter.active = YES;
		duration = 0.8;
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
				[self calculateEffectFrom:originator to:target1];
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

- (void)calculateEffectFrom:(AbstractBattleEntity *)aOriginator to:(AbstractBattleEntity *)aTarget {
	
	float healing = (float)originator.power * 2 * ((float)originator.essence / (float)originator.maxEssence);
	////NSLog(@"Healing is: %f", healing);
	//[target1 flashColor:Color4fMake(0, 1, 0, 1)];
	[target1 youWereHealed:(int)healing];
}

@end

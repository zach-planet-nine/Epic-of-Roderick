//
//  EssenceAnimation.m
//  TEORBattleTest
//
//  Created by Zach Babb on 6/1/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "EssenceAnimation.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleEntity.h"
#import "ParticleEmitter.h"


@implementation EssenceAnimation

- (void)dealloc {
	
	if (essenceEmitter) {
		[essenceEmitter release];
	}
	[super dealloc];
}

- (id)initWithEntity:(AbstractBattleEntity *)aEntity {
	
	if (self = [super init]) {
		essenceEmitter = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"HealingAnimationEmitter.pex"];
		essenceEmitter.sourcePosition = Vector2fMake(aEntity.renderPoint.x, aEntity.renderPoint.y);
		essenceEmitter.duration = 0.6;
		essenceEmitter.startColor = essenceEmitter.finishColor = aEntity.essenceColor;
		essenceEmitter.startColorVariance = essenceEmitter.finishColorVariance = Color4fMake(0, 0, 0, 0);
		stage = 0;
		duration = 0.8;
		essenceEmitter.active = YES;
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
				active = NO;
				break;
			default:
				break;
		}
	}
	if (active) {
		[essenceEmitter updateWithDelta:aDelta];
	}
}

- (void)render {
	
	if (active) {
		[essenceEmitter renderParticles];
	}
}


@end

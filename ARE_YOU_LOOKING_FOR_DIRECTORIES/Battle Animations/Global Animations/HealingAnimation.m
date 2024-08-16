//
//  HealingAnimation.m
//  TEORBattleTest
//
//  Created by Zach Babb on 5/30/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "HealingAnimation.h"
#import "ParticleEmitter.h"


@implementation HealingAnimation

- (void)dealloc {
	
	if (healingAnimationEmitter) {
		[healingAnimationEmitter release];
	}
	
	[super dealloc];
}

- (id)initAtPosition:(CGPoint)aPosition {
	
	if (self = [super init]) {
		healingAnimationEmitter = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"HealingAnimationEmitter.pex"];
		healingAnimationEmitter.sourcePosition = Vector2fMake(aPosition.x, aPosition.y);
		healingAnimationEmitter.duration = 0.6;
		stage = 0;
		duration = 0.8;
		healingAnimationEmitter.active = YES;
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
		[healingAnimationEmitter updateWithDelta:aDelta];
	}
}

- (void)render {
	
	if (active) {
		[healingAnimationEmitter renderParticles];
	}
}

@end

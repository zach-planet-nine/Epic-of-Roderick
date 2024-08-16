//
//  PondInsectAttack.m
//  TEORBattleTest
//
//  Created by Zach Babb on 5/30/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "PondInsectAttack.h"
#import "ParticleEmitter.h"
#import "AbstractBattleEnemy.h"
#import "GameController.h"
#import "AbstractScene.h"


@implementation PondInsectAttack

- (void)dealloc {
	
	if (insectEmitter) {
		[insectEmitter release];
	}
	[super dealloc];
}

- (id)initFromPond:(Pond *)aPond {
	
	if (self = [super init]) {
		
		originator = aPond;
		insectEmitter = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"InsectEmitter.pex"];
		insectEmitter.sourcePosition = Vector2fMake(originator.renderPoint.x, originator.renderPoint.y);
		/*float angle = atanf((0 - originator.renderPoint.y) / (480 - originator.renderPoint.x));
		angle *= 57.2957795;
		if (angle < 0 && 480 - originator.renderPoint.x < 0) {
			angle += 180;
		} else if (angle < 0 && 0 - originator.renderPoint.y < 0) {
			angle += 360;
		} else if (480 - originator.renderPoint.x < 0 && 0 - originator.renderPoint.y < 0) {
			angle += 180;
		}*/
		insectEmitter.angle = 315;
		stage = 0;
		duration = 0.8;
		insectEmitter.active = YES;
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
				[self calculateDamage];
				duration = 0.2;
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
				[insectEmitter updateWithDelta:aDelta];
				break;
			case 1:
				[insectEmitter updateWithDelta:aDelta];
				break;

			default:
				break;
		}
	}
}

- (void)render {
	
	if (active) {
		[insectEmitter renderParticles];
	}
}

- (void)calculateDamage {
	
	float damage = ((originator.power * 2) * (originator.essence / originator.maxEssence) / 4);
	for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
		if ([enemy isKindOfClass:[AbstractBattleEnemy class]]) {
			[enemy flashColor:Color4fMake(1, 0, 0, 1)];
			[enemy youTookDamage:(int)damage];
		}
	}
}

@end

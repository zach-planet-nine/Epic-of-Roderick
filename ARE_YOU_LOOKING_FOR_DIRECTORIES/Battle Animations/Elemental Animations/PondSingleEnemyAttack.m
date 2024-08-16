//
//  PondSingleEnemyAttack.m
//  TEORBattleTest
//
//  Created by Zach Babb on 5/30/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "PondSingleEnemyAttack.h"
#import "Pond.h"
#import "ParticleEmitter.h"
#import "AbstractBattleEnemy.h"


@implementation PondSingleEnemyAttack

- (void)dealloc {
	
	if (waterSpout) {
		[waterSpout release];
	}
	if (splash) {
		[splash release];
	}
	[super dealloc];
}

- (id)initToEnemy:(AbstractBattleEnemy *)aEnemy from:(Pond *)aPond {
	
	if (self = [super init]) {
		originator = aPond;
		target1 = aEnemy;
		
		waterSpout = [[ParticleEmitter alloc] initProjectileEmitterWithFile:@"WaterSpout.pex" fromPoint:CGPointMake(originator.renderPoint.x, originator.renderPoint.y) toPoint:CGPointMake(target1.renderPoint.x, target1.renderPoint.y)];
		splash = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"Splash.pex"];
		splash.sourcePosition = Vector2fMake(aEnemy.renderPoint.x, aEnemy.renderPoint.y);
		splash.duration = 0.5;
		splash.active = NO;
		stage = 0;
		duration = 0.8;
		active = YES;
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	duration -= aDelta;
	if (duration < 0) {
		switch (stage) {
			case 0:
				splash.active = YES;
				stage = 1;
				duration = 0.5;
				break;
			case 1:
				[self calculateEffectFrom:originator to:target1];
				stage = 2;
				duration = 0.15;
				break;
			case 2:
				active = NO;
				break;
			default:
				break;
		}
	}
	if (active) {
		switch (stage) {
			case 0:
				[waterSpout updateWithDelta:aDelta];
				break;
			case 1:
				[waterSpout updateWithDelta:aDelta];
				[splash updateWithDelta:aDelta];
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
				[waterSpout renderParticles];
				break;
			case 1:
				[waterSpout renderParticles];
				[splash renderParticles];
				break;

			default:
				break;
		}
	}
}

- (void)calculateEffectFrom:(AbstractBattleEntity *)aOriginator to:(AbstractBattleEntity *)aTarget {
	
	float damage = ((aOriginator.power * 4) - (aTarget.stamina * 3)) * ((float)originator.essence / (float)originator.maxEssence);
	originator.essence -= 15;
	[target1 flashColor:Color4fMake(0, 0, 1, 1)];
	[target1 youTookDamage:(int)damage];
}

- (void)resetAnimation {
	
	stage = 0;
	active = YES;
	duration = 0.8;
}
	


@end

//
//  EihwazAllEnemies.m
//  TEORBattleTest
//
//  Created by Zach Babb on 6/1/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "EihwazAllEnemies.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleEnemy.h"
#import "ParticleEmitter.h"


@implementation EihwazAllEnemies

- (void)dealloc {
	
	if (vineEmitters) {
		[vineEmitters release];
	}
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
		vineEmitters = [[NSMutableArray alloc] init];
		for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
			if ([enemy isKindOfClass:[AbstractBattleEnemy class]] && enemy.isAlive) {
				ParticleEmitter *vineEmitter = [[ParticleEmitter alloc] initProjectileEmitterWithFile:@"VineEmitterTest.pex" fromPoint:CGPointMake(340, 160) toPoint:enemy.renderPoint];
				float angle = atanf((enemy.renderPoint.y - 160) / (enemy.renderPoint.x - 340)) * 57.2957795;
				if (angle < 0 && enemy.renderPoint.x - 340 < 0) {
					angle += 180;
				} else if (angle < 0 && enemy.renderPoint.y - 160 < 0) {
					angle += 360;
				} else if (enemy.renderPoint.x - 340 < 0 && enemy.renderPoint.y - 160 < 0) {
					angle += 180;
				}
				vineEmitter.angle = angle;
				[vineEmitters addObject:vineEmitter];
				[vineEmitter release];
			}
		}
		stage = 0;
		active = YES;
		duration = 0.8;
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	duration -= aDelta;
	if (duration < 0) {
		switch (stage) {
			case 0:
				stage = 1;
				duration = 0.2;
				[self calculateEffect];
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
				for (ParticleEmitter *pe in vineEmitters) {
					[pe updateWithDelta:aDelta];
				}
				break;
			case 1:
				for (ParticleEmitter *pe in vineEmitters) {
					[pe updateWithDelta:aDelta];
				}				
				break;

			default:
				break;
		}
	}
}

- (void)render {
	
	if (active) {
		for (ParticleEmitter *pe in vineEmitters) {
			[pe renderParticles];
		}
	}
}

- (void)calculateEffect {
	
	for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
		if ([enemy isKindOfClass:[AbstractBattleEnemy class]] && enemy.isAlive) {
			[enemy decreaseAgilityModifierBy:5];
			[enemy flashColor:Color4fMake(0.2, 0.8, 0.2, 1)];
		}
	}
}

@end

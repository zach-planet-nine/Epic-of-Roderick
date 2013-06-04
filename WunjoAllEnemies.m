//
//  WunjoAllEnemies.m
//  TEORBattleTest
//
//  Created by Zach Babb on 6/2/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "WunjoAllEnemies.h"
#import "ParticleEmitter.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleEnemy.h"


@implementation WunjoAllEnemies

- (void)dealloc {
	
	if (groundBreaker) {
		[groundBreaker release];
	}
	if (skeletonEmitter) {
		[skeletonEmitter release];
	}
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
		
		originator = [sharedGameController.battleCharacters objectForKey:@"BattlePriest"];
		groundBreaker = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"GroundBreaking.pex"];
		skeletonEmitter = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"SkeletonEmitter.pex"];
		groundBreaker.sourcePosition = Vector2fMake(240, 160);
		skeletonEmitter.sourcePosition = Vector2fMake(240, 160);
		stage = 0;
		duration = 0.2;
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
				[skeletonEmitter updateWithDelta:aDelta];
				duration = 0.2;
				break;
			case 1:
				stage = 2;
				duration = 0.7;
				break;
			case 2:
				stage = 3;
				[self calculateEffect];
				duration = 0.2;
				break;
			case 3:
				stage = 4;
				active = NO;
				break;
			default:
				break;
		}
	}
	if (active) {
		switch (stage) {
			case 0:
				[groundBreaker updateWithDelta:aDelta];
				break;
			case 1:
				[groundBreaker updateWithDelta:aDelta];
				break;
			case 2:
				[groundBreaker updateWithDelta:aDelta];
				[skeletonEmitter updateWithDelta:aDelta];
				break;
			case 3:
				[skeletonEmitter updateWithDelta:aDelta];
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
				[groundBreaker renderParticles];
				break;
			case 1:
				[skeletonEmitter renderParticles];
				[groundBreaker renderParticles];
				break;
			case 2:
				[skeletonEmitter renderParticles];
				[groundBreaker renderParticles];
				break;
			case 3:
				[skeletonEmitter renderParticles];
				break;
			default:
				break;
		}
	}
}

- (void)calculateEffect {
	
	for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
		if ([enemy isKindOfClass:[AbstractBattleEnemy class]]) {
			[enemy flashColor:Color4fMake(1, 0, 0, 1)];
			[enemy youTookDamage:1000];
		}
	}
}

@end

//
//  KenazSingleEnemy.m
//  TEORBattleTest
//
//  Created by Zach Babb on 5/31/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "KenazSingleEnemy.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleEnemy.h"
#import "BattleWizard.h"
#import "ParticleEmitter.h"


@implementation KenazSingleEnemy

- (void)dealloc {
	
	if (fire) {
		[fire release];
	}
	[super dealloc];
}

- (id)initToEnemy:(AbstractBattleEnemy *)aEnemy {
	
	if (self = [super init]) {
		
		wizard = [sharedGameController.battleCharacters objectForKey:@"BattleWizard"];
		target1 = aEnemy;
        damage = [wizard calculateKenazDamageTo:aEnemy];
		fire = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"FireEmitter.pex"];
		fire.sourcePosition = Vector2fMake(aEnemy.renderPoint.x, aEnemy.renderPoint.y - 30);
		stage = 0;
		active = YES;
		duration = 0.5;
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
                [target1 youTookDamage:damage];
                [target1 flashColor:Red];
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
				[fire updateWithDelta:aDelta];
				break;
			case 1:
				[fire updateWithDelta:aDelta];
				break;

			default:
				break;
		}
	}
}

- (void)render {
	
	if (active) {
		[fire renderParticles];
	}
}


@end

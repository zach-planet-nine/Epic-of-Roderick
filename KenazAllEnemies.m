//
//  KenazAllEnemies.m
//  TEORBattleTest
//
//  Created by Zach Babb on 6/1/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "KenazAllEnemies.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleEnemy.h"
#import "BattleWizard.h"
#import "ParticleEmitter.h"

@implementation KenazAllEnemies

- (void)dealloc {
	
	if (fireWall) {
		[fireWall release];
	}
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
		
		wizard = [sharedGameController.battleCharacters objectForKey:@"BattleWizard"];
		fireWall = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"FireWall.pex"];
		fireWall.sourcePosition = Vector2fMake(260, 160);
		active = YES;
		stage = 0;
		duration = 0.6;
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
				fireWall.sourcePosition = Vector2fMake(fireWall.sourcePosition.x + (400 * aDelta), 160);
				[fireWall updateWithDelta:aDelta];
				break;
			case 1:
				[fireWall updateWithDelta:aDelta];
				break;

			default:
				break;
		}
	}
}

- (void)render {
	
	if (active) {
		[fireWall renderParticles];
	}
}

- (void)calculateEffect {
	
	for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
		if ([enemy isKindOfClass:[AbstractBattleEnemy class]]) {
			int damage = (wizard.power * 4) * (wizard.essence / wizard.maxEssence);
			[enemy youTookDamage:damage];
			[enemy flashColor:Color4fMake(1, 0, 0, 1)];
			
		}
	}
}

@end

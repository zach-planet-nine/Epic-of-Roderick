//
//  EihwazSingleEnemy.m
//  TEORBattleTest
//
//  Created by Zach Babb on 6/1/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "EihwazSingleEnemy.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleEnemy.h"
#import "AbstractBattleCharacter.h"
#import "ParticleEmitter.h"


@implementation EihwazSingleEnemy

- (void)dealloc {
	
	if (vineEmitter) {
		[vineEmitter release];
	}
	[super dealloc];
}

- (id)initToEnemy:(AbstractBattleEnemy *)aEnemy {

	if (self = [super init]) {
		originator = [sharedGameController.battleCharacters objectForKey:@"BattleRanger"];
		target1 = aEnemy;
		vineEmitter = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"VineCoilEmitter.pex"];
		vineEmitter.sourcePosition = Vector2fMake(target1.renderPoint.x, target1.renderPoint.y - 40);
		vineEmitter.active = NO;
		stage = 0;
		active = YES;
		duration = 0;
		vineCount = 0;
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	duration -= aDelta;
	if (duration < 0) {
		switch (stage) {
			case 0:
				vineEmitter.active = YES;
				duration = 0.08;
				vineCount++;
				vineEmitter.sourcePosition = Vector2fMake(vineEmitter.sourcePosition.x, vineEmitter.sourcePosition.y + 6);
				if (vineCount > 8) {
					stage = 1;
					[self calculateEffectFrom:originator to:target1];
					duration = 0.08;
				}
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
				[vineEmitter updateWithDelta:aDelta];
				break;

			case 1:
				[vineEmitter updateWithDelta:aDelta];
				break;
			default:
				break;
		}
	}
}

- (void)render {
	
	if (active) {
		[vineEmitter renderParticles];
	}
}

- (void)calculateEffectFrom:(AbstractBattleEntity *)aOriginator to:(AbstractBattleEntity *)aTarget {
	
	int paralyzeRoll = (originator.power * (originator.essence / originator.maxEssence));
	[aTarget youWereParalyzed:paralyzeRoll];
	if (!aTarget.isParalyzed) {
		int agiDecrease = 10;
		[aTarget decreaseAgilityModifierBy:agiDecrease];
	}
	[aTarget flashColor:Color4fMake(0, 0.7, 0, 1)];
}
	

@end

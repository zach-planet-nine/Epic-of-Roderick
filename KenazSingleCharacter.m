//
//  KenazSingleCharacter.m
//  TEORBattleTest
//
//  Created by Zach Babb on 6/1/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "KenazSingleCharacter.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleCharacter.h"
#import "BattleWizard.h"
#import "ParticleEmitter.h"

@implementation KenazSingleCharacter

- (void)dealloc {
	
	if (smallFireSparkle) {
		[smallFireSparkle release];
	}
	[super dealloc];
}

- (id)initToCharacter:(AbstractBattleCharacter *)aCharacter {
	
	if (self = [super init]) {
		
		originator = [sharedGameController.battleCharacters objectForKey:@"BattleWizard"];
		target1 = aCharacter;
		smallFireSparkle = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"smallFireSparkleEmitter.pex"];
		smallFireSparkle.sourcePosition = Vector2fMake(target1.renderPoint.x - 30, target1.renderPoint.y - 50);
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
				[self calculateEffectFrom:originator to:target1];
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
				smallFireSparkle.sourcePosition = Vector2fMake(smallFireSparkle.sourcePosition.x + (aDelta * 200), smallFireSparkle.sourcePosition.y);
				[smallFireSparkle updateWithDelta:aDelta];
				break;
			case 1:
				[smallFireSparkle updateWithDelta:aDelta];
				break;

			default:
				break;
		}
	}
}

- (void)render {
	
	if (active) {
		[smallFireSparkle renderParticles];
	}
}

- (void)calculateEffectFrom:(AbstractBattleEntity *)aOriginator to:(AbstractBattleEntity *)aTarget {
	
	target1.battleTimer += 133 * (originator.essence / originator.maxEssence);
	[target1 flashColor:Color4fMake(0.75, 0.25, 0, 1)];
}

@end

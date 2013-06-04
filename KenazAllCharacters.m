//
//  KenazAllCharacters.m
//  TEORBattleTest
//
//  Created by Zach Babb on 6/1/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "KenazAllCharacters.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleCharacter.h"
#import "BattleWizard.h"
#import "ParticleEmitter.h"


@implementation KenazAllCharacters

- (void)dealloc {
	
	if (sparklers) {
		[sparklers release];
	}
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
		sparklers = [[NSMutableArray alloc] init];
		originator = [sharedGameController.battleCharacters objectForKey:@"BattleWizard"];
		for (AbstractBattleCharacter *character in sharedGameController.currentScene.activeEntities) {
			if ([character isKindOfClass:[AbstractBattleCharacter class]] && character.isAlive) {
				ParticleEmitter *smallFireSparkle = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"smallFireSparkleEmitter.pex"];
				smallFireSparkle.sourcePosition = Vector2fMake(character.renderPoint.x - 30, character.renderPoint.y - 50);
				[sparklers addObject:smallFireSparkle];
				[smallFireSparkle release];
			}
		}
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
				for (ParticleEmitter *pe in sparklers) {
					pe.sourcePosition = Vector2fMake(pe.sourcePosition.x + (aDelta * 200), pe.sourcePosition.y);
					[pe updateWithDelta:aDelta];
				}
				break;
			case 1:
				for (ParticleEmitter *pe in sparklers) {
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
		for (ParticleEmitter *pe in sparklers) {
			[pe renderParticles];
		}
	}
}

- (void)calculateEffect {
	
	for (AbstractBattleCharacter *character in sharedGameController.currentScene.activeEntities) {
		if ([character isKindOfClass:[AbstractBattleCharacter class]] && character.isAlive) {
			character.battleTimer += 100 * (originator.essence / originator.maxEssence);
			[character flashColor:Color4fMake(0.75, 0.25, 0, 1)];
		}
	}
}

@end

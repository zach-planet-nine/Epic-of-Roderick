//
//  FrogSingleCharacter.m
//  TEORBattleTest
//
//  Created by Zach Babb on 6/1/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "FrogSingleCharacter.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleCharacter.h"
#import "Frog.h"
#import "ParticleEmitter.h"



@implementation FrogSingleCharacter

- (void)dealloc {
	
	if (essenceEmitter) {
		[essenceEmitter release];
	}
	[super dealloc];
}

- (id)initToCharacter:(AbstractBattleCharacter *)aCharacter from:(Frog *)aFrog {
	
	if (self = [super init]) {
		
		originator = aFrog;
		target1 = aCharacter;
		essenceEmitter = [[ParticleEmitter alloc] initProjectileEmitterWithFile:@"EssenceEmitter.pex" fromPoint:originator.renderPoint toPoint:target1.renderPoint];
		essenceEmitter.startColor = Color4fMake(0, 1, 0, 1);
		essenceEmitter.finishColor = target1.essenceColor;
		stage = 0;
		duration = 0.6;
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
				[self calculateEffectFrom:originator to:target1];
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
				[essenceEmitter updateWithDelta:aDelta];
				break;
			case 1:
				[essenceEmitter updateWithDelta:aDelta];
				break;

			default:
				break;
		}
	}
}

- (void)render {
	
	if (active) {
		[essenceEmitter renderParticles];
	}
}

- (void)calculateEffectFrom:(AbstractBattleEntity *)aOriginator to:(AbstractBattleEntity *)aTarget {
	
	int essence = 15;
	[target1 youWereGivenEssence:essence];
}
	
	

@end

//
//  AnsuzSingleCharacter.m
//  TEORBattleTest
//
//  Created by Zach Babb on 5/30/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "AnsuzSingleCharacter.h"
#import "ParticleEmitter.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleEntity.h"
#import "AbstractBattleCharacter.h"

@implementation AnsuzSingleCharacter

- (void)dealloc {
	
	if (raiseStatsEmitter) {
		[raiseStatsEmitter release];
	}
	[super dealloc];
}

- (id)initToCharacter:(AbstractBattleCharacter *)aCharacter {
	
	if (self = [super init]) {
		originator = [sharedGameController.battleCharacters objectForKey:@"BattleRoderick"];
		target1 = aCharacter;
		
		raiseStatsEmitter = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"PowerIncreasedEmitterTextureNotEmbedded.pex"];
		raiseStatsEmitter.sourcePosition = Vector2fMake(target1.renderPoint.x, target1.renderPoint.y - 40);
		raiseStatsEmitter.active = YES;
		raiseStatsEmitter.duration = 0.6;
		
		stage = 0;
		active = YES;
		duration = 0.7;
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
				duration = 5.0;
				break;
			case 1:
				[target1 decreasePowerModifierBy:mod];
				active = NO;
				break;
				

			default:
				break;
		}
	}
	if (active && stage == 0) {
		[raiseStatsEmitter updateWithDelta:aDelta];
	}
}

- (void)render {
	
	if (active && stage == 0) {
		[raiseStatsEmitter renderParticles];
	}
}

- (void)calculateEffectFrom:(AbstractBattleEntity *)aOriginator to:(AbstractBattleEntity *)aTarget {
	
	float power = originator.power * (originator.essence / originator.maxEssence);
	[target1 increasePowerModifierBy:(int)power];
	[target1 flashColor:Color4fMake(1, 0, 0, 1)];
	mod = power;
    //NSLog(@"power is: %f", power);
}

@end

//
//  AustrinSingleCharacter.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/23/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "AustrinSingleCharacter.h"
#import "GameController.h"
#import "AbstractBattleCharacter.h"
#import "BattleRoderick.h"
#import "ParticleEmitter.h"

@implementation AustrinSingleCharacter

- (void)dealloc {
	
	if (raiseStatsEmitter) {
		[raiseStatsEmitter release];
	}
	[super dealloc];
}

- (id)initToCharacter:(AbstractBattleCharacter *)aCharacter {
	
	if (self = [super init]) {
		BattleRoderick *roderick = [sharedGameController.battleCharacters objectForKey:@"BattleRoderick"];
        originator = roderick;
		target1 = aCharacter;
        [self calculateEffectFrom:originator to:target1];
		raiseStatsEmitter = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"PowerIncreasedEmitterTextureNotEmbedded.pex"];
		raiseStatsEmitter.sourcePosition = Vector2fMake(target1.renderPoint.x, target1.renderPoint.y - 40);
		raiseStatsEmitter.active = YES;
		raiseStatsEmitter.duration = 0.6;
        raiseStatsEmitter.startColor = Color4fMake(1, 0, 0, 1);
        austrinDuration = [roderick calculateAustrinCharacterDurationTo:aCharacter];
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
				duration = austrinDuration;
				break;
			case 1:
                stage++;
                [target1 decreasePowerModifierBy:powerMod];
                [target1 decreaseAffinityModifierBy:affinityMod];
				active = NO;
				break;
				
                
			default:
				break;
		}
	}
	if (active && stage == 0) {
        if (raiseStatsEmitter.startColor.red == 1) {
            raiseStatsEmitter.startColor = Color4fMake(0, 0.4, 0.6, 1);
        } else {
            raiseStatsEmitter.startColor = Color4fMake(1, 0, 0, 1);
        }
		[raiseStatsEmitter updateWithDelta:aDelta];
	}
}

- (void)render {
	
	if (active && stage == 0) {
		[raiseStatsEmitter renderParticles];
	}
}

- (void)calculateEffectFrom:(AbstractBattleEntity *)aOriginator to:(AbstractBattleEntity *)aTarget {
	
	float power = (originator.power + originator.skyAffinity) * (originator.essence / originator.maxEssence);
	[target1 increasePowerModifierBy:(int)(power / 2)];
    [target1 increaseAffinityModifierBy:(int)(power / 2)];
	[target1 flashColor:Color4fMake(1, 0, 0, 1)];
	powerMod = (int)(power / 2);
    affinityMod = (int)(power / 2);
    //NSLog(@"power is: %f", power);
}



@end

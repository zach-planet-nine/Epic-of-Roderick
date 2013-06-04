//
//  AnsuzAllCharacters.m
//  TEORBattleTest
//
//  Created by Zach Babb on 5/30/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "AnsuzAllCharacters.h"
#import "GameController.h"
#import "BattleRoderick.h"
#import "AbstractScene.h"
#import "AbstractBattleCharacter.h"
#import "ParticleEmitter.h"


@implementation AnsuzAllCharacters

- (void)dealloc {
	
	if (strengthEmitters) {
		[strengthEmitters release];
	}
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
		
		strengthEmitters = [[NSMutableArray alloc] init];
		for (AbstractBattleCharacter *character in sharedGameController.currentScene.activeEntities) {
			if ([character isKindOfClass:[AbstractBattleCharacter class]] && character.isAlive) {
				ParticleEmitter *strengthEmitter = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"PowerIncreasedEmitterTextureNotEmbedded.pex"];
				strengthEmitter.sourcePosition = Vector2fMake(character.renderPoint.x, character.renderPoint.y - 60);
				strengthEmitter.active = YES;
				strengthEmitter.duration = 0.6;
				[strengthEmitters addObject:strengthEmitter];
				[strengthEmitter release];
			}
		}
        [self calculateEffects];
		duration = 0.6;
		active = YES;
		stage = 0;
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	duration -= aDelta;
	if (duration < 0) {
		switch (stage) {
			case 0:
				stage = 1;
				duration = 10.0;
				break;
			case 1:
                stage = 2;
				active = NO;
				int modIndex = 0;
				for (AbstractBattleCharacter *character in sharedGameController.currentScene.activeEntities) {
					if ([character isKindOfClass:[AbstractBattleCharacter class]] && character.isAlive) {
						[character decreasePowerModifierBy:mod[modIndex]];
						modIndex++;
					}
				}
				break;
				
				
			default:
				break;
		}
	}
	if (active && stage == 0) {
		for (ParticleEmitter *pe in strengthEmitters) {
			[pe updateWithDelta:aDelta];
		}
	}
}

- (void)render {
	
	if (active && stage == 0) {
		for (ParticleEmitter *pe in strengthEmitters) {
			[pe renderParticles];
		}
	}
}

- (void)calculateEffects {
	int modIndex = 0;
    BattleRoderick *roderick = [sharedGameController.battleCharacters objectForKey:@"BattleRoderick"];
	for (AbstractBattleCharacter *character in sharedGameController.currentScene.activeEntities) {
		if ([character isKindOfClass:[AbstractBattleCharacter class]] && character.isAlive) {
			float power = roderick.power * (roderick.essence / roderick.maxEssence);
            //NSLog(@"power is:%f", power);
			[character increasePowerModifierBy:(int)(power / 2.5)];
            //NSLog(@"powerModed: %d", (int)(power / 2.5));
			[character flashColor:Color4fMake(1, 0, 0, 1)];
			mod[modIndex] = (int)(power / 2.5);
			modIndex++;
		}
	}
}


@end

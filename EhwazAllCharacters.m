//
//  EhwazAllCharacters.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/8/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "EhwazAllCharacters.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleCharacter.h"
#import "BattlePriest.h"
#import "ParticleEmitter.h"

@implementation EhwazAllCharacters

- (void)dealloc {
	
	if (defenseEmitters) {
		[defenseEmitters release];
	}
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
		
		defenseEmitters = [[NSMutableArray alloc] init];
		for (AbstractBattleCharacter *character in sharedGameController.currentScene.activeEntities) {
			if ([character isKindOfClass:[AbstractBattleCharacter class]] && character.isAlive) {
				ParticleEmitter *defenseEmitter = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"PowerIncreasedEmitterTextureNotEmbedded.pex"];
				defenseEmitter.sourcePosition = Vector2fMake(character.renderPoint.x, character.renderPoint.y - 60);
				defenseEmitter.active = YES;
				defenseEmitter.duration = 0.6;
                defenseEmitter.startColor = Color4fMake(0, 0.7, 0.2, 1);
				[defenseEmitters addObject:defenseEmitter];
				[defenseEmitter release];
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
					if ([character isKindOfClass:[AbstractBattleCharacter class]]) {
						[character decreaseAgilityModifierBy:mod[modIndex]];
                        [character decreaseDexterityModifierBy:mod[modIndex]];
						modIndex++;
					}
				}
				break;
				
				
			default:
				break;
		}
	}
	if (active && stage == 0) {
		for (ParticleEmitter *pe in defenseEmitters) {
			[pe updateWithDelta:aDelta];
		}
	}
}

- (void)render {
	
	if (active && stage == 0) {
		for (ParticleEmitter *pe in defenseEmitters) {
			[pe renderParticles];
		}
	}
}

- (void)calculateEffects {
	int modIndex = 0;
    BattlePriest *poet = [sharedGameController.battleCharacters objectForKey:@"BattlePriest"];
	for (AbstractBattleCharacter *character in sharedGameController.currentScene.activeEntities) {
		if ([character isKindOfClass:[AbstractBattleCharacter class]]) {
			float increase = (poet.power + poet.powerModifier + poet.waterAffinity + character.waterAffinity) * (poet.essence / poet.maxEssence);
			[character increaseAgilityModifierBy:(int)(increase / 3.5)];
            [character increaseDexterityModifierBy:(int)(increase / 3.5)];
			[character flashColor:Color4fMake(1, 0, 0, 1)];
			mod[modIndex] = (int)(increase / 3.5);
			modIndex++;
		}
	}
}

@end

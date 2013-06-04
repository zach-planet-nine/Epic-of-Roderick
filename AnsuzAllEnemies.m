//
//  AnsuzAllEnemies.m
//  TEORBattleTest
//
//  Created by Zach Babb on 5/30/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "AnsuzAllEnemies.h"
#import "ParticleEmitter.h"
#import "AbstractBattleCharacter.h"
#import "AbstractBattleEnemy.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "BattleRoderick.h"


@implementation AnsuzAllEnemies

- (void)dealloc {
	
	if (essenceEmitters) {
		[essenceEmitters release];
	}	
	if (ansuzBall) {
		[ansuzBall release];
	}
	if (explosion) {
		[explosion release];
	}
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
		
		float red;
		float green;
		float blue;
		colorIndex = 0;
		maxColors = 2;
		////NSLog(@"Color index: %d, MaxColors: %d.", colorIndex, maxColors);
		essenceEmitters = [[NSMutableArray alloc] init];
		for (AbstractBattleCharacter *character in sharedGameController.currentScene.activeEntities) {
			if ([character isKindOfClass:[AbstractBattleCharacter class]] && character.isAlive) {
				ParticleEmitter *essenceEmitter = [[ParticleEmitter alloc] initProjectileEmitterWithFile:@"EssenceEmitter.pex" fromPoint:character.renderPoint toPoint:CGPointMake(215, 215)];
				essenceEmitter.startColor = essenceEmitter.finishColor = character.essenceColor;
				red += character.essenceColor.red;
				green += character.essenceColor.green;
				blue += character.essenceColor.blue;
				////NSLog(@"Color index: %d, MaxColors: %d.", colorIndex, maxColors);

				colors[colorIndex] = character.essenceColor;
				colorIndex++;
				////NSLog(@"Color index: %d, MaxColors: %d.", colorIndex, maxColors);

				[essenceEmitters addObject:essenceEmitter];
				[essenceEmitter release];
			}
		}
		////NSLog(@"Color index: %d, MaxColors: %d.", colorIndex, maxColors);

		if (colorIndex != 3) {
			maxColors = colorIndex;
		}
		ansuzBall = [[ParticleEmitter alloc] initProjectileEmitterWithFile:@"AnsuzBall.pex" fromPoint:CGPointMake(240, 220) toPoint:CGPointMake(240, 220)];
		explosion = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"AnsuzBallExplosion.pex"];
		blue += 0.5;
		red /= [essenceEmitters count];
		green /= [essenceEmitters count];
		blue /= [essenceEmitters count];
		////NSLog(@"Red: %f, Green: %f, Blue: %f.", red, green, blue);
		ansuzBall.sourcePosition = Vector2fMake(240, 220);
		explosion.sourcePosition = Vector2fMake(380, 160);
		ansuzBall.startColor = ansuzBall.finishColor = Color4fMake(red, green, blue, 1);
		explosion.startColor = explosion.finishColor = Color4fMake(red, green, blue, 1);
		//ansuzBall.startColorVariance = explosion.startColorVariance = Color4fMake(red * 2, green * 2, blue * 2, 1);
		explosion.active = NO;
		velocity = Vector2fMake((380 - 240) / 0.4, (160 - 220) / 0.4);
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
				duration = 0.4;
				for (ParticleEmitter *pe in essenceEmitters) {
					pe.active = NO;
				}
				break;
			case 1:
				stage = 2;
				duration = 0.5;
				ansuzBall.active = NO;
				explosion.active = YES;
				break;
			case 2:
				stage = 3;
				[self calculateDamage];
				active = NO;
				break;


			default:
				break;
		}
	}
	if (active) {
		switch (stage) {
			case 0:
				ansuzBall.speed += aDelta * 100;
				if (colorIndex > maxColors) {
					colorIndex = 0;
				}
				////NSLog(@"Color index is: %d", colorIndex);
				ansuzBall.startColor = ansuzBall.finishColor = colors[colorIndex];
				colorIndex++;
				[ansuzBall updateWithDelta:aDelta];
				for (ParticleEmitter *pe in essenceEmitters) {
					[pe updateWithDelta:aDelta];
				}
				break;
			case 1:
				stage = stage;
				Vector2f deltaPosition = Vector2fMultiply(velocity, aDelta);
				ansuzBall.sourcePosition = Vector2fAdd(ansuzBall.sourcePosition, deltaPosition);
				ansuzBall.destination = CGPointMake(ansuzBall.sourcePosition.x, ansuzBall.sourcePosition.y);
				if (colorIndex > maxColors) {
					colorIndex = 0;
				}
				////NSLog(@"Color index is: %d", colorIndex);
				ansuzBall.startColor = ansuzBall.finishColor = colors[colorIndex];
				colorIndex++;
				[ansuzBall updateWithDelta:aDelta];
				break;
			case 2:
				if (colorIndex > maxColors) {
					colorIndex = 0;
				}
				explosion.startColor = explosion.finishColor = colors[colorIndex];
				colorIndex++;
				[explosion updateWithDelta:aDelta];
				break;


			default:
				break;
		}
	}
}

- (void)render {
	
	if (active) {
		switch (stage) {
			case 0:
				for (ParticleEmitter *pe in essenceEmitters) {
					[pe renderParticles];
				}
				[ansuzBall renderParticles];
				break;
			case 1:
				[ansuzBall renderParticles];
				break;
			case 2:
				[explosion renderParticles];
				break;


			default:
				break;
		}
	}
}

- (void)calculateDamage {
	
	float damage;
    BattleRoderick *roderick = [sharedGameController.battleCharacters objectForKey:@"BattleRoderick"];
	for (AbstractBattleCharacter *character in sharedGameController.currentScene.activeEntities) {
        if ([character isKindOfClass:[AbstractBattleCharacter class]] && character.isAlive) {
            damage += (float)((character.power + character.powerModifier) * 4 * 1.2) * (float)(character.essence / character.maxEssence);
            //NSLog(@"Damage added: %f", (float)((character.power + character.powerModifier) * 4 * 1.2) * (float)(character.essence / character.maxEssence));
            character.essence -= (character.maxEssence * 0.1);
        }
	}
	for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
		if ([enemy isKindOfClass:[AbstractBattleEnemy class]] && enemy.isAlive) {
			[enemy flashColor:explosion.startColor];
            float newDamage = (damage / 2) - (enemy.affinity + enemy.affinityModifier) + ((arc4random() % 10) * ((roderick.level + roderick.levelModifier) / 10 + 1));
			[enemy youTookDamage:(int)(newDamage)];
		}
	}
}

@end

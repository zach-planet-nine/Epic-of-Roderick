//
//  FirstPriestAttack.m
//  TEORBattleTest
//
//  Created by Zach Babb on 5/29/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "FirstPriestAttack.h"
#import "ParticleEmitter.h"
#import "GameController.h"
#import "AbstractBattleEnemy.h"
#import "BattlePriest.h"
#import "AbstractBattleCharacter.h"
#import "BitmapFont.h"


@implementation FirstPriestAttack

- (void)dealloc {
	
	if (priestExplosion) {
		[priestExplosion release];
	}
	[super dealloc];
}

- (id)initToEnemy:(AbstractBattleEnemy *)aEnemy {
	
	if (self = [super init]) {
		priest = [sharedGameController.battleCharacters objectForKey:@"BattlePriest"];
		priestExplosion = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"PriestExplosion.pex"];
		priestExplosion.sourcePosition = Vector2fMake(aEnemy.renderPoint.x - 20, aEnemy.renderPoint.y + 20);
		explosions = 2;
		duration = 0;
		stage = 0;
		active = YES;
		target1 = aEnemy;
        damage = [priest calculateAttackDamageTo:aEnemy];
		hasAttacked = NO;
	}
	return self;
}

- (id)initToEnemy:(AbstractBattleEnemy *)aEnemy waiting:(float)aWaitTime {
    
    if (self = [super init]) {
        self = [self initToEnemy:aEnemy];
        stage = 4;
        duration = aWaitTime;
    }
    return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	duration -= aDelta;
	if (duration < 0) {
		switch (stage) {
			case 0:
				[self updatePriestExplosion];
				break;
			case 1:
				active = NO;
				break;
            case 4:
                stage = 0;
                duration = 0;
                break;

			default:
				break;
		}
	}
	if (active) {
		if (priest.isAttacking || !hasAttacked) {
			switch (stage) {
				case 0:
					[priestExplosion updateWithDelta:aDelta];
					/*if (renderDamage && fontRenderPoint.y > target1.renderPoint.y - 40) {
						//fontRenderPoint.y -= aDelta * 10;
					} else if (fontRenderPoint.y <= target1.renderPoint.y - 40) {
						renderDamage = NO;
					}*/

					break;
					
				default:
					break;
			}			
		} else {
			stage = 1;
			active = NO;
		}

	}
}

- (void)render {
	
	if (active) {
		[priestExplosion renderParticles];
		//if (renderDamage) {
		//	[battleFont renderStringAt:fontRenderPoint text:[NSString stringWithFormat:@"%d", damage]];
		//}
	}
}

- (void)updatePriestExplosion {
	
	if (!priestExplosion.active) {
		explosions--;
		switch (explosions) {
			case 0:
				explosions = 3;
				duration = 2.0;
				renderDamage = YES;
				[self calculateEffectFrom:priest to:target1];
				priestExplosion.sourcePosition = Vector2fMake(target1.renderPoint.x - 30, target1.renderPoint.y - 25);
				priestExplosion.active = YES;
				fontRenderPoint = CGPointMake(target1.renderPoint.x - 50, target1.renderPoint.y - 20);
				hasAttacked = YES;
				break;
			case 1:
				priestExplosion.sourcePosition = Vector2fMake(target1.renderPoint.x + 25, target1.renderPoint.y + 5);
				priestExplosion.active = YES;
				break;
			case 2:
				priestExplosion.sourcePosition = Vector2fMake(target1.renderPoint.x - 20, target1.renderPoint.y + 20);
				priestExplosion.active = YES;
				break;

			default:
				break;
		}
	}
}

- (void)calculateEffectFrom:(AbstractBattleCharacter *)aOriginator to:(AbstractBattleEnemy *)aTarget {
    [target1 youTookDamage:damage];
    [priest loseEndurance];
	damage = [aOriginator calculateAttackDamageTo:aTarget];
}

@end

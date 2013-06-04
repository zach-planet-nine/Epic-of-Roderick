//
//  SpearShower.m
//  TEORBattleTest
//
//  Created by Zach Babb on 5/24/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "SpearShower.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleEnemy.h"
#import "AbstractBattleCharacter.h"
#import "Projectile.h"
#import "BitmapFont.h"
#import "BattleValkyrie.h"
#import "Global.h"
#import "Projectile.h"
#import "PackedSpriteSheet.h"
#import "SpriteSheet.h"

@implementation SpearShower

-(void)dealloc {
	
	if (spears) {
		[spears release];
	}
	
	[super dealloc];
}

- (id)initToEnemy:(AbstractBattleEnemy *)aEnemy {
	
	if (self = [super init]) {
		
		spears = [[NSMutableArray alloc] init];
		valkyrie = [sharedGameController.battleCharacters objectForKey:@"BattleValkyrie"];
        //NSLog(@"Rage meter is %f.", valkyrie.rageMeter);
		spearCount = MAX(1, (int)((((valkyrie.maxHP + (valkyrie.level * 2)) - valkyrie.rageMeter) / (valkyrie.maxHP + (valkyrie.level * 2))) * 4));
		target1 = aEnemy;
		damage = 0;
		for (int i = 0; i < spearCount; i++) {
            damage += [valkyrie calculateSpearShowerDamageTo:aEnemy];
			float xMod = (RANDOM_MINUS_1_TO_1() * 30);
			float yMod = (RANDOM_MINUS_1_TO_1() * 40);
			float angle = atanf((aEnemy.renderPoint.y + yMod - valkyrie.renderPoint.y + 40) / (aEnemy.renderPoint.x + xMod - valkyrie.renderPoint.x)) * 57.2957795;
			if (angle < 0 && aEnemy.renderPoint.x + xMod - valkyrie.renderPoint.x < 0) {
				angle += 180;
			} else if (angle < 0 && aEnemy.renderPoint.y + yMod - valkyrie.renderPoint.y < 0) {
				angle += 360;
			} else if (aEnemy.renderPoint.x + xMod - valkyrie.renderPoint.x < 0 && aEnemy.renderPoint.y + yMod - valkyrie.renderPoint.y < 0) {
				angle += 180;
			}
			Projectile *spear = [[Projectile alloc] initProjectileFrom:Vector2fMake(valkyrie.renderPoint.x, valkyrie.renderPoint.y + 40) 
														to:Vector2fMake(aEnemy.renderPoint.x + xMod, aEnemy.renderPoint.y + yMod) 
								  withImageFromSpriteSheet:[sharedGameController.teorPSS imageForKey:@"Spear80x5.png"] 
												   lasting:0.4 withStartAngle:angle 
											 withStartSize:Scale2fMake(1, 1) 
											  toFinishSize:Scale2fMake(1, 1)];
			[spears addObject:spear];
			[spear release];
		}
		stage = 0;
		duration = 0.4;
		active = YES;
		
	}
	
	return self;
}

- (id)initToEnemy:(AbstractBattleEnemy *)aEnemy from:(BattleValkyrie *)aValkyrie {
	
	if (self = [super init]) {
		
		spears = [[NSMutableArray alloc] init];
		valkyrie = aValkyrie;
		spearCount = MAX(1, (int)(valkyrie.rageMeter / 20));
		target1 = aEnemy;
		
		for (int i = 0; i < spearCount; i++) {
			float xMod = (RANDOM_MINUS_1_TO_1() * 30);
			float yMod = (RANDOM_MINUS_1_TO_1() * 40);
			float angle = atanf((aEnemy.renderPoint.y + yMod - valkyrie.renderPoint.y + 40) / (aEnemy.renderPoint.x + xMod - valkyrie.renderPoint.x)) * 57.2957795;
			if (angle < 0 && aEnemy.renderPoint.x + xMod - valkyrie.renderPoint.x < 0) {
				angle += 180;
			} else if (angle < 0 && aEnemy.renderPoint.y + yMod - valkyrie.renderPoint.y < 0) {
				angle += 360;
			} else if (aEnemy.renderPoint.x + xMod - valkyrie.renderPoint.x < 0 && aEnemy.renderPoint.y + yMod - valkyrie.renderPoint.y < 0) {
				angle += 180;
			}
			Projectile *spear = [[Projectile alloc] initProjectileFrom:Vector2fMake(valkyrie.renderPoint.x, valkyrie.renderPoint.y + 40) 
																	to:Vector2fMake(aEnemy.renderPoint.x + xMod, aEnemy.renderPoint.y + yMod) 
											  withImageFromSpriteSheet:[sharedGameController.teorPSS imageForKey:@"Spear80x5.png"] 
															   lasting:0.4 withStartAngle:angle 
														 withStartSize:Scale2fMake(1, 1) 
														  toFinishSize:Scale2fMake(1, 1)];
			[spears addObject:spear];
			[spear release];
		}
		stage = 0;
		duration = 0.4;
		active = YES;
		
	}
	
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	duration -= aDelta;
	if (duration < 0) {
		switch (stage) {
			case 0:
				[target1 youTookDamage:damage];
				duration = 0.2;
				stage = 1;
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
				for (Projectile *spear in spears) {
					[spear updateWithDelta:aDelta];
				}
				break;
			default:
				break;
		}
	}
					
}

- (void)render {
	
	if (active) {
		for (Projectile *spear in spears) {
			[spear render];
		}		
	}
}

- (void)resetAnimation {
	
	stage = 0;
	[spears removeAllObjects];
	for (int i = 0; i < spearCount; i++) {
		float xMod = (RANDOM_MINUS_1_TO_1() * 30);
		float yMod = (RANDOM_MINUS_1_TO_1() * 40);
		float angle = atanf((target1.renderPoint.y + yMod - valkyrie.renderPoint.y + 40) / (target1.renderPoint.x + xMod - valkyrie.renderPoint.x)) * 57.2957795;
		if (angle < 0 && target1.renderPoint.x + xMod - valkyrie.renderPoint.x < 0) {
			angle += 180;
		} else if (angle < 0 && target1.renderPoint.y + yMod - valkyrie.renderPoint.y < 0) {
			angle += 360;
		} else if (target1.renderPoint.x + xMod - valkyrie.renderPoint.x < 0 && target1.renderPoint.y + yMod - valkyrie.renderPoint.y < 0) {
			angle += 180;
		}
		Projectile *spear = [[Projectile alloc] initProjectileFrom:Vector2fMake(valkyrie.renderPoint.x, valkyrie.renderPoint.y + 40) 
																to:Vector2fMake(target1.renderPoint.x + xMod, target1.renderPoint.y + yMod) 
										  withImageFromSpriteSheet:[sharedGameController.teorPSS imageForKey:@"Spear80x5.png"] 
														   lasting:0.4 withStartAngle:angle 
													 withStartSize:Scale2fMake(1, 1) 
													  toFinishSize:Scale2fMake(1, 1)];
		[spears addObject:spear];
		[spear release];
	}
	duration = 0.4;
	active = YES;
}
	

@end

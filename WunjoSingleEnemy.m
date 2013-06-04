//
//  WunjoSingleEnemy.m
//  TEORBattleTest
//
//  Created by Zach Babb on 6/2/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "WunjoSingleEnemy.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleEnemy.h"
#import "Image.h"
#import "ParticleEmitter.h"

@implementation WunjoSingleEnemy

- (void)dealloc {
	
	if (skeleton) {
		[skeleton release];
	}
	if (groundBreaking) {
		[groundBreaking release];
	}
	[super dealloc];
}

- (id)initToEnemy:(AbstractBattleEnemy *)aEnemy {
	
	if (self = [super init]) {
		
		originator = [sharedGameController.battleCharacters objectForKey:@"BattlePriest"];
		target1 = aEnemy;
		skeleton = [[Image alloc] initWithImageNamed:@"Skeleton32x32.png" filter:GL_LINEAR];
		groundBreaking = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"GroundBreaking.pex"];
		groundBreaking.sourcePosition = Vector2fMake(target1.renderPoint.x - 70, target1.renderPoint.y - 60);
		skeleton.renderPoint = CGPointMake(target1.renderPoint.x - 70, target1.renderPoint.y - 60);
		stage = 0;
		active = YES;
		duration = 0.3;
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	duration -= aDelta;
	if (duration < 0) {
		switch (stage) {
			case 0:
				stage = 1;
				duration = 0.3;
				break;
			case 1:
				stage = 2;
				duration = 0.4;
				break;
			case 2:
				stage = 3;
				[self calculateEffectFrom:originator to:target1];
				duration = 0.3;
				break;
			case 3:
				stage = 4;
				active = NO;
				break;
			default:
				break;
		}
	}
	if (active) {
		switch (stage) {
			case 0:
				[groundBreaking updateWithDelta:aDelta];
				break;
			case 1:
				skeleton.renderPoint = CGPointMake(skeleton.renderPoint.x, skeleton.renderPoint.y + (aDelta * 50));
				[groundBreaking updateWithDelta:aDelta];
				break;
			case 2:
				skeleton.renderPoint = CGPointMake(skeleton.renderPoint.x + (aDelta * 100), skeleton.renderPoint.y);
				break;
			case 3:
				skeleton.color = Color4fMake(1, 1, 1, skeleton.color.alpha - aDelta * 5);
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
				[groundBreaking renderParticles];
				break;
			case 1:
				[groundBreaking renderParticlesWithImage:skeleton];
				break;
			case 2:
				[skeleton renderCenteredAtPoint:skeleton.renderPoint];
				break;
			case 3:
				[skeleton renderCenteredAtPoint:skeleton.renderPoint];
				break;
			default:
				break;
		}
	}
}

- (void)calculateEffectFrom:(AbstractBattleEntity *)aOriginator to:(AbstractBattleEntity *)aTarget {
	
	int damage = 35;
	[target1 flashColor:Color4fMake(1, 0, 0, 1)];
	[target1 youTookDamage:damage];
}

@end

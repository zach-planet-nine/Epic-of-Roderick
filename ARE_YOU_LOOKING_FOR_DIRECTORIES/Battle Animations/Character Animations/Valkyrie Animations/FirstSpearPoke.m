//
//  FirstSpearPoke.m
//  TEORBattleTest
//
//  Created by Zach Babb on 5/29/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "FirstSpearPoke.h"
#import "ParticleEmitter.h"
#import "Animation.h"
#import "Projectile.h"
#import "GameController.h"
#import "PackedSpriteSheet.h"
#import "AbstractBattleEnemy.h"
#import "AbstractBattleCharacter.h"
#import "BitmapFont.h"
#import "BattleValkyrie.h"

@implementation FirstSpearPoke

- (void)dealloc {
	
	if (spear) {
		[spear release];
	}
	if (bloodBurst) {
		[bloodBurst release];
	}
	[super dealloc];
}

- (id)initToEnemy:(AbstractBattleEnemy *)aEnemy {
	
	if (self = [super init]) {
		
		active = YES;
        
		stage = 0;
		BattleValkyrie *valk = [sharedGameController.battleCharacters objectForKey:@"BattleValkyrie"];
        originator = valk;
        damage = [valk calculateAttackDamageTo:aEnemy];

        float angle = atanf((aEnemy.renderPoint.y - originator.renderPoint.y) / (aEnemy.renderPoint.x - originator.renderPoint.x)) * 57.2957795;
		if (angle < 0 && aEnemy.renderPoint.x - originator.renderPoint.x < 0) {
			angle += 180;
		} else if (angle < 0 && aEnemy.renderPoint.y - originator.renderPoint.y < 0) {
			angle += 360;
		} else if (aEnemy.renderPoint.x - originator.renderPoint.x < 0 && aEnemy.renderPoint.y - originator.renderPoint.y < 0) {
			angle += 180;
		}
		spear = [[Projectile alloc] initProjectileFrom:Vector2fMake(originator.renderPoint.x, originator.renderPoint.y + 40) 
													to:Vector2fMake(aEnemy.renderPoint.x, aEnemy.renderPoint.y) 
											 withImageFromSpriteSheet:[sharedGameController.teorPSS imageForKey:@"Spear80x5.png"] 
											   lasting:0.3 withStartAngle:angle 
										 withStartSize:Scale2fMake(1, 1) 
										  toFinishSize:Scale2fMake(1, 1)];
		fontRenderPoint = CGPointMake(aEnemy.renderPoint.x + 40, aEnemy.renderPoint.y);
		bloodBurst = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"BloodBurst.pex"];
		bloodBurst.sourcePosition = Vector2fMake(aEnemy.renderPoint.x, aEnemy.renderPoint.y);
		bloodBurst.duration = 0.3;
		bloodBurst.active = NO;
		target1 = aEnemy;
		duration = 0.3;
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
	if (duration < 0.0) {
		switch (stage) {
			case 0:
				stage = 1;
				bloodBurst.active = YES;
				duration = 0.3;
				[self calculateEffectFrom:originator to:target1];
				break;
			case 1:
				stage = 2;
				active = NO;
				break;
            case 4:
                stage = 0;
                duration = 0.3;
			default:
				break;
		}
	}
	
	if (active) {
		switch (stage) {
			case 0:
				[spear updateWithDelta:aDelta];
				break;
			case 1:
				//fontRenderPoint.y -= aDelta * 10;
				[bloodBurst updateWithDelta:aDelta];
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
				[spear render];
				break;
			case 1:
				[bloodBurst renderParticles];
				//[battleFont renderStringAt:fontRenderPoint text:[NSString stringWithFormat:@"%d", damage]];
				break;

			default:
				break;
		}
	}
}

- (void)calculateEffectFrom:(AbstractBattleCharacter *)aOriginator to:(AbstractBattleEnemy *)aTarget {
	
	float critical = RANDOM_0_TO_1();
   if (critical > (100 - ((aOriginator.luck + aOriginator.luckModifier + aOriginator.criticalChance) * .01))) {
        //NSLog(@"Is it here?");
        [target1 youTookCriticalDamage:damage];
        return;
    }
    [target1 youTookDamage:damage];}

@end

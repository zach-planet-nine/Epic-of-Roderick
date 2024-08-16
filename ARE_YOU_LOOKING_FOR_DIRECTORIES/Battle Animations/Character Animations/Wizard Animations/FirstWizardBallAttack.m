//
//  FirstWizardBallAttack.m
//  TEORBattleTest
//
//  Created by Zach Babb on 5/29/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "FirstWizardBallAttack.h"
#import "Projectile.h"
#import "ParticleEmitter.h"
#import "BattleWizard.h"
#import "GameController.h"
#import "AbstractBattleEnemy.h"
#import "AbstractBattleCharacter.h"
#import "BitmapFont.h"
#import "PackedSpriteSheet.h"


@implementation FirstWizardBallAttack

- (void)dealloc {
	
	if (wizardBall) {
		[wizardBall release];
	}
	if (wizardBallExplosion) {
		[wizardBallExplosion release];
	}
	[super dealloc];
}

- (id)initToEnemy:(AbstractBattleEnemy *)aEnemy {
	
	if (self = [super init]) {
		active = YES;
		stage = 0;
		BattleWizard *wizard = [sharedGameController.battleCharacters objectForKey:@"BattleWizard"];
		float angle = atanf((aEnemy.renderPoint.y - originator.renderPoint.y) / (aEnemy.renderPoint.x - originator.renderPoint.x)) * 57.2957795;
		if (angle < 0 && aEnemy.renderPoint.x - originator.renderPoint.x < 0) {
			angle += 180;
		} else if (angle < 0 && aEnemy.renderPoint.y - originator.renderPoint.y < 0) {
			angle += 360;
		} else if (aEnemy.renderPoint.x - originator.renderPoint.x < 0 && aEnemy.renderPoint.y - originator.renderPoint.y < 0) {
			angle += 180;
		}
		originator = wizard;
        damage = [wizard calculateAttackDamageTo:aEnemy];
		power = [wizard findWizardBallPower];
        //NSLog(@"Power is: %f", power);
		wizardBall = [[Projectile alloc] initProjectileFrom:Vector2fMake(originator.renderPoint.x, originator.renderPoint.y + 40) 
														 to:Vector2fMake(aEnemy.renderPoint.x, aEnemy.renderPoint.y) 
								   withImageFromSpriteSheet:[sharedGameController.teorPSS imageForKey:@"WizardBall15x15.png"] 
													lasting:0.5 withStartAngle:angle 
											  withStartSize:Scale2fMake(power, power) 
											   toFinishSize:Scale2fMake(power, power)];
		wizardBallExplosion = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"WizardBallExplosion.pex"];
		wizardBallExplosion.sourcePosition = Vector2fMake(aEnemy.renderPoint.x, aEnemy.renderPoint.y);
		wizardBallExplosion.duration = 0.2;
		wizardBallExplosion.active = NO;
		fontRenderPoint = CGPointMake(aEnemy.renderPoint.x - 40, aEnemy.renderPoint.y - 20);
		duration = 0.5;
		target1 = aEnemy;
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
				wizardBallExplosion.active = YES;
				[self calculateEffectFrom:originator to:target1];
				duration = 0.3;
				break;
			case 1:
				stage = 2;
				active = NO;
				break;

            case 4:
                stage = 0;
                duration = 0.5;
			default:
				break;
		}
	}
	
	if (active) {
		switch (stage) {
			case 0:
				[wizardBall updateWithDelta:aDelta];
				break;
			case 1:
				[wizardBallExplosion updateWithDelta:aDelta];
				//fontRenderPoint.y -= aDelta * 10;
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
				[wizardBall render];
				break;
			case 1:
				[wizardBallExplosion renderParticles];
				//[battleFont renderStringAt:fontRenderPoint text:[NSString stringWithFormat:@"%d", damage]];
				break;

			default:
				break;
		}
	}
}

- (void)calculateEffectFrom:(AbstractBattleEntity *)aOriginator to:(AbstractBattleEntity *)aTarget {
	
	float critical = RANDOM_0_TO_1();
    if (critical > (100 - ((aOriginator.luck + aOriginator.luckModifier + aOriginator.criticalChance) * .01))) {
        [target1 youTookCriticalDamage:damage];
        return;
    }
    [target1 youTookDamage:damage];

}
				

@end

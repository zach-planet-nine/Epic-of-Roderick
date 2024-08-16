//
//  FirstSwordSlash.m
//  TEORBattleTest
//
//  Created by Zach Babb on 5/29/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "FirstSwordSlash.h"
#import "Animation.h"
#import "GameController.h"
#import "PackedSpriteSheet.h"
#import "ParticleEmitter.h"
#import "AbstractBattleEntity.h"
#import "AbstractBattleCharacter.h"
#import "AbstractBattleEnemy.h"
#import "BitmapFont.h"



@implementation FirstSwordSlash

- (void)dealloc {
	
	if (slashAnimation) {
		[slashAnimation release];
	}
	if (bloodSplatter) {
		[bloodSplatter release];
	}
	[super dealloc];
}

- (id)initToEnemy:(AbstractBattleEnemy *)aEnemy {
	
	if (self = [super init]) {
		fontRenderPoint = CGPointMake(aEnemy.renderPoint.x + 20, aEnemy.renderPoint.y);
		active = YES;
		stage = 0;
		slashAnimation = [[Animation alloc] init];
		[slashAnimation addFrameWithImage:[sharedGameController.teorPSS imageForKey:@"Slash180x5.png"] delay:0.05];
		[slashAnimation addFrameWithImage:[sharedGameController.teorPSS imageForKey:@"Slash280x5.png"] delay:0.05];
		[slashAnimation addFrameWithImage:[sharedGameController.teorPSS imageForKey:@"Slash380x5.png"] delay:0.05];
		slashAnimation.state = kAnimationState_Running;
		slashAnimation.type = kAnimationType_Once;
		renderPoint = CGPointMake(aEnemy.renderPoint.x - 28, aEnemy.renderPoint.y - 28);
		rotation = 45;
		bloodSplatter = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"BloodSplatter.pex"];
		bloodSplatter.sourcePosition = Vector2fMake(aEnemy.renderPoint.x + 25, aEnemy.renderPoint.y + 25);
		//NSLog(@"blood splatters source position is: (%f, %f).", bloodSplatter.sourcePosition.x, bloodSplatter.sourcePosition.y);
		bloodSplatter.duration = 0.3;
		bloodSplatter.active = NO;
		duration = 0.12;
		target1 = aEnemy;
		originator = [sharedGameController.battleCharacters objectForKey:@"BattleRoderick"];
        damage = [originator calculateAttackDamageTo:aEnemy];
	}
	return self;
}

- (id)initToEnemy:(AbstractBattleEnemy *)aEnemy waiting:(float)aWaitTime {
    
    if (self = [super init]) {
		fontRenderPoint = CGPointMake(aEnemy.renderPoint.x + 20, aEnemy.renderPoint.y);
		active = YES;
		stage = 4;
		slashAnimation = [[Animation alloc] init];
		[slashAnimation addFrameWithImage:[sharedGameController.teorPSS imageForKey:@"Slash180x5.png"] delay:0.05];
		[slashAnimation addFrameWithImage:[sharedGameController.teorPSS imageForKey:@"Slash280x5.png"] delay:0.05];
		[slashAnimation addFrameWithImage:[sharedGameController.teorPSS imageForKey:@"Slash380x5.png"] delay:0.05];
		slashAnimation.state = kAnimationState_Running;
		slashAnimation.type = kAnimationType_Once;
		renderPoint = CGPointMake(aEnemy.renderPoint.x - 28, aEnemy.renderPoint.y - 28);
		rotation = 45;
		bloodSplatter = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"BloodSplatter.pex"];
		bloodSplatter.sourcePosition = Vector2fMake(aEnemy.renderPoint.x + 25, aEnemy.renderPoint.y + 25);
		bloodSplatter.duration = 0.3;
		bloodSplatter.active = NO;
		duration = aWaitTime;
		target1 = aEnemy;
		originator = [sharedGameController.battleCharacters objectForKey:@"BattleRoderick"];
        damage = [originator calculateAttackDamageTo:aEnemy];
	}

    return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	duration -= aDelta;
	if (duration < 0) {
		switch (stage) {
			case 0:
				stage = 1;
				bloodSplatter.active = YES;
				[self calculateEffectFrom:originator to:target1];
				duration = 0.3;
				break;
			case 1:
				active = NO;
				stage = 2;
				break;
            case 4:
                stage = 0;
                duration = 0.12;
                break;
			default:
				break;
		}
	}
	if (active) {
		switch (stage) {
			case 0:
				[slashAnimation updateWithDelta:aDelta];
				break;
			case 1:
				[bloodSplatter updateWithDelta:aDelta];
				fontRenderPoint.y -= aDelta * 10;
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
				[slashAnimation renderAtPoint:renderPoint scale:Scale2fMake(1, 1) rotation:rotation]; 
				break;
			case 1:
				[slashAnimation renderAtPoint:renderPoint scale:Scale2fMake(1, 1) rotation:rotation]; 
				[bloodSplatter renderParticles];
				//[battleFont renderStringAt:fontRenderPoint text:[NSString stringWithFormat:@"%d", damage]];
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
        [target1 youTookCriticalDamage:(damage * 2)];
        return;
    }
    [target1 youTookDamage:damage];

}

				 
	


@end

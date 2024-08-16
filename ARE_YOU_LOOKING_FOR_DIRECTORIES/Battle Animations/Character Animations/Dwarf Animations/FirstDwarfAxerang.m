//
//  FirstDwarfAxerang.m
//  TEORBattleTest
//
//  Created by Zach Babb on 5/29/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "FirstDwarfAxerang.h"
#import "GameController.h"
#import "BattleDwarf.h"
#import "AbstractBattleEnemy.h"
#import "AbstractBattleCharacter.h"
#import "Animation.h"
#import "Projectile.h"
#import "PackedSpriteSheet.h"


@implementation FirstDwarfAxerang

- (void)dealloc {
	
	if (axerang) {
		[axerang release];
	}
	if (slashAnimation) {
		[slashAnimation release];
	}
	[super dealloc];
}

- (id)initToEnemy:(AbstractBattleEnemy *)aEnemy {
	
	if (self = [super init]) {
		
		BattleDwarf *dwarf = [sharedGameController.battleCharacters objectForKey:@"BattleDwarf"];
		target1 = aEnemy;
		originator = dwarf;
        damage = [dwarf calculateAttackDamageTo:aEnemy];
		slashAnimation = [[Animation alloc] init];
		[slashAnimation addFrameWithImage:[sharedGameController.teorPSS imageForKey:@"Slash180x5.png"] delay:0.05];
		[slashAnimation addFrameWithImage:[sharedGameController.teorPSS imageForKey:@"Slash280x5.png"] delay:0.05];
		[slashAnimation addFrameWithImage:[sharedGameController.teorPSS imageForKey:@"Slash380x5.png"] delay:0.05];
		
		float angle = atanf((aEnemy.renderPoint.y + 20 - originator.renderPoint.y) / (aEnemy.renderPoint.x + 50 - originator.renderPoint.x));
		Vector2f vector = Vector2fMake(30 * cosf(angle), 30 * sinf(angle));
		angle *= 57.2957795;
		if (angle < 0 && aEnemy.renderPoint.x - originator.renderPoint.x < 0) {
			angle += 180;
		} else if (angle < 0 && aEnemy.renderPoint.y - originator.renderPoint.y < 0) {
			angle += 360;
		} else if (aEnemy.renderPoint.x - originator.renderPoint.x < 0 && aEnemy.renderPoint.y - originator.renderPoint.y < 0) {
			angle += 180;
		}
		
		fontRenderPoint = CGPointMake(aEnemy.renderPoint.x - 30, aEnemy.renderPoint.y - 20);
		
		slashAnimation.state = kAnimationState_Stopped;
		slashAnimation.type = kAnimationType_Once;
		renderPoint = CGPointMake(aEnemy.renderPoint.x - 32, aEnemy.renderPoint.y - 15);
		rotation = angle;
		
		//Remember this needs to be updated to the packed sprite sheet.
		/*axerang = [[Projectile alloc] initProjectileFrom:Vector2fMake(originator.renderPoint.x + 20, originator.renderPoint.y) 
													  to:Vector2fMake(aEnemy.renderPoint.x + vector.x, aEnemy.renderPoint.y + vector.y) 
											   withImage:@"Axerang.png" lasting:0.5 
										  withStartAngle:angle 
										   withStartSize:Scale2fMake(1, 1) 
											toFinishSize:Scale2fMake(1, 1) 
											   revolving:YES];*/
        axerang = [[Projectile alloc] initProjectileFrom:Vector2fMake(originator.renderPoint.x + 20, originator.renderPoint.y) 
                                                      to:Vector2fMake(aEnemy.renderPoint.x + vector.x, aEnemy.renderPoint.y + vector.y) withSSImage:[sharedGameController.teorPSS imageForKey:@"Scythe.png"] lasting:0.5 withStartAngle:angle withStartSize:Scale2fMake(1, 1) toFinishSize:Scale2fMake(1, 1) revolving:YES];
		axerang.isBoomerang = YES;
		stage = 0;
		active = YES;
		duration = 0.5;
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
				stage = 1;
				slashAnimation.state = kAnimationState_Running;
				duration = 0.4;
				[self calculateEffectFrom:originator to:target1];
				break;
			case 1:
				stage = 2;
				active = NO;
				break;
            case 4:
                stage = 0;
                duration = 0.5;
                break;

			default:
				break;
		}
	}
	if (active) {
		switch (stage) {
			case 0:
				[axerang updateWithDelta:aDelta];
				break;
			case 1:
				[axerang updateWithDelta:aDelta];
				[slashAnimation updateWithDelta:aDelta];
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
				[axerang render];
				break;
			case 1:
				[axerang render];
				[slashAnimation renderAtPoint:renderPoint scale:Scale2fMake(1, 1) rotation:rotation];
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

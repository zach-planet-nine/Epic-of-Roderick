//
//  WizardAttack.m
//  TEORBattleTest
//
//  Created by Zach Babb on 5/24/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "WizardAttack.h"
#import "Projectile.h"
#import "BitmapFont.h"


@implementation WizardAttack

- (void)dealloc {
	
	if (wizardBall) {
		[wizardBall release];
	}
	[super dealloc];
}

- (id)initWithCharacter:(int)aCharacter toEnemy:(int)aEnemy withPower:(float)aPower {
	
	if (self = [super init]) {
		if (aCharacter == 3 && aEnemy == 1) {
			
			float size = aPower;
			if (size > 3) {
				size = 3;
			}
			if (size < 0.5) {
				size = 0.5;
			}
			wizardBall = [[Projectile alloc] initProjectileFrom:Vector2fMake(60, 80) to:Vector2fMake(300, 140) withImage:@"WizardBall.png" lasting:0.8 withStartAngle:0 withStartSize:Scale2fMake(size, size) toFinishSize:Scale2fMake(size, size)];
			stage = 0;
			duration = 0.8;
			active = YES;
		}
	}
	
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	if (active) {
		duration -= aDelta;
		if (duration < 0) {
			switch (stage) {
				case 0:
					stage = 1;
					duration = 0.6;
					fontRenderPoint = CGPointMake(290, 140);
					break;
				case 1:
					stage = 2;
					break;
				case 2:
					active = NO;
					break;

				default:
					break;
			}
		}
		[wizardBall updateWithDelta:aDelta];
		fontRenderPoint.y -= aDelta * 10;
	}
}

- (void)render {
	
	if (active) {
		switch (stage) {
			case 0:
				[wizardBall render];
				break;
			case 1:
			//	[battleFont renderStringAt:fontRenderPoint text:@"Damage!"];
				break;

			default:
				break;
		}
	}
}
	
@end

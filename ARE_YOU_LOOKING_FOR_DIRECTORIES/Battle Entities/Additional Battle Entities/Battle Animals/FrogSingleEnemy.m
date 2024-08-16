//
//  FrogSingleEnemy.m
//  TEORBattleTest
//
//  Created by Zach Babb on 6/1/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "FrogSingleEnemy.h"
#import "Frog.h"
#import "Image.h"
#import "AbstractBattleEnemy.h"


@implementation FrogSingleEnemy

-(void)dealloc {
	
	if (tongueAttack) {
		[tongueAttack release];
	}
	[super dealloc];
}

- (id)initToEnemy:(AbstractBattleEnemy *)aEnemy from:(Frog *)aFrog {
	
	if (self = [super init]) {
		frog = aFrog;
		target1 = aEnemy;
		tongueAttack = [[Image alloc] initWithImageNamed:@"TongueAttack.png" filter:GL_LINEAR];
		tongueAttack.rotation = 45;
		stage = 0;
		active = YES;
		duration = 0.35;
		[frog hopToPoint:CGPointMake(aEnemy.renderPoint.x - 60, aEnemy.renderPoint.y - 30)];
	}
	return self;
}

- (id)initSkillAnimationToEnemy:(AbstractBattleEnemy *)aEnemy from:(Frog *)aFrog {
	
	if (self = [super init]) {
		frog = aFrog;
		target1 = aEnemy;
		tongueAttack = [[Image alloc] initWithImageNamed:@"TongueAttack.png" filter:GL_LINEAR];
		tongueAttack.rotation = 45;
		stage = 4;
		active = YES;
		duration = 0.35;
		[frog hopToPoint:CGPointMake(aEnemy.renderPoint.x - 60, aEnemy.renderPoint.y - 30)];
	}
	return self;
}


- (void)updateWithDelta:(float)aDelta {
	
	duration -= aDelta;
	if (duration < 0) {
		switch (stage) {
			case 0:
				stage = 1;
				tongueAttack.renderPoint = CGPointMake(frog.renderPoint.x + 15, frog.renderPoint.y);
				duration = 0.4;
				break;
			case 1:
				stage = 2;
				[self calculateEffectFrom:frog to:target1];
				[frog hopBackToRanger];
				duration = 0.3;
				break;
			case 2:
				stage = 3;
				active = NO;
				break;
			case 4:
				stage = 5;
				tongueAttack.renderPoint = CGPointMake(frog.renderPoint.x + 15, frog.renderPoint.y);
				duration = 0.4;
				break;
			case 5:
				stage = 6;
				[frog hopToPoint:CGPointMake(100, 90)];
				duration = 0.3;
				break;
			case 6:
				stage = 7;
				active = NO;
				break;

			default:
				break;
		}
	}
}

- (void)render {
	
	if (active && (stage == 1 || stage == 5)) {
		[tongueAttack renderAtPoint:tongueAttack.renderPoint];
	}
}

- (void)calculateEffectFrom:(AbstractBattleEntity *)aOriginator to:(AbstractBattleEntity *)aTarget {
	
	int damage = 30;
	[target1 flashColor:Color4fMake(1, 0, 0, 1)];
	[target1 youTookDamage:damage];
}

- (void)resetAnimation {
	
	stage = 4;
	active = YES;
	duration = 0.35;
	[frog hopToPoint:CGPointMake(target1.renderPoint.x - 60, target1.renderPoint.y - 30)];
}
	

@end

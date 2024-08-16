//
//  Dwarfapult.m
//  TEORBattleTest
//
//  Created by Zach Babb on 6/2/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "Dwarfapult.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleEnemy.h"
#import "AbstractBattleCharacter.h"
#import "BattleDwarf.h"
#import "Animation.h"
#import "Image.h"


@implementation Dwarfapult

- (void)dealloc {
	
	if (catapult) {
		[catapult release];
	}
	[super dealloc];
}

- (id)initToEnemy:(AbstractBattleEnemy *)aEnemy {
	
	if (self = [super init]) {
		
		originator = [sharedGameController.battleCharacters objectForKey:@"BattleDwarf"];
		originalPoint = originator.renderPoint;
		target1 = aEnemy;
		catapult = [[Animation alloc] init];
		Image *catapultArmHorizontal = [[Image alloc] initWithImageNamed:@"CatapultArm.png" filter:GL_LINEAR];
		Image *catapultArmHalfway = [[Image alloc] initWithImageNamed:@"CatapultArm.png" filter:GL_LINEAR];
		Image *catapultArmUp = [[Image alloc] initWithImageNamed:@"CatapultArm.png" filter:GL_LINEAR];
		catapultArmHorizontal.rotationPoint = CGPointMake(30, 0);
		catapultArmUp.rotationPoint = CGPointMake(30, 0);
		catapultArmHorizontal.rotation = 315;
		catapultArmUp.rotation = 45;
		[catapult addFrameWithImage:catapultArmHorizontal delay:0.08];
		[catapult addFrameWithImage:catapultArmHalfway delay:0.08];
		[catapult addFrameWithImage:catapultArmUp delay:0.08];
		[catapultArmUp release];
		[catapultArmHalfway release];
		[catapultArmHorizontal release];
		catapult.state = kAnimationState_Stopped;
		catapult.type = kAnimationType_Once;
		catapultFrame = [[Image alloc] initWithImageNamed:@"CatapultFrame.png" filter:GL_LINEAR];
		catapultFrame.renderPoint = CGPointMake(0, originator.renderPoint.y);
		originator.renderPoint = CGPointMake(-30, originator.renderPoint.y);
		catapult.renderPoint = CGPointMake(0, originator.renderPoint.y + 25);
		stage = 0;
		active = YES;
		duration = 0.6;
		
		
	}
	return self;
}

- (id)initToEnemy:(AbstractBattleEnemy *)aEnemy from:(BattleDwarf *)aDwarf {
	
	if (self = [super init]) {
		
		originator = aDwarf;
		originalPoint = originator.renderPoint;
		target1 = aEnemy;
		catapult = [[Animation alloc] init];
		Image *catapultArmHorizontal = [[Image alloc] initWithImageNamed:@"CatapultArm.png" filter:GL_LINEAR];
		Image *catapultArmHalfway = [[Image alloc] initWithImageNamed:@"CatapultArm.png" filter:GL_LINEAR];
		Image *catapultArmUp = [[Image alloc] initWithImageNamed:@"CatapultArm.png" filter:GL_LINEAR];
		catapultArmHorizontal.rotationPoint = CGPointMake(30, 0);
		catapultArmUp.rotationPoint = CGPointMake(30, 0);
		catapultArmHorizontal.rotation = 315;
		catapultArmUp.rotation = 45;
		[catapult addFrameWithImage:catapultArmHorizontal delay:0.08];
		[catapult addFrameWithImage:catapultArmHalfway delay:0.08];
		[catapult addFrameWithImage:catapultArmUp delay:0.08];
		[catapultArmUp release];
		[catapultArmHalfway release];
		[catapultArmHorizontal release];
		catapult.state = kAnimationState_Stopped;
		catapult.type = kAnimationType_Once;
		catapultFrame = [[Image alloc] initWithImageNamed:@"CatapultFrame.png" filter:GL_LINEAR];
		catapultFrame.renderPoint = CGPointMake(0, originator.renderPoint.y);
		originator.renderPoint = CGPointMake(-30, originator.renderPoint.y);
		catapult.renderPoint = CGPointMake(0, originator.renderPoint.y + 25);
		stage = 0;
		active = YES;
		duration = 0.6;
		
		
	}
	return self;
}

	

- (void)updateWithDelta:(float)aDelta {
	
	duration -= aDelta;
	if (duration < 0) {
		switch (stage) {
			case 0:
				stage = 1;
				originator.renderPoint = CGPointMake(catapultFrame.renderPoint.x - 20, catapultFrame.renderPoint.y + 25);
				velocity = Vector2fMake((target1.renderPoint.x - originator.renderPoint.x) / 0.8, 700 / 0.8);
				gravity = (2 * (target1.renderPoint.y - originator.renderPoint.y - (velocity.y * 0.8))) / (powf(0.8, 2));
				catapult.state = kAnimationState_Running;
				duration = 0.8;
				break;
			case 1:
				stage = 2;
				duration = 0.2;
				[self calculateEffectFrom:originator to:target1];
				velocity = Vector2fMake((originalPoint.x - originator.renderPoint.x) / 0.2, (originalPoint.y - originator.renderPoint.y) / 0.2);
				break;
			case 2:
				stage = 3;
				originator.renderPoint = originalPoint;
				active = NO;
				break;
			default:
				break;
		}
	}
	if (active) {
		switch (stage) {
			case 0:
				catapultFrame.renderPoint = CGPointMake(catapultFrame.renderPoint.x + aDelta * 70, catapultFrame.renderPoint.y);
				catapult.renderPoint = CGPointMake(catapult.renderPoint.x + aDelta * 70, catapult.renderPoint.y);
				originator.renderPoint = CGPointMake(originator.renderPoint.x + aDelta * 70, originator.renderPoint.y);
				break;
			case 1:
				[catapult updateWithDelta:aDelta];
				velocity = Vector2fMake(velocity.x, velocity.y + (gravity * aDelta));
				originator.renderPoint = CGPointMake(originator.renderPoint.x + (velocity.x * aDelta), originator.renderPoint.y + (velocity.y * aDelta));
				break;
			case 2:
				originator.renderPoint = CGPointMake(originator.renderPoint.x + (velocity.x * aDelta), originator.renderPoint.y + (velocity.y * aDelta));
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
				[catapultFrame renderCenteredAtPoint:catapultFrame.renderPoint];
				[catapult renderCenteredAtPoint:catapult.renderPoint];
				break;
			case 1:
				[catapultFrame renderCenteredAtPoint:catapultFrame.renderPoint];
				[catapult renderCenteredAtPoint:catapult.renderPoint];
				break;

			default:
				break;
		}
	}
}

- (void)calculateEffectFrom:(AbstractBattleEntity *)aOriginator to:(AbstractBattleEntity *)aTarget {
	
	[target1 youTookDamage:50];
	[target1 flashColor:Color4fMake(1, 0, 0, 1)];
}

- (void)resetAnimation {
	catapultFrame.renderPoint = CGPointMake(0, originator.renderPoint.y);
	originator.renderPoint = CGPointMake(-30, originator.renderPoint.y);
	catapult.renderPoint = CGPointMake(0, originator.renderPoint.y + 25);
	stage = 0;
	active = YES;
	duration = 0.6;
}	
	
	

@end

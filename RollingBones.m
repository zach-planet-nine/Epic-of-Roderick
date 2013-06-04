//
//  RollingBones.m
//  TEORBattleTest
//
//  Created by Zach Babb on 5/31/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "RollingBones.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "BattleWizard.h"
#import "Projectile.h"


@implementation RollingBones

- (void)dealloc {
	
	if (bones) {
		[bones release];
	}
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
		
		wizard = [sharedGameController.battleCharacters objectForKey:@"BattleWizard"];
		
		bones = [[NSMutableArray alloc] init];
		
		for (int i = 0; i < 3; i++) {
			Projectile *bone = [[Projectile alloc] initProjectileFrom:Vector2fMake(60, 65) to:Vector2fMake(200 + (i * 20), 50) withImage:@"Bone.png" lasting:1.3 withStartAngle:50 withStartSize:Scale2fMake(1, 1) toFinishSize:Scale2fMake(1, 1) revolving:YES];
			[bones addObject:bone];
			[bone release];
		}
		
		active = YES;
		duration = 1.3;
		stage = 0;
	}
	return self;
}

- (id)initFrom:(BattleWizard *)aWizard {
	
	if (self = [super init]) {
		
		wizard = aWizard;
		
		bones = [[NSMutableArray alloc] init];
		
		for (int i = 0; i < 3; i++) {
			Projectile *bone = [[Projectile alloc] initProjectileFrom:Vector2fMake(60, 65) to:Vector2fMake(200 + (i * 20), 50) withImage:@"Bone.png" lasting:1.3 withStartAngle:50 withStartSize:Scale2fMake(1, 1) toFinishSize:Scale2fMake(1, 1) revolving:YES];
			[bones addObject:bone];
			[bone release];
		}
		
		active = YES;
		duration = 1.3;
		stage = 3;
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	
	duration -= aDelta;
	if (duration < 0) {
		switch (stage) {
			case 0:
				stage = 1;
				int roll = (int)(RANDOM_0_TO_1() * 5 + 1);
				[wizard youRolledA:roll];
				duration = 0.2;
				break;
			case 1:
				active = NO;
				break;
			case 3:
				stage = 4;
				duration = 0.1;
				break;
			case 4:
				active = NO;
				break;


				
			default:
				break;
		}
		
	}
	if (active) {
		switch (stage) {
			case 0:
				for (Projectile *bone in bones) {
					[bone updateWithDelta:aDelta];
				}
				break;
			case 3:
				for (Projectile *bone in bones) {
					[bone updateWithDelta:aDelta];
				}
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
				for (Projectile *bone in bones) {
					[bone render];
				}	
				break;
			case 3:
				for (Projectile *bone in bones) {
					[bone render];
				}
				break;

			default:
				break;
		}
	}
}

- (void)resetAnimation {
	
	[bones removeAllObjects];
	for (int i = 0; i < 3; i++) {
		Projectile *bone = [[Projectile alloc] initProjectileFrom:Vector2fMake(60, 65) to:Vector2fMake(200 + (i * 20), 50) withImage:@"Bone.png" lasting:1.3 withStartAngle:50 withStartSize:Scale2fMake(1, 1) toFinishSize:Scale2fMake(1, 1) revolving:YES];
		[bones addObject:bone];
		[bone release];
	}
	
	active = YES;
	duration = 1.3;
	stage = 3;
}

@end

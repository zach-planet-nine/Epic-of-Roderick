//
//  WizardBones.m
//  TEORBattleTest
//
//  Created by Zach Babb on 5/24/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "WizardBones.h"
#import "Projectile.h"
#import "Global.h"
#import "BitmapFont.h"


@implementation WizardBones

- (void)dealloc {
	
	if (bones) {
		[bones release];
	}
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
			
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

- (void)updateWithDelta:(float)aDelta {
	
	if (active) {
		for (int i = 0; i < [bones count]; i++) {
			[[bones objectAtIndex:i] updateWithDelta:aDelta];
		}		
		duration -= aDelta;
		fontRenderPoint.y -= aDelta * 10;
		if (duration < 0) {
			switch (stage) {
				case 0:
					stage = 1;
				//	battleFont = [[BitmapFont alloc] initWithFontImageNamed:@"TimesNewRoman32.png" controlFile:@"TimesNewRoman32" scale:Scale2fMake(0.5, 0.5) filter:GL_LINEAR];
					fontRenderPoint = CGPointMake(200, 80);
					roll = (int)(RANDOM_0_TO_1() * 5 + 1);
					duration = 0.8;
					break;
				case 1:
					active = NO;
					break;

				default:
					break;
			}
			
		}
	}
}

- (void)render {
	
	if (active) {
		switch (stage) {
			case 0:
				////NSLog(@"It should render.");
				for (int i = 0; i < [bones count]; i++) {
					[[bones objectAtIndex:i] render];
				}	
				break;
			case 1:
				//[battleFont renderStringAt:fontRenderPoint text:[NSString stringWithFormat:@"You rolled a '%d'.", roll]];
				 break;
			default:
				break;
		}
	}
}


@end

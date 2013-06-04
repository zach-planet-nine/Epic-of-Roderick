//
//  Slash.m
//  TEORBattleTest
//
//  Created by Zach Babb on 5/22/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "Slash.h"
#import "SpriteSheet.h"
#import "Animation.h"
#import "BitmapFont.h"


@implementation Slash

@synthesize active;

- (void)dealloc {
	
	if (slashAnimation) {
		[slashAnimation release];
	}
	[super dealloc];
}

- (id)initWithCharacter:(int)aCharacter enemy:(int)aEnemy fromPoint:(CGPoint)aFromPoint toPoint:(CGPoint)aToPoint {
	
	if (self = [super init]) {
		if (aCharacter == 1 && aEnemy == 1) {
			rotation = atanf((aToPoint.y - aFromPoint.y) / (aToPoint.x - aFromPoint.x)) * 57.2957795;
			//NSLog(@"Rotation is: '%f'.", rotation);
			SpriteSheet *slashSheet = [[SpriteSheet alloc] initWithImageNamed:@"SlashSheet.png" spriteSize:CGSizeMake(100, 5) spacing:0 margin:0 imageFilter:GL_LINEAR];
			slashAnimation = [[Animation alloc] init];
			for (int i = 0; i < 3; i++) {
				Image *image = [slashSheet spriteImageAtCoords:CGPointMake(i, 0)];
				image.rotationPoint = CGPointMake(50, 3);
				[slashAnimation addFrameWithImage:image delay:0.07];
			}
			slashAnimation.state = kAnimationState_Running;
			slashAnimation.type = kAnimationType_Once;
			renderPoint = CGPointMake((aToPoint.x + aFromPoint.x) / 2, (aToPoint.y + aFromPoint.y) / 2);
			active = YES;
			duration = 0.0;
			fontRenderPoint = renderPoint;
			battleFont = [[BitmapFont alloc] initWithFontImageNamed:@"TimesNewRoman32.png" controlFile:@"TimesNewRoman32" scale:Scale2fMake(0.5, 0.5) filter:GL_LINEAR];
		}
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	[slashAnimation updateWithDelta:aDelta];
	if (duration > 0.0) {
		fontRenderPoint.y -= aDelta * 10;
		duration -= aDelta;
	}
	if (duration < 0.0) {
		active = NO;
	}
	if (slashAnimation.state == kAnimationState_Stopped && duration == 0.0) {
		duration = 2.0;
	}
}

- (void)render {
	
	[slashAnimation renderCenteredAtPoint:renderPoint scale:Scale2fMake(1, 1) rotation:rotation];
	if (slashAnimation.state == kAnimationState_Stopped) {
		[battleFont renderStringAt:fontRenderPoint text:@"Damage!"];
	}
}


@end

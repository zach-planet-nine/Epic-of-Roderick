//
//  Spear.m
//  TEORBattleTest
//
//  Created by Zach Babb on 5/22/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "Spear.h"
#import "Animation.h"
#import "Image.h"
#import "SpriteSheet.h"
#import "BitmapFont.h"


@implementation Spear

- (void)dealloc {
	
	if (animation) {
		[animation release];
	}
	
	[super dealloc];
}

- (id)initWithCharacter:(int)aCharacter enemy:(int)aEnemy atPoint:(CGPoint)aPoint {
	
	if (self = [super init]) {
		if (aCharacter == 2 && aEnemy == 1) {
			animation = [[Animation alloc] init];
			
			SpriteSheet *spearSheet = [[SpriteSheet alloc] initWithImageNamed:@"SpearSheet.png" spriteSize:CGSizeMake(40, 40) spacing:0 margin:0 imageFilter:GL_LINEAR];
			
			[animation addFrameWithImage:[spearSheet spriteImageAtCoords:CGPointMake(2, 0)] delay:0.1];
			[animation addFrameWithImage:[spearSheet spriteImageAtCoords:CGPointMake(1, 0)] delay:0.1];
			[animation addFrameWithImage:[spearSheet spriteImageAtCoords:CGPointMake(0, 0)] delay:0.1];
			animation.state = kAnimationState_Stopped;
			animation.type = kAnimationType_Once;

			[spearSheet release];
			
			renderPoint = aPoint;
			spearImage = [[Image alloc] initWithImageNamed:@"Spear.png" filter:GL_LINEAR];
			spearImage.renderPoint = CGPointMake(aPoint.x - 60, aPoint.y);
			
			fontRenderPoint = aPoint;
			
			//battleFont = [[BitmapFont alloc] initWithFontImageNamed:@"TimesNewRoman32.png" controlFile:@"TimesNewRoman32" scale:Scale2fMake(0.7, 0.7) filter:GL_LINEAR];

			//NSLog(@"renderPoint is: ('%f', '%f').", renderPoint.x, renderPoint.y);
			//NSLog(@"spearImage.renderPoint is: ('%f', '%f').", spearImage.renderPoint.x, spearImage.renderPoint.y);
			active = YES;
			duration = 0.0;
		}
		
	}
	return self;

}

- (void)updateWithDelta:(float)aDelta {
	
	if (spearImage.renderPoint.x < renderPoint.x - 40) {
		spearImage.renderPoint = CGPointMake(spearImage.renderPoint.x + (aDelta * 50), renderPoint.y);
	} 
	if (spearImage.renderPoint.x > renderPoint.x - 40 && duration == 0.0) {
		duration = 0.4;
		spearImage.renderPoint = CGPointMake(renderPoint.x, renderPoint.y);
		animation.state = kAnimationState_Running;
	} 
	if (animation.state == kAnimationState_Running) {
		duration -= aDelta;
		[animation updateWithDelta:aDelta];
	}
	if (animation.state == kAnimationState_Stopped && duration > 0) {
		fontRenderPoint.y -= aDelta * 10;
		duration = 2;
	}
	if (fontRenderPoint.y < renderPoint.y - 20) {
		active = NO;
	}
	////NSLog(@"renderPoint is: ('%f', '%f').", renderPoint.x, renderPoint.y);
	////NSLog(@"spearImage.renderPoint is: ('%f', '%f').", spearImage.renderPoint.x, spearImage.renderPoint.y);

	
}

- (void)render {

	if (spearImage.renderPoint.x < renderPoint.x) {
		[spearImage renderCenteredAtPoint:spearImage.renderPoint];
	}
	if (animation.state == kAnimationState_Running) {
		[animation renderCenteredAtPoint:renderPoint];
	}
	if (fontRenderPoint.y < renderPoint.y) {
		//[battleFont renderStringAt:fontRenderPoint text:@"Damage!"];
	}
}

@end

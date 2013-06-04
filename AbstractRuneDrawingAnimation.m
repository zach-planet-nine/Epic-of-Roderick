//
//  AbstractRuneDrawingAnimation.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/4/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "AbstractRuneDrawingAnimation.h"
#import "PackedSpriteSheet.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "Image.h"

@implementation AbstractRuneDrawingAnimation

@synthesize essenceColor;
@synthesize runeText;
@synthesize rune;

- (void)dealloc {
	
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
		runeDrawingImage = [[GameController sharedGameController].teorPSS imageForKey:@"defaultTexture.png"];
		active = YES;
		stage = 0;
		duration = 0;
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	if (active) {
		duration -= aDelta;
		currentPosition = CGPointMake(currentPosition.x + (velocity.x * aDelta), currentPosition.y + (velocity.y * aDelta));
		if (velocity.x != 0 || velocity.y != 0) {
			Image *drawingImage = [[runeDrawingImage imageDuplicate] retain];
			drawingImage.color = essenceColor;
			drawingImage.renderPoint = currentPosition;
			[[GameController sharedGameController].currentScene addImageToDrawingImages:drawingImage];
			[drawingImage release];
		}
		
	}
}

- (void)render {}

- (void)moveFromPoint:(CGPoint)aFromPoint toPoint:(CGPoint)aToPoint {
	
	currentPosition = aFromPoint;
	velocity = Vector2fMake((aToPoint.x - aFromPoint.x) / 0.5, (aToPoint.y - aFromPoint.y) / 0.5);
	duration = 0.5;
}

- (void)resetAnimation {}
	

@end

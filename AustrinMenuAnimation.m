//
//  AustrinMenuAnimation.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/23/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "AustrinMenuAnimation.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "Image.h"

@implementation AustrinMenuAnimation

- (void)dealloc {
	
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
		[self moveFromPoint:CGPointMake(360, 270) toPoint:CGPointMake(260, 270)];
		essenceColor = Color4fMake(0, 1, 0, 1);
		runeText = @"The Eastern wind brings storm clouds and rain. It prevents an enemy from healing itself, and will lower all enemies' love of the sky. Meanwhile it makes your allies' runes more powerful or heals some of their essence.";
		rune = [[Image alloc] initWithImageNamed:@"Rune39.png" filter:GL_LINEAR];
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	[super updateWithDelta:aDelta];
	if (duration < 0) {
		switch (stage) {
			case 0:
				stage++;
				[self moveFromPoint:CGPointMake(360, 170) toPoint:CGPointMake(260, 170)];
				break;
			case 1:
				stage++;
				[self moveFromPoint:CGPointMake(360, 70) toPoint:CGPointMake(260, 70)];
				break;
			case 2:
				stage++;
				velocity = Vector2fMake(0, 0);
				duration = 2;
				break;
				
			case 3:
				[[GameController sharedGameController].currentScene removeDrawingImages];
				stage = 0;
				[self moveFromPoint:CGPointMake(360, 270) toPoint:CGPointMake(260, 270)];
				break;
				
			default:
				break;
		}
	}
}

- (void)resetAnimation {
    [self moveFromPoint:CGPointMake(360, 270) toPoint:CGPointMake(260, 270)];
	stage = 0;
}

@end

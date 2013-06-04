//
//  EkwazMenuAnimation.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/30/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "EkwazMenuAnimation.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "Image.h"

@implementation EkwazMenuAnimation

- (void)dealloc {
	
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
		[self moveFromPoint:CGPointMake(260, 170) toPoint:CGPointMake(310, 100)];
		essenceColor = Color4fMake(0, 1, 0, 1);
		runeText = @"Ekwaz is your basic stone rune. Using it on enemies allows you to satisfyingly drop rocks on them. Your allies will find their stamina increased by using it.";
		rune = [[Image alloc] initWithImageNamed:@"Rune145.png" filter:GL_LINEAR];
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	[super updateWithDelta:aDelta];
	if (duration < 0) {
		switch (stage) {
			case 0:
				stage++;
				[self moveFromPoint:CGPointMake(310, 100) toPoint:CGPointMake(360, 170)];
				break;
			case 1:
				stage++;
				[self moveFromPoint:CGPointMake(260, 170) toPoint:CGPointMake(360, 170)];
				break;
			case 2:
				stage++;
				velocity = Vector2fMake(0, 0);
				duration = 2;
				break;
				
			case 3:
				[[GameController sharedGameController].currentScene removeDrawingImages];
				stage = 0;
                [self moveFromPoint:CGPointMake(260, 170) toPoint:CGPointMake(310, 100)];
				break;
				
			default:
				break;
		}
	}
}

- (void)resetAnimation {
    [self moveFromPoint:CGPointMake(260, 170) toPoint:CGPointMake(310, 100)];
	stage = 0;
}

@end

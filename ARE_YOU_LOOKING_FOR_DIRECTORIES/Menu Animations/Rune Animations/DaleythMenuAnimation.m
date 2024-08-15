//
//  DaleythMenuAnimation.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/29/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "DaleythMenuAnimation.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "Image.h"

@implementation DaleythMenuAnimation

- (void)dealloc {
	
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
		[self moveFromPoint:CGPointMake(260, 270) toPoint:CGPointMake(330, 270)];
		essenceColor = Color4fMake(0, 0, 1, 1);
		runeText = @"Daleyth calls upon the little-known god Lamorak to assist you in battle. Used against your enemies will inflict divine damage. It can heal a single character back to full strength, and when used on all of your allies it can accelerate time!";
		rune = [[Image alloc] initWithImageNamed:@"Rune143.png" filter:GL_LINEAR];
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	[super updateWithDelta:aDelta];
	if (duration < 0) {
		switch (stage) {
			case 0:
				stage++;
				[self moveFromPoint:CGPointMake(330, 270) toPoint:CGPointMake(260, 150)];
				break;
			case 1:
				stage++;
				[self moveFromPoint:CGPointMake(360, 270) toPoint:CGPointMake(360, 150)];
				break;
			case 2:
				stage++;
				velocity = Vector2fMake(0, 0);
				duration = 2;
				break;
                
			case 3:
				[[GameController sharedGameController].currentScene removeDrawingImages];
				stage = 0;
                [self moveFromPoint:CGPointMake(260, 270) toPoint:CGPointMake(330, 270)];
				break;
                
			default:
				break;
		}
	}
}

- (void)resetAnimation {
	
    [self moveFromPoint:CGPointMake(260, 270) toPoint:CGPointMake(330, 270)];
	stage = 0;
}


@end

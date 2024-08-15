//
//  SowiloMenuAnimation.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/27/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "SowiloMenuAnimation.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "Image.h"

@implementation SowiloMenuAnimation

- (void)dealloc {
	
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
		[self moveFromPoint:CGPointMake(360, 270) toPoint:CGPointMake(260, 203)];
		essenceColor = Color4fMake(0, 1, 0, 1);
		runeText = @"Sowilo calls upon the help of the sun to disorient your enemies or heal your characters.";
		rune = [[Image alloc] initWithImageNamed:@"Rune253.png" filter:GL_LINEAR];
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	[super updateWithDelta:aDelta];
	if (duration < 0) {
		switch (stage) {
			case 0:
				stage++;
				[self moveFromPoint:CGPointMake(260, 203) toPoint:CGPointMake(360, 136)];
				break;
			case 1:
				stage++;
				[self moveFromPoint:CGPointMake(360, 136) toPoint:CGPointMake(260, 70)];
				break;
			case 2:
				stage++;
				velocity = Vector2fMake(0, 0);
				duration = 2;
				break;
				
			case 3:
				[[GameController sharedGameController].currentScene removeDrawingImages];
				stage = 0;
                [self moveFromPoint:CGPointMake(360, 270) toPoint:CGPointMake(260, 203)];
				break;
				
			default:
				break;
		}
	}
}

- (void)resetAnimation {
    [self moveFromPoint:CGPointMake(360, 270) toPoint:CGPointMake(260, 203)];
	stage = 0;
}


@end

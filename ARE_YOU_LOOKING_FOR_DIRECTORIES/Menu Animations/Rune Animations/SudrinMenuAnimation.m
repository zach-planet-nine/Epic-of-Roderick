//
//  SudrinMenuAnimation.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/22/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "SudrinMenuAnimation.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "Image.h"

@implementation SudrinMenuAnimation

- (void)dealloc {
	
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
		[self moveFromPoint:CGPointMake(260, 70) toPoint:CGPointMake(260, 270)];
		essenceColor = Color4fMake(0, 1, 0, 1);
		runeText = @"The Southern wind lends its healing abilities to your allies, restoring a bit of everything. It can grant one ally an all-around boost. Used on enemies it will fatigue a solitary enemy, while a big gust of wind will lower all of your enemies' affinities.";
		rune = [[Image alloc] initWithImageNamed:@"Rune111.png" filter:GL_LINEAR];
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	[super updateWithDelta:aDelta];
	if (duration < 0) {
		switch (stage) {
			case 0:
				stage++;
				[self moveFromPoint:CGPointMake(310, 70) toPoint:CGPointMake(310, 270)];
				break;
			case 1:
				stage++;
				[self moveFromPoint:CGPointMake(360, 70) toPoint:CGPointMake(360, 270)];
				break;
			case 2:
				stage++;
				velocity = Vector2fMake(0, 0);
				duration = 2;
				break;
				
			case 3:
				[[GameController sharedGameController].currentScene removeDrawingImages];
				stage = 0;
				[self moveFromPoint:CGPointMake(260, 70) toPoint:CGPointMake(260, 270)];
				break;
				
			default:
				break;
		}
	}
}

- (void)resetAnimation {
    [self moveFromPoint:CGPointMake(260, 270) toPoint:CGPointMake(260, 70)];
	stage = 0;
}


@end

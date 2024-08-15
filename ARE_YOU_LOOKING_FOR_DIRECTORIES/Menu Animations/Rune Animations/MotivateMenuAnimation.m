//
//  MotivateMenuAnimation.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 8/14/11.
//  Copyright (c) 2011 InstantLazer. All rights reserved.
//

#import "MotivateMenuAnimation.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "Image.h"

@implementation MotivateMenuAnimation

- (void)dealloc {
	
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
		[self moveFromPoint:CGPointMake(260, 170) toPoint:CGPointMake(360, 170)];
		essenceColor = Color4fMake(0, 0, 1, 1);
		runeText = @"Ordering Freya's drink will give Alvis an encouraging burst. He may use this to cleverly motivate your party.";
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
				[self moveFromPoint:CGPointMake(310, 220) toPoint:CGPointMake(360, 170)];
				break;
			case 1:
				stage++;
				[self moveFromPoint:CGPointMake(310, 120) toPoint:CGPointMake(360, 170)];
				break;
			case 2:
				stage++;
				velocity = Vector2fMake(0, 0);
				duration = 2;
				break;
                
			case 3:
				[[GameController sharedGameController].currentScene removeDrawingImages];
				stage = 0;
                [self moveFromPoint:CGPointMake(260, 170) toPoint:CGPointMake(360, 170)];
				break;
                
			default:
				break;
		}
	}
}

- (void)resetAnimation {
	
    [self moveFromPoint:CGPointMake(260, 170) toPoint:CGPointMake(360, 170)];
	stage = 0;
}

@end

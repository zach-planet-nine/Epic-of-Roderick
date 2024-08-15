//
//  BuyARoundMenuAnimation.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 8/11/11.
//  Copyright (c) 2011 InstantLazer. All rights reserved.
//

#import "BuyARoundMenuAnimation.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "Image.h"

@implementation BuyARoundMenuAnimation

- (void)dealloc {
	
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
        [self moveFromPoint:CGPointMake(290, 70) toPoint:CGPointMake(290, 270)];
		essenceColor = Color4fMake(0, 0, 1, 1);
		runeText = @"Dwarves are a giving people. With a simple gesture they can order a round for the whole party!";
		rune = [[Image alloc] initWithImageNamed:@"Rune37.png" filter:GL_LINEAR];
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	[super updateWithDelta:aDelta];
	if (duration < 0) {
		switch (stage) {
			case 0:
                stage = 1;
				[[GameController sharedGameController].currentScene removeDrawingImages];
				[self moveFromPoint:CGPointMake(290, 70) toPoint:CGPointMake(290, 270)];
				break;
            case 1:
                stage = 0;
				velocity = Vector2fMake(0, 0);
				duration = 2;
				break;
                
                
			default:
				break;
		}
	}
}

- (void)resetAnimation {
	
    [self moveFromPoint:CGPointMake(290, 70) toPoint:CGPointMake(290, 270)];
	stage = 0;
}

@end

//
//  SmeazMenuAnimation.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/10/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "SmeazMenuAnimation.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "Image.h"

@implementation SmeazMenuAnimation

- (void)dealloc {
	
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
        [self moveFromPoint:CGPointMake(320, 70) toPoint:CGPointMake(320, 270)];
		essenceColor = Color4fMake(0, 0, 1, 1);
		runeText = @"Smeaz is a special rune that utilizes the power of death. Your enemies will find their health drained by it. An ally may ward off death with it, and it will grant to your party the ability to drain health from your enemies for a time. ";
		rune = [[Image alloc] initWithImageNamed:@"Rune203.png" filter:GL_LINEAR];
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	[super updateWithDelta:aDelta];
	if (duration < 0) {
		switch (stage) {
			case 0:
				stage++;
				[self moveFromPoint:CGPointMake(370, 240) toPoint:CGPointMake(270, 100)];
				break;
			case 1:
				stage++;
                [self moveFromPoint:CGPointMake(270, 240) toPoint:CGPointMake(370, 100)];
				break;
			case 2:
				stage++;
				velocity = Vector2fMake(0, 0);
				duration = 2;
				break;
                
			case 3:
				[[GameController sharedGameController].currentScene removeDrawingImages];
				stage = 0;
                [self moveFromPoint:CGPointMake(270, 240) toPoint:CGPointMake(370, 100)];
				break;
                
			default:
				break;
		}
	}
}

- (void)resetAnimation {
	
    [self moveFromPoint:CGPointMake(270, 240) toPoint:CGPointMake(370, 100)];
	stage = 0;
}

@end

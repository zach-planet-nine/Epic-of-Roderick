//
//  GromanthMenuAnimation.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/22/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "GromanthMenuAnimation.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "Image.h"

@implementation GromanthMenuAnimation

- (void)dealloc {
	
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
		[self moveFromPoint:CGPointMake(310, 160) toPoint:CGPointMake(260, 90)];
		essenceColor = Color4fMake(0, 1, 0, 1);
		runeText = @"Eihwaz is a rune imbued with the power of vegetation. Using it on enemies calls the power of vines on them, while your allies gain some of the poisonous qualities of the vegatative world.";
		rune = [[Image alloc] initWithImageNamed:@"Rune179.png" filter:GL_LINEAR];
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	[super updateWithDelta:aDelta];
	if (duration < 0) {
		switch (stage) {
			case 0:
				stage++;
				[self moveFromPoint:CGPointMake(310, 160) toPoint:CGPointMake(360, 90)];
				break;
			case 1:
				stage++;
				[self moveFromPoint:CGPointMake(260, 160) toPoint:CGPointMake(360, 160)];
				break;
			case 2:
				stage++;
				velocity = Vector2fMake(0, 0);
				duration = 2;
				break;
				
			case 3:
				[[GameController sharedGameController].currentScene removeDrawingImages];
				stage = 0;
				[self moveFromPoint:CGPointMake(310, 160) toPoint:CGPointMake(260, 90)];
				break;
				
			default:
				break;
		}
	}
}

- (void)resetAnimation {
    [self moveFromPoint:CGPointMake(310, 160) toPoint:CGPointMake(260, 90)];
	stage = 0;
}

@end

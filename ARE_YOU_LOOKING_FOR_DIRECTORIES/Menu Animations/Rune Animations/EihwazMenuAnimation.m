//
//  EihwazMenuAnimation.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/5/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "EihwazMenuAnimation.h"
#import "GameController.h"
#import "AbstractScene.h"


@implementation EihwazMenuAnimation

- (void)dealloc {
	
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
		[self moveFromPoint:CGPointMake(280, 100) toPoint:CGPointMake(330, 60)];
		essenceColor = Color4fMake(0, 1, 0, 1);
		runeText = @"Eihwaz is a rune imbued with the power of vegetation. Using it on enemies calls the power of vines on them, while your allies gain some of the poisonous qualities of the vegatative world.";
		rune = [[Image alloc] initWithImageNamed:@"Rune201.png" filter:GL_LINEAR];
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	[super updateWithDelta:aDelta];
	if (duration < 0) {
		switch (stage) {
			case 0:
				stage++;
				[self moveFromPoint:CGPointMake(330, 250) toPoint:CGPointMake(330, 50)];
				break;
			case 1:
				stage++;
				[self moveFromPoint:CGPointMake(330, 250) toPoint:CGPointMake(380, 210)];
				break;
			case 2:
				stage++;
				velocity = Vector2fMake(0, 0);
				duration = 2;
				break;
				
			case 3:
				[[GameController sharedGameController].currentScene removeDrawingImages];
				stage = 0;
				[self moveFromPoint:CGPointMake(290, 100) toPoint:CGPointMake(330, 50)];
				break;
				
			default:
				break;
		}
	}
}

- (void)resetAnimation {
	[self moveFromPoint:CGPointMake(280, 100) toPoint:CGPointMake(330, 60)];
	stage = 0;
}

@end

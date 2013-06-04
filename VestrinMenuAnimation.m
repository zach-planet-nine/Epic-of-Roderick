//
//  VestrinMenuAnimation.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/23/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "VestrinMenuAnimation.h"
#import "GameController.h"
#import "Image.h"

@implementation VestrinMenuAnimation

- (void)dealloc {
	
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
		[self moveFromPoint:CGPointMake(260, 270) toPoint:CGPointMake(360, 270)];
		essenceColor = Color4fMake(0, 1, 0, 1);
		runeText = @"The Western Wind brings gale force winds that sweep up debris to harm your enemies. It also will grant a Sky based attack to an ally, or help defend against sky attacks.";
		rune = [[Image alloc] initWithImageNamed:@"Rune69.png" filter:GL_LINEAR];
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	[super updateWithDelta:aDelta];
	if (duration < 0) {
		switch (stage) {
			case 0:
				stage++;
				[self moveFromPoint:CGPointMake(260, 170) toPoint:CGPointMake(360, 170)];
				break;
			case 1:
				stage++;
				[self moveFromPoint:CGPointMake(260, 70) toPoint:CGPointMake(360, 70)];
				break;
			case 2:
				stage++;
				velocity = Vector2fMake(0, 0);
				duration = 2;
				break;
				
			case 3:
				[[GameController sharedGameController].currentScene removeDrawingImages];
				stage = 0;
				[self moveFromPoint:CGPointMake(260, 270) toPoint:CGPointMake(260, 270)];
				break;
				
			default:
				break;
		}
	}
}

- (void)resetAnimation {
    [self moveFromPoint:CGPointMake(260, 270) toPoint:CGPointMake(260, 270)];
	stage = 0;
}


@end

//
//  AkathMenuAnimation.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/27/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "AkathMenuAnimation.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "Image.h"

@implementation AkathMenuAnimation

- (void)dealloc {
	
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
		[self moveFromPoint:CGPointMake(310, 270) toPoint:CGPointMake(310, 70)];
		essenceColor = Color4fMake(0, 1, 0, 1);
		runeText = @"Akath will shield against powers of life or will cure an ally who is disoriented. When used on enemies it will make any unfortunate ailments they have last longer.";
		rune = [[Image alloc] initWithImageNamed:@"Rune217.png" filter:GL_LINEAR];
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	[super updateWithDelta:aDelta];
	if (duration < 0) {
		switch (stage) {
			case 0:
				stage++;
				[self moveFromPoint:CGPointMake(310, 270) toPoint:CGPointMake(280, 240)];
				break;
			case 1:
				stage++;
				[self moveFromPoint:CGPointMake(340, 100) toPoint:CGPointMake(310, 70)];
				break;
			case 2:
				stage++;
				velocity = Vector2fMake(0, 0);
				duration = 2;
				break;
				
			case 3:
				[[GameController sharedGameController].currentScene removeDrawingImages];
				stage = 0;
                [self moveFromPoint:CGPointMake(310, 270) toPoint:CGPointMake(310, 70)];
				break;
				
			default:
				break;
		}
	}
}

- (void)resetAnimation {
    [self moveFromPoint:CGPointMake(310, 270) toPoint:CGPointMake(310, 70)];
	stage = 0;
}

@end

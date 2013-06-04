//
//  TiwazMenuAnimation.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/28/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "TiwazMenuAnimation.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "Image.h"

@implementation TiwazMenuAnimation

- (void)dealloc {
	
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
		[self moveFromPoint:CGPointMake(290, 70) toPoint:CGPointMake(290, 270)];
		essenceColor = Color4fMake(0, 0, 1, 1);
		runeText = @"Tiwaz calls down meteors to damage your enemies. When used on your allies, it draws upon the power of meteors to prevent endurance from depleting.";
		rune = [[Image alloc] initWithImageNamed:@"Rune157.png" filter:GL_LINEAR];
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	[super updateWithDelta:aDelta];
	if (duration < 0) {
		switch (stage) {
			case 0:
				stage++;
				[self moveFromPoint:CGPointMake(250, 230) toPoint:CGPointMake(290, 270)];
				break;
			case 1:
				stage++;
				[self moveFromPoint:CGPointMake(330, 230) toPoint:CGPointMake(290, 270)];
				break;
			case 2:
				stage++;
				velocity = Vector2fMake(0, 0);
				duration = 2;
				break;
                
			case 3:
				[[GameController sharedGameController].currentScene removeDrawingImages];
				stage = 0;
                [self moveFromPoint:CGPointMake(290, 70) toPoint:CGPointMake(290, 270)];
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

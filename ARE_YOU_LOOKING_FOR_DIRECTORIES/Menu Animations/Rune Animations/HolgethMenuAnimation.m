//
//  HolgethMenuAnimation.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/27/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "HolgethMenuAnimation.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "Image.h"

@implementation HolgethMenuAnimation

- (void)dealloc {
	
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
		[self moveFromPoint:CGPointMake(290, 250) toPoint:CGPointMake(360, 180)];
		essenceColor = Color4fMake(0, 0, 1, 1);
		runeText = @"Holgeth calls upon rage to add bleeders to your enemies. It will heal bleeders that an ally of yours has, while when used on your party it will protect them from rage-filled attacks.";
		rune = [[Image alloc] initWithImageNamed:@"Rune286.png" filter:GL_LINEAR];
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	[super updateWithDelta:aDelta];
	if (duration < 0) {
		switch (stage) {
			case 0:
				stage++;
				[self moveFromPoint:CGPointMake(360, 180) toPoint:CGPointMake(290, 110)];
				break;
			case 1:
				stage++;
				[self moveFromPoint:CGPointMake(360, 110) toPoint:CGPointMake(290, 170)];
				break;
            case 2:
                stage++;
                [self moveFromPoint:CGPointMake(290, 170) toPoint:CGPointMake(260, 250)];
                break;
			case 3:
				stage++;
				velocity = Vector2fMake(0, 0);
				duration = 2;
				break;
                
                
			case 4:
				[[GameController sharedGameController].currentScene removeDrawingImages];
				stage = 0;
                [self moveFromPoint:CGPointMake(290, 250) toPoint:CGPointMake(360, 180)];
				break;
                
			default:
				break;
		}
	}
}

- (void)resetAnimation {
	
    [self moveFromPoint:CGPointMake(290, 250) toPoint:CGPointMake(360, 180)];
	stage = 0;
}

@end

//
//  DwarfapultMenuAnimation.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 8/11/11.
//  Copyright (c) 2011 InstantLazer. All rights reserved.
//

#import "DwarfapultMenuAnimation.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "Image.h"

@implementation DwarfapultMenuAnimation 

- (void)dealloc {
	
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
		[self moveFromPoint:CGPointMake(260, 270) toPoint:CGPointMake(260, 70)];
		essenceColor = Color4fMake(0, 0, 1, 1);
		runeText = @"I've heard that the dwarven drink Holvale will increase the drinker's ingenuity.";
		rune = [[Image alloc] initWithImageNamed:@"Rune93.png" filter:GL_LINEAR];
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	[super updateWithDelta:aDelta];
	if (duration < 0) {
		switch (stage) {
			case 0:
				stage++;
				[self moveFromPoint:CGPointMake(260, 70) toPoint:CGPointMake(360, 70)];
				break;
			case 1:
				stage++;
				[self moveFromPoint:CGPointMake(360, 70) toPoint:CGPointMake(260, 270)];
				break;
			case 2:
				stage++;
				velocity = Vector2fMake(0, 0);
				duration = 2;
				break;
                
			case 3:
				[[GameController sharedGameController].currentScene removeDrawingImages];
				stage = 0;
                [self moveFromPoint:CGPointMake(260, 270) toPoint:CGPointMake(260, 70)];
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

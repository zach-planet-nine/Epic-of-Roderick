//
//  SuperAxerangMenuAnimation.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 8/14/11.
//  Copyright (c) 2011 InstantLazer. All rights reserved.
//

#import "SuperAxerangMenuAnimation.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "Image.h"

@implementation SuperAxerangMenuAnimation

- (void)dealloc {
	
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
		[self moveFromPoint:CGPointMake(270, 270) toPoint:CGPointMake(370, 70)];
		essenceColor = Color4fMake(0, 0, 1, 1);
		runeText = @"The Rangers of the realms are keen hunters. They've made a drink that will fortify the senses and allow for super human hunting strikes.";
		rune = [[Image alloc] initWithImageNamed:@"Rune132.png" filter:GL_LINEAR];
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	[super updateWithDelta:aDelta];
	if (duration < 0) {
		switch (stage) {
            case 0:
                stage++;
                [self moveFromPoint:CGPointMake(270, 70) toPoint:CGPointMake(370, 270)];
                break;
            case 1:
                stage++;
                velocity = Vector2fMake(0, 0);
                duration = 2;
                break;
            case 2:
                stage = 0;
				[[GameController sharedGameController].currentScene removeDrawingImages];
                [self moveFromPoint:CGPointMake(270, 270) toPoint:CGPointMake(370, 70)];
				break;
                
			default:
				break;
		}
	}
}

- (void)resetAnimation {
	
    [self moveFromPoint:CGPointMake(270, 270) toPoint:CGPointMake(370, 70)];
	stage = 0;
}

@end

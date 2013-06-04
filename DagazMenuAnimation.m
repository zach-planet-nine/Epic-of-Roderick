//
//  DagazMenuAnimation.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/9/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "DagazMenuAnimation.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "Image.h"

@implementation DagazMenuAnimation

- (void)dealloc {
	
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
		[self moveFromPoint:CGPointMake(270, 270) toPoint:CGPointMake(270, 70)];
		essenceColor = Color4fMake(0, 0, 1, 1);
		runeText = @"Dagaz is a rune that will affect the essence of what it is used on. Your enemies may be hexed by Dagaz, whereas your allies may be auraed.";
		rune = [[Image alloc] initWithImageNamed:@"Rune218.png" filter:GL_LINEAR];
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	[super updateWithDelta:aDelta];
	if (duration < 0) {
		switch (stage) {
			case 0:
				stage++;
				[self moveFromPoint:CGPointMake(360, 270) toPoint:CGPointMake(360, 70)];
				break;
			case 1:
				stage++;
				[self moveFromPoint:CGPointMake(270, 270) toPoint:CGPointMake(360, 70)];
				break;
            case 2:
                stage++;
                [self moveFromPoint:CGPointMake(270, 70) toPoint:CGPointMake(360, 270)];
                break;
			case 3:
				stage++;
				velocity = Vector2fMake(0, 0);
				duration = 2;
				break;
                
                
			case 4:
				[[GameController sharedGameController].currentScene removeDrawingImages];
				stage = 0;
                [self moveFromPoint:CGPointMake(270, 270) toPoint:CGPointMake(270, 70)];
				break;
                
			default:
				break;
		}
	}
}

- (void)resetAnimation {
	
    [self moveFromPoint:CGPointMake(270, 270) toPoint:CGPointMake(270, 70)];
	stage = 0;
}

@end

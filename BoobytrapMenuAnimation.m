//
//  BoobytrapMenuAnimation.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 8/11/11.
//  Copyright (c) 2011 InstantLazer. All rights reserved.
//

#import "BoobytrapMenuAnimation.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "Image.h"

@implementation BoobytrapMenuAnimation

- (void)dealloc {
	
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
		[self moveFromPoint:CGPointMake(260, 220) toPoint:CGPointMake(310, 120)];
		essenceColor = Color4fMake(0, 0, 1, 1);
		runeText = @"Ordering the Valkyrie's preferred drink of Valkahol calls upon the vengeful nature of the Valkyries.";
		rune = [[Image alloc] initWithImageNamed:@"Rune166.png" filter:GL_LINEAR];
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	[super updateWithDelta:aDelta];
	if (duration < 0) {
		switch (stage) {
            case 0:
                stage++;
                [self moveFromPoint:CGPointMake(360, 220) toPoint:CGPointMake(310, 120)];
                break;
            case 1:
                stage++;
                velocity = Vector2fMake(0, 0);
                duration = 2;
                break;
            case 2:
                stage = 0;
				[[GameController sharedGameController].currentScene removeDrawingImages];
                [self moveFromPoint:CGPointMake(260, 220) toPoint:CGPointMake(310, 120)];
				break;
                
			default:
				break;
		}
	}
}

- (void)resetAnimation {
	
    [self moveFromPoint:CGPointMake(260, 220) toPoint:CGPointMake(310, 120)];
	stage = 0;
}

@end

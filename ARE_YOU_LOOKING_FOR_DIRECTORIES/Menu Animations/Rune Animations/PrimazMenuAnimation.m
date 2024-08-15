//
//  PrimazMenuAnimation.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/27/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "PrimazMenuAnimation.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "Image.h"

@implementation PrimazMenuAnimation

- (void)dealloc {
	
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
		[self moveFromPoint:CGPointMake(310, 270) toPoint:CGPointMake(310, 70)];
		essenceColor = Color4fMake(0, 0, 1, 1);
		runeText = @"Primaz draws power from the primal force of rage. It will turn an enemy's rage against itself or lower the rage your enemies feel. Used on a single ally, it adds a rage attack. When used on all characters, your allies help fill the Valkyrie's rage meter.";
		rune = [[Image alloc] initWithImageNamed:@"Rune56.png" filter:GL_LINEAR];
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	[super updateWithDelta:aDelta];
	if (duration < 0) {
		switch (stage) {
            case 0:
                stage++;
                [self moveFromPoint:CGPointMake(270, 180) toPoint:CGPointMake(350, 180)];
                break;
            case 1:
                stage++;
                velocity = Vector2fMake(0, 0);
                duration = 2;
                break;
            case 2:
                stage = 0;
				[[GameController sharedGameController].currentScene removeDrawingImages];
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

//
//  LaguzMenuAnimation.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/7/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "LaguzMenuAnimation.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "Image.h"

@implementation LaguzMenuAnimation

- (void)dealloc {
	
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
		[self moveFromPoint:CGPointMake(310, 70) toPoint:CGPointMake(310, 270)];
		essenceColor = Color4fMake(0, 0, 1, 1);
		runeText = @"Laguz calls upon the forces of the natural world to damage an enemy's endurance. Used on all enemies, it will hurt them and weaken their resistance to poison. Used on your allies it will bring a healing rain to them.";
		rune = [[Image alloc] initWithImageNamed:@"Rune104.png" filter:GL_LINEAR];
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	[super updateWithDelta:aDelta];
	if (duration < 0) {
		switch (stage) {
            case 0:
                stage++;
                [self moveFromPoint:CGPointMake(350, 220) toPoint:CGPointMake(310, 270)];
                break;
            case 1:
                stage++;
                velocity = Vector2fMake(0, 0);
                duration = 2;
                break;
            case 2:
                stage = 0;
				[[GameController sharedGameController].currentScene removeDrawingImages];
                [self moveFromPoint:CGPointMake(310, 70) toPoint:CGPointMake(310, 270)];
				break;
                
			default:
				break;
		}
	}
}

- (void)resetAnimation {
	
    [self moveFromPoint:CGPointMake(310, 70) toPoint:CGPointMake(310, 270)];
	stage = 0;
}


@end

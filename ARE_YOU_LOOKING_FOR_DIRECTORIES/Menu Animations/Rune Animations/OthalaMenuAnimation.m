//
//  OthalaMenuAnimation.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/22/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "OthalaMenuAnimation.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "Image.h"

@implementation OthalaMenuAnimation

- (void)dealloc {
	
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
		[self moveFromPoint:CGPointMake(310, 270) toPoint:CGPointMake(260, 220)];
		essenceColor = Color4fMake(0, 0, 1, 1);
		runeText = @"Othala is a rune that recalls the past. It does a special type of damage to enemies and will help unlock your characters' potential. When used on all characters, it will help out your Elementals.";
		rune = [[Image alloc] initWithImageNamed:@"Rune332.png" filter:GL_LINEAR];
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	[super updateWithDelta:aDelta];
	if (duration < 0) {
		switch (stage) {
			case 0:
				stage++;
				[self moveFromPoint:CGPointMake(260, 220) toPoint:CGPointMake(360, 70)];
				break;
			case 1:
				stage++;
				[self moveFromPoint:CGPointMake(310, 270) toPoint:CGPointMake(360, 220)];
				break;
            case 2:
                stage++;
                [self moveFromPoint:CGPointMake(360, 220) toPoint:CGPointMake(260, 70)];
                break;
			case 3:
				stage++;
				velocity = Vector2fMake(0, 0);
				duration = 2;
				break;
            
                
			case 4:
				[[GameController sharedGameController].currentScene removeDrawingImages];
				stage = 0;
				[self moveFromPoint:CGPointMake(290, 270) toPoint:CGPointMake(290, 70)];
				break;
                
			default:
				break;
		}
	}
}

- (void)resetAnimation {
	
    [self moveFromPoint:CGPointMake(310, 270) toPoint:CGPointMake(260, 220)];
	stage = 0;
}


@end

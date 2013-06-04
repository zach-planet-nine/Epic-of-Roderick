//
//  FyrazMenuAnimation.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/29/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "FyrazMenuAnimation.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "Image.h"

@implementation FyrazMenuAnimation

- (void)dealloc {
	
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
		[self moveFromPoint:CGPointMake(260, 120) toPoint:CGPointMake(310, 70)];
		essenceColor = Color4fMake(0, 0, 1, 1);
		runeText = @"Fyraz is a fire flinger's best friend. Dealing huge damage to your enemies, is just half of the deal. Used on an ally, it will heal them of all status effects. Meanwhile used on your party, it will take the wizard's essence and refill your companions'.";
		rune = [[Image alloc] initWithImageNamed:@"Rune169.png" filter:GL_LINEAR];
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	[super updateWithDelta:aDelta];
	if (duration < 0) {
		switch (stage) {
			case 0:
				stage++;
				[self moveFromPoint:CGPointMake(310, 70) toPoint:CGPointMake(310, 270)];
				break;
			case 1:
				stage++;
				[self moveFromPoint:CGPointMake(310, 70) toPoint:CGPointMake(360, 120)];
				break;
			case 2:
				stage++;
				velocity = Vector2fMake(0, 0);
				duration = 2;
				break;
                
			case 3:
				[[GameController sharedGameController].currentScene removeDrawingImages];
				stage = 0;
                [self moveFromPoint:CGPointMake(260, 120) toPoint:CGPointMake(310, 70)];
				break;
                
			default:
				break;
		}
	}
}

- (void)resetAnimation {
	
    [self moveFromPoint:CGPointMake(260, 120) toPoint:CGPointMake(310, 70)];
	stage = 0;
}


@end

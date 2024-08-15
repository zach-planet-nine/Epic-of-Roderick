//
//  AlgizMenuAnimation.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/7/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "AlgizMenuAnimation.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "Image.h"

@implementation AlgizMenuAnimation

- (void)dealloc {
	
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
		[self moveFromPoint:CGPointMake(260, 270) toPoint:CGPointMake(310, 230)];
		essenceColor = Color4fMake(0, 1, 0, 1);
		runeText = @"Algiz calls upon the power of the squirrel. It will make your enemies' essence refill slower and will cure an ally who has fatigued or drauraed. Used on the party, it will summon the squirrel.";
		rune = [[Image alloc] initWithImageNamed:@"Rune209.png" filter:GL_LINEAR];
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	[super updateWithDelta:aDelta];
	if (duration < 0) {
		switch (stage) {
			case 0:
				stage++;
				[self moveFromPoint:CGPointMake(360, 270) toPoint:CGPointMake(210, 230)];
				break;
			case 1:
				stage++;
				[self moveFromPoint:CGPointMake(310, 270) toPoint:CGPointMake(310, 70)];
				break;
			case 2:
				stage++;
				velocity = Vector2fMake(0, 0);
				duration = 2;
				break;
				
			case 3:
				[[GameController sharedGameController].currentScene removeDrawingImages];
				stage = 0;
                [self moveFromPoint:CGPointMake(260, 270) toPoint:CGPointMake(310, 230)];
				break;
				
			default:
				break;
		}
	}
}

- (void)resetAnimation {
    [self moveFromPoint:CGPointMake(260, 270) toPoint:CGPointMake(310, 230)];
	stage = 0;
}


@end

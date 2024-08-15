//
//  BombulusMenuAnimation.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 8/14/11.
//  Copyright (c) 2011 InstantLazer. All rights reserved.
//

#import "BombulusMenuAnimation.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "Image.h"

@implementation BombulusMenuAnimation

- (void)dealloc {
	
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
		[self moveFromPoint:CGPointMake(260, 120) toPoint:CGPointMake(360, 120)];
		essenceColor = Color4fMake(0, 0, 1, 1);
		runeText = @"Ordering up a drink of impish grog will lead to some impish ingenuity. Impgenuity! if you will..";
		rune = [[Image alloc] initWithImageNamed:@"Rune50.png" filter:GL_LINEAR];
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	[super updateWithDelta:aDelta];
	if (duration < 0) {
		switch (stage) {
            case 0:
                stage++;
                [self moveFromPoint:CGPointMake(310, 120) toPoint:CGPointMake(310, 220)];
                break;
            case 1:
                stage++;
                velocity = Vector2fMake(0, 0);
                duration = 2;
                break;
            case 2:
                stage = 0;
				[[GameController sharedGameController].currentScene removeDrawingImages];
                [self moveFromPoint:CGPointMake(260, 120) toPoint:CGPointMake(360, 120)];
				break;
                
			default:
				break;
		}
	}
}

- (void)resetAnimation {
	
    [self moveFromPoint:CGPointMake(260, 120) toPoint:CGPointMake(360, 120)];
	stage = 0;
}


@end

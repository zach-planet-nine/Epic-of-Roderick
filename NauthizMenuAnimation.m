//
//  NauthizMenuAnimation.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/25/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "NauthizMenuAnimation.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "Image.h"

@implementation NauthizMenuAnimation

- (void)dealloc {
	
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
		[self moveFromPoint:CGPointMake(310, 70) toPoint:CGPointMake(310, 270)];
		essenceColor = Color4fMake(0, 0, 1, 1);
		runeText = @"Nauthiz calls upon the need of the fallen to come back to life. It can attack the essence of your enemies or improve the healing of your allies. When used on a single character, they will imbue their attacks with life.";
		rune = [[Image alloc] initWithImageNamed:@"Rune116.png" filter:GL_LINEAR];
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	[super updateWithDelta:aDelta];
	if (duration < 0) {
		switch (stage) {
            case 0:
                stage++;
                [self moveFromPoint:CGPointMake(270, 250) toPoint:CGPointMake(350, 150)];
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

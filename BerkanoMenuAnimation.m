//
//  BerkanoMenuAnimation.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/25/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "BerkanoMenuAnimation.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "Image.h"

@implementation BerkanoMenuAnimation

- (void)dealloc {
	
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
		[self moveFromPoint:CGPointMake(260, 270) toPoint:CGPointMake(260, 70)];
		essenceColor = Color4fMake(0, 0, 1, 1);
		runeText = @"Berkano allows you to call upon the Birch Goddess of the same name to foil your enemies' plans. If used on an ally, Berkano will bring your companion back to life. Used on your party may even ward of death for a bit.";
		rune = [[Image alloc] initWithImageNamed:@"Rune375.png" filter:GL_LINEAR];
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	[super updateWithDelta:aDelta];
	if (duration < 0) {
		switch (stage) {
			case 0:
				stage++;
				[self moveFromPoint:CGPointMake(260, 270) toPoint:CGPointMake(310, 220)];
				break;
			case 1:
				stage++;
				[self moveFromPoint:CGPointMake(310, 220) toPoint:CGPointMake(260, 170)];
				break;
            case 2:
                stage++;
                [self moveFromPoint:CGPointMake(260, 170) toPoint:CGPointMake(310, 120)];
                break;
            case 3:
                stage++;
                [self moveFromPoint:CGPointMake(310, 120) toPoint:CGPointMake(260, 70)];
			case 4:
				stage++;
				velocity = Vector2fMake(0, 0);
				duration = 2;
				break;
                
                
			case 5:
				[[GameController sharedGameController].currentScene removeDrawingImages];
				stage = 0;
                [self moveFromPoint:CGPointMake(260, 270) toPoint:CGPointMake(260, 70)];
				break;
                
			default:
				break;
		}
	}
}

- (void)resetAnimation {
	
    [self moveFromPoint:CGPointMake(260, 270) toPoint:CGPointMake(260, 70)];
	stage = 0;
}

@end

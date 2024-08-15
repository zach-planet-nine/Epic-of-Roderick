//
//  JeraMenuAnimation.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/24/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "JeraMenuAnimation.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "Image.h"

@implementation JeraMenuAnimation

- (void)dealloc {
	
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
		[self moveFromPoint:CGPointMake(310, 250) toPoint:CGPointMake(360, 200)];
		essenceColor = Color4fMake(0, 1, 0, 1);
		runeText = @"Jera is a rune of vengeance. Use it to exact revenge on your enemies. When used on your allies, it has the ability to have them be more experienced than they would be otherwise.";
		rune = [[Image alloc] initWithImageNamed:@"Rune245.png" filter:GL_LINEAR];
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	[super updateWithDelta:aDelta];
	if (duration < 0) {
		switch (stage) {
			case 0:
				stage++;
				[self moveFromPoint:CGPointMake(325, 250) toPoint:CGPointMake(375, 200)];
				break;
			case 1:
				stage++;
				[self moveFromPoint:CGPointMake(375, 200) toPoint:CGPointMake(325, 150)];
				break;
			case 2:
				stage++;
				velocity = Vector2fMake(0, 0);
				duration = 2;
				break;
				
			case 3:
				[[GameController sharedGameController].currentScene removeDrawingImages];
				stage = 0;
                [self moveFromPoint:CGPointMake(310, 250) toPoint:CGPointMake(360, 200)];
				break;
				
			default:
				break;
		}
	}
}

- (void)resetAnimation {
    [self moveFromPoint:CGPointMake(310, 250) toPoint:CGPointMake(360, 200)];
	stage = 0;
}

@end

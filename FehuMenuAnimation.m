//
//  FehuMenuAnimation.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/6/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "FehuMenuAnimation.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "Image.h"

@implementation FehuMenuAnimation

- (void)dealloc {
	
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
		[self moveFromPoint:CGPointMake(290, 270) toPoint:CGPointMake(290, 70)];
		essenceColor = Color4fMake(0, 0, 1, 1);
		runeText = @"Fehu is a rune that celebrates life. Using it on an enemy will encase them in a fast growing bush for a time. All enemies will suffer a loss of their will to live. A character will feel that they have a lucky life and used on the party will summon the Ranger's dog.";
		rune = [[Image alloc] initWithImageNamed:@"Rune149.png" filter:GL_LINEAR];
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	[super updateWithDelta:aDelta];
	if (duration < 0) {
		switch (stage) {
			case 0:
				stage++;
				[self moveFromPoint:CGPointMake(290, 190) toPoint:CGPointMake(340, 240)];
				break;
			case 1:
				stage++;
				[self moveFromPoint:CGPointMake(290, 220) toPoint:CGPointMake(360, 270)];
				break;
			case 2:
				stage++;
				velocity = Vector2fMake(0, 0);
				duration = 2;
				break;
                
			case 3:
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
	
    [self moveFromPoint:CGPointMake(290, 270) toPoint:CGPointMake(290, 70)];
	stage = 0;
}

@end

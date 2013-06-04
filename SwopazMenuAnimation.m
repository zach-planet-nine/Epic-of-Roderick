//
//  SwopazMenuAnimation.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/7/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "SwopazMenuAnimation.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "Image.h"

@implementation SwopazMenuAnimation

- (void)dealloc {
	
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
		[self moveFromPoint:CGPointMake(290, 270) toPoint:CGPointMake(360, 70)];
		essenceColor = Color4fMake(0, 0, 1, 1);
		runeText = @"Swopaz asks the powers of the forest to come to your aid. It will make sure your enemies hear a fallen tree. Meanwhile it will make it so that an ally's attacks cause bleeders. Used on the party, it summons the hawk.";
		rune = [[Image alloc] initWithImageNamed:@"Rune135.png" filter:GL_LINEAR];
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	[super updateWithDelta:aDelta];
	if (duration < 0) {
		switch (stage) {
			case 0:
				stage++;
				[self moveFromPoint:CGPointMake(370, 160) toPoint:CGPointMake(370, 70)];
				break;
			case 1:
				stage++;
				[self moveFromPoint:CGPointMake(280, 60) toPoint:CGPointMake(370, 60)];
				break;
			case 2:
				stage++;
				velocity = Vector2fMake(0, 0);
				duration = 2;
				break;
                
			case 3:
				[[GameController sharedGameController].currentScene removeDrawingImages];
				stage = 0;
                [self moveFromPoint:CGPointMake(290, 270) toPoint:CGPointMake(360, 70)];
				break;
                
			default:
				break;
		}
	}
}

- (void)resetAnimation {
	
    [self moveFromPoint:CGPointMake(290, 270) toPoint:CGPointMake(360, 70)];
	stage = 0;
}

@end

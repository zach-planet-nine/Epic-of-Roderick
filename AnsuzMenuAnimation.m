//
//  AnsuzMenuAnimation.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/4/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "AnsuzMenuAnimation.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "Global.h"
#import "Image.h"


@implementation AnsuzMenuAnimation

- (void)dealloc {
	
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
		[self moveFromPoint:CGPointMake(290, 270) toPoint:CGPointMake(290, 70)];
		essenceColor = Color4fMake(0, 0, 1, 1);
		runeText = @"Ansuz is a rune of command. Using it on enemies, Roderick leads the charge against them. While your allies will feel encouraged by it.";
		rune = [[Image alloc] initWithImageNamed:@"Rune201.png" filter:GL_LINEAR];
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	[super updateWithDelta:aDelta];
	if (duration < 0) {
		switch (stage) {
			case 0:
				stage++;
				[self moveFromPoint:CGPointMake(290, 270) toPoint:CGPointMake(360, 220)];
				break;
			case 1:
				stage++;
				[self moveFromPoint:CGPointMake(290, 200) toPoint:CGPointMake(360, 150)];
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

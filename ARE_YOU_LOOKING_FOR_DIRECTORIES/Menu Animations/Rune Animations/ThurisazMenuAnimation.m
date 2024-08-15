//
//  ThurisazMenuAnimation.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/6/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "ThurisazMenuAnimation.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "Image.h"

@implementation ThurisazMenuAnimation

- (void)dealloc {
	
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
		[self moveFromPoint:CGPointMake(290, 270) toPoint:CGPointMake(290, 70)];
		essenceColor = Color4fMake(0, 0, 1, 1);
		runeText = @"Thurisaz is known as the thorn for a reason. It will call a shower of thorns on your enemies while granting your allies the ability to attack with the power of wood, or defend against wooden powers.";
		rune = [[Image alloc] initWithImageNamed:@"Rune175.png" filter:GL_LINEAR];
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	[super updateWithDelta:aDelta];
	if (duration < 0) {
		switch (stage) {
			case 0:
				stage++;
				[self moveFromPoint:CGPointMake(290, 220) toPoint:CGPointMake(360, 170)];
				break;
			case 1:
				stage++;
				[self moveFromPoint:CGPointMake(290, 120) toPoint:CGPointMake(360, 170)];
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

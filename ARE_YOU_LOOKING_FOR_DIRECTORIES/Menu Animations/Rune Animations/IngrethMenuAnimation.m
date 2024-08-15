//
//  IngrethMenuAnimation.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/10/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "IngrethMenuAnimation.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "Image.h"

@implementation IngrethMenuAnimation

- (void)dealloc {
	
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
		[self moveFromPoint:CGPointMake(270, 170) toPoint:CGPointMake(370, 270)];
		essenceColor = Color4fMake(0, 0, 1, 1);
		runeText = @"Ingreth is a rune that calls upon the power of the gods. The more your favor with the gods, the more damage Ingreth will do to your enemies. Meanwhile it will remove a hex from a character, and when used on your party it will beseech the gods.";
		rune = [[Image alloc] initWithImageNamed:@"Rune286.png" filter:GL_LINEAR];
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	[super updateWithDelta:aDelta];
	if (duration < 0) {
		switch (stage) {
			case 0:
				stage++;
				[self moveFromPoint:CGPointMake(370, 170) toPoint:CGPointMake(270, 270)];
				break;
			case 1:
				stage++;
				[self moveFromPoint:CGPointMake(270, 170) toPoint:CGPointMake(320, 120)];
				break;
            case 2:
                stage++;
                [self moveFromPoint:CGPointMake(370, 170) toPoint:CGPointMake(320, 120)];
                break;
			case 3:
				stage++;
				velocity = Vector2fMake(0, 0);
				duration = 2;
				break;
                
                
			case 4:
				[[GameController sharedGameController].currentScene removeDrawingImages];
				stage = 0;
                [self moveFromPoint:CGPointMake(270, 270) toPoint:CGPointMake(370, 170)];
				break;
                
			default:
				break;
		}
	}
}

- (void)resetAnimation {
	
    [self moveFromPoint:CGPointMake(270, 270) toPoint:CGPointMake(370, 170)];
	stage = 0;
}

@end

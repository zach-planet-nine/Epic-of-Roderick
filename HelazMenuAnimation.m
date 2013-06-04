//
//  HelazMenuAnimation.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/10/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "HelazMenuAnimation.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "Image.h"

@implementation HelazMenuAnimation

- (void)dealloc {
	
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
		[self moveFromPoint:CGPointMake(270, 250) toPoint:CGPointMake(270, 70)];
		essenceColor = Color4fMake(0, 0, 1, 1);
		runeText = @"Drawing upon the power of the underworld, Helaz asks Garm to come to your aid in dispatching your enemies. Used on an ally it will imbue their attacks with divine power. At the same time it will defend against divine attacks.";
		rune = [[Image alloc] initWithImageNamed:@"Rune144.png" filter:GL_LINEAR];
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	[super updateWithDelta:aDelta];
	if (duration < 0) {
		switch (stage) {
			case 0:
				stage++;
				[self moveFromPoint:CGPointMake(320, 250) toPoint:CGPointMake(320, 70)];
				break;
			case 1:
				stage++;
				[self moveFromPoint:CGPointMake(370, 250) toPoint:CGPointMake(320, 70)];
				break;
            case 2:
                stage++;
                [self moveFromPoint:CGPointMake(270, 260) toPoint:CGPointMake(370, 260)];
                break;
			case 3:
				stage++;
				velocity = Vector2fMake(0, 0);
				duration = 2;
				break;
                
                
			case 4:
				[[GameController sharedGameController].currentScene removeDrawingImages];
				stage = 0;
                [self moveFromPoint:CGPointMake(270, 250) toPoint:CGPointMake(270, 70)];
				break;
                
			default:
				break;
		}
	}
}

- (void)resetAnimation {
	
    [self moveFromPoint:CGPointMake(270, 250) toPoint:CGPointMake(270, 70)];
	stage = 0;
}

@end

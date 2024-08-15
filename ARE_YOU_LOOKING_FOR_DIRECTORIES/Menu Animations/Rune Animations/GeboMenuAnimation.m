//
//  GeboMenuAnimation.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/8/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "GeboMenuAnimation.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "Image.h"

@implementation GeboMenuAnimation

- (void)dealloc {
	
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
		[self moveFromPoint:CGPointMake(270, 270) toPoint:CGPointMake(370, 70)];
		essenceColor = Color4fMake(0, 0, 1, 1);
		runeText = @"Gebo will let you trade some health for essence with an enemy. Used on all enemies it gives them a present. Used on a character will unlock a hidden potential, but can be used only once per battle. Used on your party it will speed up the timers on your items.";
		rune = [[Image alloc] initWithImageNamed:@"Rune166.png" filter:GL_LINEAR];
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	[super updateWithDelta:aDelta];
	if (duration < 0) {
		switch (stage) {
            case 0:
                stage++;
                [self moveFromPoint:CGPointMake(370, 270) toPoint:CGPointMake(270, 70)];
                break;
            case 1:
                stage++;
                velocity = Vector2fMake(0, 0);
                duration = 2;
                break;
            case 2:
                stage = 0;
				[[GameController sharedGameController].currentScene removeDrawingImages];
                [self moveFromPoint:CGPointMake(270, 270) toPoint:CGPointMake(370, 70)];
				break;
                
			default:
				break;
		}
	}
}

- (void)resetAnimation {
	
    [self moveFromPoint:CGPointMake(270, 270) toPoint:CGPointMake(370, 70)];
	stage = 0;
}


@end

//
//  WunjoMenuAnimation.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 8/14/11.
//  Copyright (c) 2011 InstantLazer. All rights reserved.
//

#import "WunjoMenuAnimation.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "Image.h"

@implementation WunjoMenuAnimation

- (void)dealloc {
	
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
		[self moveFromPoint:CGPointMake(350, 270) toPoint:CGPointMake(350, 70)];
		essenceColor = Color4fMake(0, 0, 1, 1);
		runeText = @"Wunjo calls upon the spirits of your fallen opponents. Used on your enemies it will call forth those spirits to attack. Used on a single character it will provide a shield against physical attacks. If used on your party it will raise their resistance to death attacks.";
		rune = [[Image alloc] initWithImageNamed:@"Rune210.png" filter:GL_LINEAR];
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	[super updateWithDelta:aDelta];
	if (duration < 0) {
		switch (stage) {
			case 0:
				stage++;
				[self moveFromPoint:CGPointMake(350, 270) toPoint:CGPointMake(300, 220)];
				break;
			case 1:
				stage++;
				[self moveFromPoint:CGPointMake(300, 220) toPoint:CGPointMake(350, 170)];
				break;
			case 2:
				stage++;
				velocity = Vector2fMake(0, 0);
				duration = 2;
				break;
                
			case 3:
				[[GameController sharedGameController].currentScene removeDrawingImages];
				stage = 0;
                [self moveFromPoint:CGPointMake(350, 270) toPoint:CGPointMake(350, 70)];
				break;
                
			default:
				break;
		}
	}
}

- (void)resetAnimation {
	
    [self moveFromPoint:CGPointMake(350, 270) toPoint:CGPointMake(350, 70)];
	stage = 0;
}


@end

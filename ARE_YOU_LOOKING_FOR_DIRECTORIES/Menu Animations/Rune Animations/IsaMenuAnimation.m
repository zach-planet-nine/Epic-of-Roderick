//
//  IsaMenuAnimation.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/19/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "IsaMenuAnimation.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "Image.h"

@implementation IsaMenuAnimation

- (void)dealloc {
	
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
		[self moveFromPoint:CGPointMake(290, 70) toPoint:CGPointMake(360, 270)];
		essenceColor = Color4fMake(0, 0, 1, 1);
		runeText = @"Isa is a rune imbued with the power of ice. Using it on enemies will hurl shards of ice at them, while using it on your allies will grant them water attacks or protection from water-based attacks.";
		rune = [[Image alloc] initWithImageNamed:@"Rune53.png" filter:GL_LINEAR];
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	[super updateWithDelta:aDelta];
	if (duration < 0) {
		switch (stage) {
			case 0:
                stage = 1;
				[[GameController sharedGameController].currentScene removeDrawingImages];
				[self moveFromPoint:CGPointMake(290, 70) toPoint:CGPointMake(360, 270)];
				break;
            case 1:
                stage = 0;
				velocity = Vector2fMake(0, 0);
				duration = 2;
				break;
            
                
			default:
				break;
		}
	}
}

- (void)resetAnimation {
	
    [self moveFromPoint:CGPointMake(290, 70) toPoint:CGPointMake(360, 270)];
	stage = 0;
}

@end

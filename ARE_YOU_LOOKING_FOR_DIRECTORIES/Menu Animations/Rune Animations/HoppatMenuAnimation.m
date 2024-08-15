//
//  HoppatMenuAnimation.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/7/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "HoppatMenuAnimation.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "Image.h"

@implementation HoppatMenuAnimation

- (void)dealloc {
	
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
		[self moveFromPoint:CGPointMake(290, 200) toPoint:CGPointMake(360, 200)];
		essenceColor = Color4fMake(0, 0, 1, 1);
		runeText = @"Drawing on the power of ancient amphibians, Hoppat may sloth an enemy. Used on all enemies, it causes some strange weather... It will cure an ally of sloth and will summon the Ranger's frog when used on the party.";
		rune = [[Image alloc] initWithImageNamed:@"Rune187.png" filter:GL_LINEAR];
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	[super updateWithDelta:aDelta];
	if (duration < 0) {
		switch (stage) {
			case 0:
				stage++;
				[self moveFromPoint:CGPointMake(325, 200) toPoint:CGPointMake(290, 150)];
				break;
			case 1:
				stage++;
				[self moveFromPoint:CGPointMake(360, 200) toPoint:CGPointMake(325, 150)];
				break;
			case 2:
				stage++;
				velocity = Vector2fMake(0, 0);
				duration = 2;
				break;
                
			case 3:
				[[GameController sharedGameController].currentScene removeDrawingImages];
				stage = 0;
                [self moveFromPoint:CGPointMake(290, 200) toPoint:CGPointMake(360, 200)];
				break;
                
			default:
				break;
		}
	}
}

- (void)resetAnimation {
	
    [self moveFromPoint:CGPointMake(290, 200) toPoint:CGPointMake(360, 200)];
	stage = 0;
}


@end

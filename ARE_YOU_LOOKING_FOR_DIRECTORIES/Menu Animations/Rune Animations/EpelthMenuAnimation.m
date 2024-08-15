//
//  EpelthMenuAnimation.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/10/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "EpelthMenuAnimation.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "Image.h"

@implementation EpelthMenuAnimation

- (void)dealloc {
	
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
		[self moveFromPoint:CGPointMake(270, 220) toPoint:CGPointMake(320, 270)];
		essenceColor = Color4fMake(0, 0, 1, 1);
		runeText = @"Epelth is a rune infused with death. Used on an enemy it may end them. It will attack all enemies with the ghostly pall of death. It will grant a death attack to an ally and used on your party it will refill their endurance at the cost of their health.";
		rune = [[Image alloc] initWithImageNamed:@"Rune241.png" filter:GL_LINEAR];
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	[super updateWithDelta:aDelta];
	if (duration < 0) {
		switch (stage) {
			case 0:
				stage++;
				[self moveFromPoint:CGPointMake(370, 220) toPoint:CGPointMake(320, 270)];
				break;
			case 1:
				stage++;
				[self moveFromPoint:CGPointMake(270, 70) toPoint:CGPointMake(370, 220)];
				break;
            case 2:
                stage++;
                [self moveFromPoint:CGPointMake(370, 70) toPoint:CGPointMake(270, 220)];
                break;
			case 3:
				stage++;
				velocity = Vector2fMake(0, 0);
				duration = 2;
				break;
                
                
			case 4:
				[[GameController sharedGameController].currentScene removeDrawingImages];
				stage = 0;
                [self moveFromPoint:CGPointMake(270, 220) toPoint:CGPointMake(320, 270)];
				break;
                
			default:
				break;
		}
	}
}

- (void)resetAnimation {
	
    [self moveFromPoint:CGPointMake(270, 220) toPoint:CGPointMake(320, 270)];
	stage = 0;
}

@end

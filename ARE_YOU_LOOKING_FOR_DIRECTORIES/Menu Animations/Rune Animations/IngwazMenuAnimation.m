//
//  IngwazMenuAnimation.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/29/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "IngwazMenuAnimation.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "Image.h"

@implementation IngwazMenuAnimation

- (void)dealloc {
	
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
		[self moveFromPoint:CGPointMake(260, 150) toPoint:CGPointMake(310, 100)];
		essenceColor = Color4fMake(0, 0, 1, 1);
		runeText = @"Ingwaz draws upon the power of stone to attack your enemies. When used on an ally it will imbue them with the power of stone, while it can protect all of your allies from stone attacks.";
		rune = [[Image alloc] initWithImageNamed:@"Rune287.png" filter:GL_LINEAR];
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	[super updateWithDelta:aDelta];
	if (duration < 0) {
		switch (stage) {
			case 0:
				stage++;
				[self moveFromPoint:CGPointMake(310, 100) toPoint:CGPointMake(360, 150)];
				break;
			case 1:
				stage++;
				[self moveFromPoint:CGPointMake(360, 150) toPoint:CGPointMake(310, 200)];
				break;
            case 2:
                stage++;
                [self moveFromPoint:CGPointMake(310, 200) toPoint:CGPointMake(260, 150)];
                break;
			case 3:
				stage++;
				velocity = Vector2fMake(0, 0);
				duration = 2;
				break;
                
                
			case 4:
				[[GameController sharedGameController].currentScene removeDrawingImages];
				stage = 0;
                [self moveFromPoint:CGPointMake(260, 150) toPoint:CGPointMake(310, 100)];
				break;
                
			default:
				break;
		}
	}
}

- (void)resetAnimation {
	
    [self moveFromPoint:CGPointMake(260, 150) toPoint:CGPointMake(310, 100)];
	stage = 0;
}

@end

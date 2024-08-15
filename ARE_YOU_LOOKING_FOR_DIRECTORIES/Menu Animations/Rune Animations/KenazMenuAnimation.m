//
//  KenazMenuAnimation.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/26/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "KenazMenuAnimation.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "Image.h"

@implementation KenazMenuAnimation

- (void)dealloc {
	
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
		[self moveFromPoint:CGPointMake(360, 70) toPoint:CGPointMake(260, 170)];
		essenceColor = Color4fMake(0, 0, 1, 1);
		runeText = @"Kenaz is a fire rune that will torch your enemies. For your party, it will raise their strength.";
		rune = [[Image alloc] initWithImageNamed:@"Rune120.png" filter:GL_LINEAR];
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	[super updateWithDelta:aDelta];
	if (duration < 0) {
		switch (stage) {
            case 0:
                stage++;
                [self moveFromPoint:CGPointMake(260, 170) toPoint:CGPointMake(360, 270)];
                break;
            case 1:
                stage++;
                velocity = Vector2fMake(0, 0);
                duration = 2;
                break;
            case 2:
                stage = 0;
				[[GameController sharedGameController].currentScene removeDrawingImages];
                [self moveFromPoint:CGPointMake(360, 70) toPoint:CGPointMake(260, 170)];
				break;
                
			default:
				break;
		}
	}
}

- (void)resetAnimation {
	
    [self moveFromPoint:CGPointMake(360, 70) toPoint:CGPointMake(260, 170)];
	stage = 0;
}


@end

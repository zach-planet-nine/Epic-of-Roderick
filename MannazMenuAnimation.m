//
//  MannazMenuAnimation.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/28/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "MannazMenuAnimation.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "Image.h"

@implementation MannazMenuAnimation

- (void)dealloc {
	
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
		[self moveFromPoint:CGPointMake(290, 270) toPoint:CGPointMake(290, 70)];
		essenceColor = Color4fMake(0, 0, 1, 1);
		runeText = @"Mannaz draws upon the only animal to master fire: human beings. It will call forth an army to battle your enemies or will grant fire attacks to an ally. Using it on your party will protect against fire.";
		rune = [[Image alloc] initWithImageNamed:@"Rune252.png" filter:GL_LINEAR];
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	[super updateWithDelta:aDelta];
	if (duration < 0) {
		switch (stage) {
			case 0:
				stage++;
				[self moveFromPoint:CGPointMake(360, 270) toPoint:CGPointMake(360, 70)];
				break;
			case 1:
				stage++;
				[self moveFromPoint:CGPointMake(290, 270) toPoint:CGPointMake(360, 200)];
				break;
            case 2:
                stage++;
                [self moveFromPoint:CGPointMake(360, 270) toPoint:CGPointMake(290, 200)];
                break;
			case 3:
				stage++;
				velocity = Vector2fMake(0, 0);
				duration = 2;
				break;
                
                
			case 4:
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

//
//  RaidhoMenuAnimation.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/28/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "RaidhoMenuAnimation.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "Image.h"

@implementation RaidhoMenuAnimation

- (void)dealloc {
	
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
		[self moveFromPoint:CGPointMake(290, 270) toPoint:CGPointMake(290, 70)];
		essenceColor = Color4fMake(0, 0, 1, 1);
		runeText = @"Raidho calls upon the wizard's past. Used on a single enemy it will increase that enemy's vulnerability. Similarly it will boost the effectiveness of an ally's next move. Meanwhile using it on your enemies may sloth them, using it on your allies will remove sloth.";
		rune = [[Image alloc] initWithImageNamed:@"Rune288.png" filter:GL_LINEAR];
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	[super updateWithDelta:aDelta];
	if (duration < 0) {
		switch (stage) {
			case 0:
				stage++;
				[self moveFromPoint:CGPointMake(290, 270) toPoint:CGPointMake(340, 220)];
				break;
			case 1:
				stage++;
				[self moveFromPoint:CGPointMake(340, 220) toPoint:CGPointMake(290, 170)];
				break;
            case 2:
                stage++;
                [self moveFromPoint:CGPointMake(290, 170) toPoint:CGPointMake(340, 70)];
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

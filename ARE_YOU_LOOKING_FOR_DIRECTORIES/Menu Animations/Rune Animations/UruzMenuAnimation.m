//
//  UruzMenuAnimation.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/6/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "UruzMenuAnimation.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "Image.h"

@implementation UruzMenuAnimation

- (void)dealloc {
	
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
		[self moveFromPoint:CGPointMake(290, 70) toPoint:CGPointMake(310, 270)];
		essenceColor = Color4fMake(0, 0, 1, 1);
		runeText = @"Uruz draws power from the earthy animals of the world. It will cause bulls to stampede your enemies, or it can be used to grant strength to one of your allies. Used on your party it will summon the ranger's bear to your aid.";
		rune = [[Image alloc] initWithImageNamed:@"Rune117.png" filter:GL_LINEAR];
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	[super updateWithDelta:aDelta];
	if (duration < 0) {
		switch (stage) {
            case 0:
                stage++;
                [self moveFromPoint:CGPointMake(290, 270) toPoint:CGPointMake(350, 200)];
                break;
            case 1:
                stage++;
                velocity = Vector2fMake(0, 0);
                duration = 2;
                break;
            case 2:
                stage = 0;
				[[GameController sharedGameController].currentScene removeDrawingImages];
                [self moveFromPoint:CGPointMake(310, 70) toPoint:CGPointMake(310, 270)];
				break;
                
			default:
				break;
		}
	}
}

- (void)resetAnimation {
	
    [self moveFromPoint:CGPointMake(310, 70) toPoint:CGPointMake(310, 270)];
	stage = 0;
}

@end

//
//  TreasureChest.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 5/26/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "TreasureChest.h"
#import "Animation.h"
#import "InputManager.h"
#import "Image.h"
#import "Global.h"
#import "Textbox.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "PackedSpriteSheet.h"


@implementation TreasureChest

- (void)dealloc {
	
	[super dealloc];
}

- (id)initAtPosition:(CGPoint)aPosition withItem:(int)aItem {
	
	if (self = [super init]) {
		
		item = aItem;
		
		Image *chestClosed = [[GameController sharedGameController].teorPSS imageForKey:@"ChestClosed.png"];
		Image *chestOpen = [[GameController sharedGameController].teorPSS imageForKey:@"ChestOpen.png"];
		[currentAnimation addFrameWithImage:chestClosed delay:0.1];
		[currentAnimation addFrameWithImage:chestOpen delay:0.1];
		[chestClosed release];
		[chestOpen release];
		currentAnimation.state = kAnimationState_Stopped;
		currentAnimation.type = kAnimationType_Once;
		currentLocation = aPosition;
		destination = aPosition;
		movementSpeed = 0;
		moving = kNotMoving;
		
	}
	
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	if (stage == 1) {
		duration -= aDelta;
		if (duration < 0) {
			[sharedGameController.currentScene initBattle];
			stage = 2;
		}
	}
}
	

- (void)youWereTapped {
	
	if (stage == 0) {
		currentAnimation.state = kAnimationState_Running;
		Textbox *tb = [[Textbox alloc] initWithRect:CGRectMake(0, 0, 480, 100) color:Color4fMake(1.0, 1.0, 1.0, 0.4) duration:0.6 animating:YES text:@"Monstered!"];
		[sharedGameController.currentScene addObjectToActiveObjects:tb];
		[tb release];
		stage = 1;
		duration = 1.6;
	}
	
}

@end

//
//  SkillsMenu.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/6/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "SkillsMenu.h"
#import "GameController.h"
#import "AbstractSkillAnimation.h"
#import "Character.h"
#import "Image.h"


@implementation SkillsMenu

- (void)dealloc {
	
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
		currentCharacter = [[GameController sharedGameController].party objectAtIndex:0];
		currentAnimation = currentCharacter.skillAnimation;
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	if (currentAnimation) {
		[currentAnimation updateWithDelta:aDelta];
	}
}

- (void)render {
	[backgroundImage renderCenteredAtPoint:CGPointMake(240, 160)];
	[currentCharacter.characterImage renderCenteredAtPoint:CGPointMake(140, 220)];
	[currentAnimation render];
	[menuFont renderStringWrappedInRect:CGRectMake(200, 160, 240, 120) withText:currentAnimation.skillExplanation];
	[leftArrow renderCenteredAtPoint:CGPointMake(15, 15)];
	[rightArrow renderCenteredAtPoint:CGPointMake(465, 15)];
	int renderPointY = 0;
}

- (void)youWereTappedAt:(CGPoint)aTapLocation {
	
	if (CGRectContainsPoint(CGRectMake(0, 0, 40, 40), aTapLocation)) {
		if ([[GameController sharedGameController].party indexOfObject:currentCharacter] != 0) {
			currentCharacter = [[GameController sharedGameController].party objectAtIndex:([[GameController sharedGameController].party indexOfObject:currentCharacter] - 1)];
		} else {
			currentCharacter = [[GameController sharedGameController].party lastObject];
		}
		
	}
	if (CGRectContainsPoint(CGRectMake(440, 0, 40, 40), aTapLocation)) {
		if ([[GameController sharedGameController].party indexOfObject:currentCharacter] != [[GameController sharedGameController].party count] - 1) {
			currentCharacter = [[GameController sharedGameController].party objectAtIndex:([[GameController sharedGameController].party indexOfObject:currentCharacter] + 1)];
		} else {
			currentCharacter = [[GameController sharedGameController].party objectAtIndex:0];
		}
		
	}
	currentAnimation = currentCharacter.skillAnimation;
	[currentAnimation resetAnimation];
}

- (void)setCurrentCharacter:(int)aCharacter {
	
	currentCharacter = [[GameController sharedGameController].party objectAtIndex:aCharacter];
	currentAnimation = currentCharacter.skillAnimation;
	[currentAnimation resetAnimation];
}


@end

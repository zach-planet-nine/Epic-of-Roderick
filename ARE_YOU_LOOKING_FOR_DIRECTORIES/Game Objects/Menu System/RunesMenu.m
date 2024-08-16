//
//  RunesMenu.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/4/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "RunesMenu.h"
#import "AbstractScene.h"
#import "AnsuzMenuAnimation.h"
#import "GameController.h"
#import "Image.h"
#import "EihwazMenuAnimation.h"
#import "IsaMenuAnimation.h"
#import "BitmapFont.h"
#import "Character.h"
#import "AbstractRuneDrawingAnimation.h"


@implementation RunesMenu


- (void)dealloc {
	
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
		currentAnimation = [[IsaMenuAnimation alloc] init];
		currentCharacter = [[GameController sharedGameController].party objectAtIndex:0];
        Character *roderick = [sharedGameController.characters objectForKey:@"Roderick"];
        if ([roderick.knownRunes count] > 0) {
            knownRunes = [[NSArray alloc] init];
            knownRunes = [roderick.knownRunes allValues];
        } else {
            knownRunes = [[NSArray alloc] initWithObjects:[[IsaMenuAnimation alloc] init], nil];
        }
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
	[menuFont renderStringWrappedInRect:CGRectMake(80, 20, 200, 140) withText:currentAnimation.runeText];
	[currentAnimation.rune renderCenteredAtPoint:CGPointMake(190, 220)];
	[leftArrow renderCenteredAtPoint:CGPointMake(15, 15)];
	[rightArrow renderCenteredAtPoint:CGPointMake(465, 15)];
	int renderPointY = 0;
    NSEnumerator *runes = [currentCharacter.knownRunes objectEnumerator];
    AbstractRuneDrawingAnimation *animation;
	while (animation = [runes nextObject]) {
		[animation.rune renderCenteredAtPoint:CGPointMake(30, 270 - renderPointY) scale:Scale2fMake(0.7, 0.7) rotation:0];
		renderPointY += 32;
	}
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
    if (CGRectContainsPoint(CGRectMake(0, 40, 40, 280), aTapLocation)) {
        int i = 0;
        NSEnumerator *runes = [currentCharacter.knownRunes objectEnumerator];
        AbstractRuneDrawingAnimation *animation;
        while (animation = [runes nextObject]) {
            if (CGRectContainsPoint(CGRectMake(0, (270 - 16 - (i*32)), 60, 32), aTapLocation)) {
                [[GameController sharedGameController].currentScene removeDrawingImages];
                currentAnimation = animation;
                [currentAnimation resetAnimation];
                return;
            } else {
                i++;
            }
        }
    }
	[[GameController sharedGameController].currentScene removeDrawingImages];
    knownRunes = [currentCharacter.knownRunes allValues];
    currentAnimation = [knownRunes objectAtIndex:0];
	[currentAnimation resetAnimation];
}

- (void)setCurrentCharacter:(int)aCharacter {
	
	currentCharacter = [[GameController sharedGameController].party objectAtIndex:aCharacter];
    knownRunes = [currentCharacter.knownRunes allValues];
	[[GameController sharedGameController].currentScene removeDrawingImages];
	currentAnimation = [knownRunes objectAtIndex:0];
	[currentAnimation resetAnimation];
}

@end

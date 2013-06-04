//
//  PartyMenu.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/4/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "PartyMenu.h"
#import "GameController.h"
#import "Character.h"
#import "Image.h"


@implementation PartyMenu

- (void)dealloc {
	
	if (newParty) {
		[newParty release];
	}
	
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
		newParty = [[NSMutableArray alloc] initWithArray:sharedGameController.party];
		for (int i = 0; i < [newParty count]; i++) {
			if ([newParty objectAtIndex:i]) {
				characterRects[i] = CGRectMake(30 + (180 * i) - (540 * (i / 3)), 160 - (100 * (i / 3)), 59, 90);
				//NSLog(@"Rect was made with (%f, %f, %f, %f).", characterRects[i].origin.x, characterRects[i].origin.y, characterRects[i].size.width, characterRects[i].size.height);
			} else {
				characterRects[i] = CGRectMake(0, 0, 0, 0);
			}

		}
		currentSelectedIndex = 7;
		selectedColor = Color4fMake(0.7, 0.7, 0, 1);
	}
	return self;

}

- (void)updateWithDelta:(float)aDelta {
	
	if (currentSelectedIndex != 7) {
		colorFlash -= aDelta;
		if (colorFlash < 0) {
			colorFlash = 0.6;
		}
	}
}

- (void)render {

	[backgroundImage renderCenteredAtPoint:CGPointMake(240, 160)];
	if (currentSelectedIndex != 7 && colorFlash > 0.3) {
		Character *selectedCharacter = [newParty objectAtIndex:currentSelectedIndex];
		selectedCharacter.characterImage.color = selectedColor;
	} else if (currentSelectedIndex != 7 && colorFlash < 0.3) {
		Character *selectedCharacter = [newParty objectAtIndex:currentSelectedIndex];
		selectedCharacter.characterImage.color = Color4fOnes;
	}
	
	for (int i = 0; i < [newParty count]; i++) {
		Character *character = [newParty objectAtIndex:i];
		[character.characterImage renderCenteredAtPoint:CGPointMake(characterRects[i].origin.x + 25, characterRects[i].origin.y + 50)];
	}
}

- (void)youWereTappedAt:(CGPoint)aTapLocation {
	
	if (currentSelectedIndex == 7) {
		for (int i = 0; i < 6; i++) {
			if (CGRectContainsPoint(characterRects[i], aTapLocation)) {
				currentSelectedIndex = i;
				break;
			}
		}
	} else {
		for (int i = 0; i < 6; i++) {
			if (CGRectContainsPoint(characterRects[i], aTapLocation)) {
				Character *firstCharacter = [newParty objectAtIndex:currentSelectedIndex];
				Character *secondCharacter = [newParty objectAtIndex:i];
				firstCharacter.characterImage.color = secondCharacter.characterImage.color = Color4fMake(1, 1, 1, 1);
				[newParty replaceObjectAtIndex:i withObject:firstCharacter];
				[newParty replaceObjectAtIndex:currentSelectedIndex withObject:secondCharacter];
				sharedGameController.party = newParty;
				[currentMenu updateCharacters];
				currentSelectedIndex = 7;
				break;
			}
		}
	}
}


	


@end

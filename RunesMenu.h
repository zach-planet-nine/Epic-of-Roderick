//
//  RunesMenu.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/4/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractSubMenu.h"

@class AbstractRuneDrawingAnimation;
@class Character;

@interface RunesMenu : AbstractSubMenu {

	NSArray *knownRunes;
	AbstractRuneDrawingAnimation *currentAnimation;
	Character *currentCharacter;
}

- (void)setCurrentCharacter:(int)aCharacter;

@end

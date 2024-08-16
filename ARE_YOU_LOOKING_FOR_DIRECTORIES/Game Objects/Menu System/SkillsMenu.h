//
//  SkillsMenu.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/6/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractSubMenu.h"

@class Character;
@class AbstractSkillAnimation;

@interface SkillsMenu : AbstractSubMenu {
	
	Character *currentCharacter;
	AbstractSkillAnimation *currentAnimation;
}

- (void)setCurrentCharacter:(int)aCharacter;

@end

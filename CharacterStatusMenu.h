//
//  CharacterStatusMenu.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/19/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "AbstractSubMenu.h"

@class Character;

@interface CharacterStatusMenu : AbstractSubMenu {
    
    Character *currentCharacter;
}

- (void)setCurrentCharacter:(int)aCharacter;

@end

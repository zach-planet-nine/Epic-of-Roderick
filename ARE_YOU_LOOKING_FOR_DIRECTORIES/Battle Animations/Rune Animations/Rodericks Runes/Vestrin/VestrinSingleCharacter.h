//
//  VestrinSingleCharacter.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/23/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"

@class AbstractBattleCharacter;

@interface VestrinSingleCharacter : AbstractBattleAnimation

+ (void)grantSkyElementTo:(AbstractBattleCharacter *)aCharacter;

@end

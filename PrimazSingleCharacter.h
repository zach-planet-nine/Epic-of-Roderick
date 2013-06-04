//
//  PrimazSingleCharacter.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/27/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"

@class AbstractBattleCharacter;

@interface PrimazSingleCharacter : AbstractBattleAnimation 

+ (void)grantRageAttackTo:(AbstractBattleCharacter *)aCharacter;

@end

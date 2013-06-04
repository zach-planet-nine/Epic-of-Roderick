//
//  MannazSingleCharacter.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/28/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"

@interface MannazSingleCharacter : AbstractBattleAnimation 

+ (void)grantFireAttackTo:(AbstractBattleCharacter *)aCharacter;

@end

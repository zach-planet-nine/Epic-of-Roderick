//
//  FrogAllEnemies.h
//  TEORBattleTest
//
//  Created by Zach Babb on 6/1/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"

@class Frog;

@interface FrogAllEnemies : AbstractBattleAnimation {

	Frog *frog;
}

- (id)initFrom:(Frog *)aFrog;

- (void)calculateEffect;

@end

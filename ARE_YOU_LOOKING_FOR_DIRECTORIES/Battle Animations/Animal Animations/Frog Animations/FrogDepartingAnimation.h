//
//  FrogDepartingAnimation.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/6/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"

@class Frog;

@interface FrogDepartingAnimation : AbstractBattleAnimation {
    
    Frog *frog;
}

- (id)initFrom:(Frog *)aFrog;

@end

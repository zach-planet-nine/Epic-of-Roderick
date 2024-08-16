//
//  Motivate.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 8/14/11.
//  Copyright (c) 2011 InstantLazer. All rights reserved.
//

#import "AbstractBattleAnimation.h"
#import "Global.h"

@class BattleDwarf;

@interface Motivate : AbstractBattleAnimation {
    Vector2f velocity;
    CGPoint originalPoint;
    BattleDwarf *dwarf;
}

@end

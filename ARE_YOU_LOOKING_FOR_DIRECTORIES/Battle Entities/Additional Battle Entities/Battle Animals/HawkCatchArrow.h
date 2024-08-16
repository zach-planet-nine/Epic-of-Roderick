//
//  HawkCatchArrow.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 8/10/11.
//  Copyright (c) 2011 InstantLazer. All rights reserved.
//

#import "AbstractBattleAnimation.h"
#import "Global.h"

@class Hawk;

@interface HawkCatchArrow : AbstractBattleAnimation {
    
    CGPoint defensePoint;
    Vector2f velocity;
    Hawk *hawk;
}

+ (void)hawk:(Hawk *)aHawk CatchArrowAt:(CGPoint)aPoint;

- (id)initCatchArrowAt:(CGPoint)aPoint fromHawk:(Hawk *)aHawk;

@end

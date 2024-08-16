//
//  HawkAllCharacters.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 8/10/11.
//  Copyright (c) 2011 InstantLazer. All rights reserved.
//

#import "AbstractBattleAnimation.h"
#import "Global.h"

@class Hawk;

@interface HawkAllCharacters : AbstractBattleAnimation {
    
    CGPoint defensePoint;
    Vector2f velocity;
    Hawk *hawk;
}

- (id)initFromHawk:(Hawk *)aHawk;

@end

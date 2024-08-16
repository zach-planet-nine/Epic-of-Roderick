//
//  HawkSingleCharacter.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 8/10/11.
//  Copyright (c) 2011 InstantLazer. All rights reserved.
//

#import "AbstractBattleAnimation.h"
#import "Global.h"

@class Hawk;

@interface HawkSingleCharacter : AbstractBattleAnimation {
    
    Vector2f velocity;
    Hawk *hawk;
}

- (id)initToEntity:(AbstractBattleEntity *)aEntity fromHawk:(Hawk *)aHawk;

@end

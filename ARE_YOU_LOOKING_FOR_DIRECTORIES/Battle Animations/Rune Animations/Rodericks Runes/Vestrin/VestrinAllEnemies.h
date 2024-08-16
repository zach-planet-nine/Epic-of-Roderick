//
//  VestrinAllEnemies.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/23/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"

@class Textbox;

@interface VestrinAllEnemies : AbstractBattleAnimation {
    
    //I want to make an animation that will mimic swirling debris, or a tornado.
    int damage[4];
    float disorientationRolls[4];
    Textbox *tb;
}

@end

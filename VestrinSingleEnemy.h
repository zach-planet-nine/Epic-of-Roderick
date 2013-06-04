//
//  VestrinSingleEnemy.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/23/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"

@interface VestrinSingleEnemy : AbstractBattleAnimation {
    
    NSMutableArray *debris;
    BOOL hasDamaged[10];
    float bleederDuration;
}

@end

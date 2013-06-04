//
//  FehuAllEnemies.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/6/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"

@interface FehuAllEnemies : AbstractBattleAnimation {
    
    NSMutableArray *statEmitters;
    float timers[4];
    CGPoint enemies[4];
}

@end

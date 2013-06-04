//
//  GromanthAllEnemies.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/21/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"

@interface GromanthAllEnemies : AbstractBattleAnimation {
    
    NSMutableArray *statEmitters;
    float timers[4];
    CGPoint enemies[4];
}

@end

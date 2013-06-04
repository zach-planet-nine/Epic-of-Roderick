//
//  FyrazAllEnemies.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/29/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"

@interface FyrazAllEnemies : AbstractBattleAnimation {
    
    NSMutableArray *fyrazEmitters;
    int damages[4];
}

@end

//
//  TiwazAllEnemies.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/28/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"
#import "Global.h"

@interface TiwazAllEnemies : AbstractBattleAnimation {
    
    NSMutableArray *comets;
    NSMutableArray *explosions;
    Vector2f velocities[8];
    float cometDurations[8];
    int damages[4];
}

@end

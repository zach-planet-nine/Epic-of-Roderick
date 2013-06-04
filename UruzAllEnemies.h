//
//  UruzAllEnemies.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/6/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"

@interface UruzAllEnemies : AbstractBattleAnimation {
    
    NSMutableArray *bulls;
    NSMutableArray *dustEmitters;
    int damages[4];
}

@end

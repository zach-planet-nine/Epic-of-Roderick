//
//  OthalaAllEnemies.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/21/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"

@class FadeInOrOut;

@interface OthalaAllEnemies : AbstractBattleAnimation {
    
    NSMutableArray *othalaEmitters;
    FadeInOrOut *dimWorld;
    int damage;
}

@end

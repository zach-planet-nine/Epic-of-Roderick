//
//  NauthizAllEnemies.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/25/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"

@class Projectile;
@class FadeInOrOut;

@interface NauthizAllEnemies : AbstractBattleAnimation {
    
    Projectile *nauthizGhost;
    FadeInOrOut *dimWorld;
    int damages[4];
}

@end

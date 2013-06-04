//
//  RaidhoSingleEnemy.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/27/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"

@class Image;
@class Projectile;

@interface RaidhoSingleEnemy : AbstractBattleAnimation {
    
    Image *shield;
    Image *brokenShield;
    Projectile *shieldBreaker;
    
}

@end

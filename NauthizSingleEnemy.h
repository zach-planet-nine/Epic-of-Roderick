//
//  NauthizSingleEnemy.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/25/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"

@class Projectile;
@class Image;
@class FadeInOrOut;

@interface NauthizSingleEnemy : AbstractBattleAnimation {
    
    Projectile *ghostProjectile;
    Image *nauthizGhost;
    FadeInOrOut *dimWorld;
    int essenceDamage;
}

@end

//
//  SwopazSingleEnemy.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/7/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "AbstractBattleAnimation.h"

@class Projectile;

@interface SwopazSingleEnemy : AbstractBattleAnimation {
    
    Projectile *flyingLog;
    int damage;
}

@end

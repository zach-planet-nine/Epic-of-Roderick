//
//  HawkSingleEnemy.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 8/10/11.
//  Copyright (c) 2011 InstantLazer. All rights reserved.
//

#import "AbstractBattleAnimation.h"
#import "Global.h"

@class Hawk;

@interface HawkSingleEnemy : AbstractBattleAnimation {
    
    Hawk *hawk;
    CGPoint originalEnemyRenderPoint;
    CGPoint originalHawkRenderPoint;
    Vector2f hawkVelocity;
    Vector2f enemyVelocity;
    
}

- (id)initToEnemy:(AbstractBattleEnemy *)aEnemy fromHawk:(Hawk *)aHawk;

@end

//
//  Boobytrap.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 8/11/11.
//  Copyright (c) 2011 InstantLazer. All rights reserved.
//

#import "AbstractBattleAnimation.h"

@class Projectile;
@class Animation;

@interface Boobytrap : AbstractBattleAnimation {
    
    Projectile *trap;
    Animation *clawTrap;
    AbstractBattleEnemy *enemy;
    int damage;
}

@property (nonatomic, retain) AbstractBattleEnemy *enemy;

+ (void)triggerTrap:(AbstractBattleEnemy *)aEnemy;

- (id)initToEnemy:(AbstractBattleEnemy *)aEnemy;

- (void)trigger;

@end

//
//  SuperAxerang.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 8/13/11.
//  Copyright (c) 2011 InstantLazer. All rights reserved.
//

#import "AbstractBattleAnimation.h"
#import "Global.h"

@class Projectile;

@interface SuperAxerang : AbstractBattleAnimation {
    Vector2f projectilePoints[5];
    Projectile *axerang;
    int damages[4];
}

@end

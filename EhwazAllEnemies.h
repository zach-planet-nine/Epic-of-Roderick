//
//  EhwazAllEnemies.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/8/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "AbstractBattleAnimation.h"

@class Projectile;

@interface EhwazAllEnemies : AbstractBattleAnimation {
    
    Projectile *sleipnir;
    int damages[4];
}

@end

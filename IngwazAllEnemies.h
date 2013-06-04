//
//  IngwazAllEnemies.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/28/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"

@class Image;
@class Projectile;

@interface IngwazAllEnemies : AbstractBattleAnimation {
    
    Image *golem;
    Projectile *stone;
    int damages[4];
}

@end

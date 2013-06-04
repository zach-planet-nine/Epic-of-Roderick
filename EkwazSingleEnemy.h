//
//  Ekwaz.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/30/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"

@class Image;

@interface EkwazSingleEnemy : AbstractBattleAnimation {
    
    Image *stone;
    int damage;
    float fatigueRoll;
}

@end

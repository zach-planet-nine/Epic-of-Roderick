//
//  AustrinSingleEnemy.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/22/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"
#import "Global.h"

@class Image;

@interface AustrinSingleEnemy : AbstractBattleAnimation {
    
    Image *darkCloud;
    float timer;
    Vector2f velocity;
}

@end

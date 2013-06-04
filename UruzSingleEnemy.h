//
//  UruzSingleEnemy.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/6/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"

@class Image;
@class ParticleEmitter;

@interface UruzSingleEnemy : AbstractBattleAnimation {
    
    Image *bull;
    ParticleEmitter *dustEmitter;
    int damage;
}

@end

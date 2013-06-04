//
//  JeraAllEnemies.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/24/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"

@class Image;
@class ParticleEmitter;

@interface JeraAllEnemies : AbstractBattleAnimation {
    
    Image *norn;
    ParticleEmitter *rageExplosion;
    int damage;
    int valkLevel;
    int alphaDirection;
    CGPoint renderPoints[4];

}

@end

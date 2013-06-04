//
//  GeboAllEnemies.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/8/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "AbstractBattleAnimation.h"

@class ParticleEmitter;
@class Animation;
@class Image;

@interface GeboAllEnemies : AbstractBattleAnimation {
    
    Animation *treasureChest;
    ParticleEmitter *explosion;
    Image *dynamite;
    int damages[4];
}

@end

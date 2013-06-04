//
//  HelazAllEnemies.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/10/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "AbstractBattleAnimation.h"

@class Image;
@class ParticleEmitter;

@interface HelazAllEnemies : AbstractBattleAnimation {
    
    Image *garm;
    ParticleEmitter *helazEmitter;
    int damages[4];
}

@end

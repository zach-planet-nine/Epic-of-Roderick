//
//  DaleythAllEnemies.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/29/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"
#import "Global.h"

@class ParticleEmitter;
@class Image;

@interface DaleythAllEnemies : AbstractBattleAnimation {
    
    ParticleEmitter *portalEmitter;
    Image *sirLamorak;
    Image *axe;
    int damages[4];
    Vector2f velocity;
    
}

@end

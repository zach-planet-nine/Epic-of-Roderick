//
//  ThurisazAllEnemies.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/6/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"

@class ParticleEmitter;

@interface ThurisazAllEnemies : AbstractBattleAnimation {
    
    ParticleEmitter *thornEmitter;
    int damage;
}

@end

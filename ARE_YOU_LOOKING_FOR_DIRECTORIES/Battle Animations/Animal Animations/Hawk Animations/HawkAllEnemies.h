//
//  HawkAllEnemies.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 8/10/11.
//  Copyright (c) 2011 InstantLazer. All rights reserved.
//

#import "AbstractBattleAnimation.h"
#import "Global.h"

@class ParticleEmitter;
@class Hawk;

@interface HawkAllEnemies : AbstractBattleAnimation {
    
    Vector2f velocity;
    ParticleEmitter *hawkEmitter;
    Hawk *hawk;
    CGPoint originalRenderPoint;
}

- (id)initFromHawk:(Hawk *)aHawk;

@end

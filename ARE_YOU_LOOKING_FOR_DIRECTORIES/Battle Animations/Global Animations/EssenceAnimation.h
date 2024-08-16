//
//  EssenceAnimation.h
//  TEORBattleTest
//
//  Created by Zach Babb on 6/1/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"

@class ParticleEmitter;
@class AbstractBattleEntity;


@interface EssenceAnimation : AbstractBattleAnimation {

	ParticleEmitter *essenceEmitter;
}

- (id)initWithEntity:(AbstractBattleEntity *)aEntity;

@end

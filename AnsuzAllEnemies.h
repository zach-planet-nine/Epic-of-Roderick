//
//  AnsuzAllEnemies.h
//  TEORBattleTest
//
//  Created by Zach Babb on 5/30/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"
#import "Global.h"

@class ParticleEmitter;


@interface AnsuzAllEnemies : AbstractBattleAnimation {

	NSMutableArray *essenceEmitters;
	ParticleEmitter *ansuzBall;
	ParticleEmitter *explosion;
	Vector2f velocity;
	Color4f colors[3];
	int colorIndex;
	int maxColors;
	
}

@end

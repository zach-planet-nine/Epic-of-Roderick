//
//  PrimazAllCharacters.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/27/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"
#import "Global.h"

@class ParticleEmitter;

@interface PrimazAllCharacters : AbstractBattleAnimation {
    
    int rageAdder;
    NSMutableArray *essenceEmitters;
	ParticleEmitter *primazBall;
	Vector2f velocity;
	Color4f colors[2];
	int colorIndex;
	int maxColors;
}

@end

//
//  Fire.h
//  TEORBattleTest
//
//  Created by Zach Babb on 5/22/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Image;
@class Projectile;
@class ParticleEmitter;
@class BitmapFont;
@class GameController;

@interface Fire : NSObject {
	
	GameController *sharedGameController;
	
	float duration;
	Image *image;
	Projectile *projectile;
	ParticleEmitter *particleEmitter;
	BitmapFont *battleFont;
	int stage;
	CGPoint fontRenderPoint;
	
}

@property (nonatomic, assign) float duration;

- (id)initFromCharacter:(int)aCharacter toEnemy:(int)aEnemy;

- (void)updateWithDelta:(float)aDelta;

- (void)render;

@end

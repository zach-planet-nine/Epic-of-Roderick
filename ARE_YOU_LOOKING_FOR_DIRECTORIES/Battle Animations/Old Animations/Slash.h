//
//  Slash.h
//  TEORBattleTest
//
//  Created by Zach Babb on 5/22/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Global.h"

@class Animation;
@class BitmapFont;

@interface Slash : NSObject {
	
	Animation *slashAnimation;
	GLfloat rotation;
	CGPoint renderPoint;
	bool active;
	float duration;
	BitmapFont *battleFont;
	CGPoint fontRenderPoint;
}

@property (nonatomic, readonly) bool active;

- (id)initWithCharacter:(int)aCharacter enemy:(int)aEnemy fromPoint:(CGPoint)aFromPoint toPoint:(CGPoint)aToPoint;

- (void)updateWithDelta:(float)aDelta;

- (void)render;

@end

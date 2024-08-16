//
//  RuneObject.h
//  TEORBattleTest
//
//  Created by Zach Babb on 5/21/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractGameObject.h"

@class Image;


@interface RuneObject : AbstractGameObject {
	
	Image *image;
}

- (void)updateWithDelta:(float)aDelta;

- (void)render;

- (id)initWithTypeOfRune:(int)aRune;

- (void)setRenderPoint:(CGPoint)aRenderPoint;


@end

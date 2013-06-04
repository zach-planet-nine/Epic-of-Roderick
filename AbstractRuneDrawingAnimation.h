//
//  AbstractRuneDrawingAnimation.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/4/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractGameObject.h"
#import "Global.h"

@class Image;

@interface AbstractRuneDrawingAnimation : AbstractGameObject {

	Vector2f velocity;
	Image *runeDrawingImage;
	Color4f essenceColor;
	CGPoint currentPosition;
	NSString *runeText;
	Image *rune;
}

@property (nonatomic, assign) Color4f essenceColor;
@property (nonatomic, assign) NSString *runeText;
@property (nonatomic, retain) Image *rune;

- (void)updateWithDelta:(float)aDelta;

- (void)render;

- (void)moveFromPoint:(CGPoint)aFromPoint toPoint:(CGPoint)aToPoint;

- (void)resetAnimation;

@end

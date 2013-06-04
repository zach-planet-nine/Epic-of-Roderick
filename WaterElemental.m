//
//  WaterElemental.m
//  TEORBattleTest
//
//  Created by Zach Babb on 5/22/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "WaterElemental.h"
#import "Animation.h"
#import "Projectile.h"
#import "BitmapFont.h"


@implementation WaterElemental

@synthesize active;

- (id)initWithCharacter:(int)aCharacter enemy:(int)aEnemy fromPoint:(CGPoint)aFromPoint toPoint:(CGPoint)aToPoint {
	
	if (self = [super init]) {
		if (aCharacter == 1 && aEnemy == 1) {
			waterProjectiles = [[NSMutableArray alloc] init];
			for (int i = 0; i < 4; i++) {
				float angle = 15 * (i * RANDOM_MINUS_1_TO_1());
				Projectile *waterball = [[Projectile alloc] initProjectileFrom:Vector2fMake(aFromPoint.x, aFromPoint.y) 
																			to:Vector2fMake(aToPoint.x, aToPoint.y) 
																	 withImage:@"Waterball.png" 
																	   lasting:1.5 
																withStartAngle:angle
																 withStartSize:Scale2fMake(0.5, 0.5)
																  toFinishSize:Scale2fMake(1.0, 1.0)];				
				[waterProjectiles addObject:waterball];
				[waterball release];
			}
			battleFont = [[BitmapFont alloc] initWithFontImageNamed:@"TimesNewRoman32.png" controlFile:@"TimesNewRoman32" scale:Scale2fMake(0.5, 0.5) filter:GL_LINEAR];
			active = YES;
			duration = 1.5;
			fontRenderPoint = CGPointMake(aToPoint.x, aToPoint.y);
		}
	}
	
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	duration -= aDelta;
	if (duration < 0.0) {
		if ([waterProjectiles count] > 0) {
			[waterProjectiles removeAllObjects];
			duration = 2.0;
		} else {
			active = NO;
		}
		
	}
	if ([waterProjectiles count] == 0) {
		fontRenderPoint.y -= aDelta * 10;
	}
	if ([waterProjectiles count] > 0) {
		for (int index = 0; index < [waterProjectiles count]; index++) {
			[[waterProjectiles objectAtIndex:index] updateWithDelta:aDelta];
		}
	}
}

- (void)render {
	if ([waterProjectiles count] > 0) {
		for (int index = 0; index < [waterProjectiles count]; index++) {
			[[waterProjectiles objectAtIndex:index] render];
		}
	} else {
		[battleFont renderStringAt:fontRenderPoint text:@"Damage!"]; 
	}
	
	
}


@end

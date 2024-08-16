//
//  TargetObject.m
//  TEORBattleTest
//
//  Created by Zach Babb on 5/27/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "TargetObject.h"
#import "Image.h"
#import "TouchManager.h"


@implementation TargetObject

@synthesize renderPoint;

- (void)dealloc {
	
	if (target) {
		[target release];
	}
	
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
				
		sharedTouchManager = [TouchManager sharedTouchManager];
		target = [[Image alloc] initWithImageNamed:@"Target.png" filter:GL_LINEAR];
		renderPoint = CGPointMake(320, 160);
		
	}
	
	return self;
}

- (void)render {
	
	[target renderCenteredAtPoint:renderPoint];
}

- (void)updateLocationWithAccelerationX:(float)aAccelerationX andAccelerationY:(float)aAccelerationY {
	
	renderPoint = CGPointMake(renderPoint.x + aAccelerationX, renderPoint.y + aAccelerationY);

}

@end

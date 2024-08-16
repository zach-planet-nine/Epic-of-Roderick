//
//  SettingsMenu.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/4/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "SettingsMenu.h"


@implementation SettingsMenu

- (void)dealloc {
	
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
		//Put rect code here.
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {}

- (void)render {
	
	[backgroundImage renderCenteredAtPoint:CGPointMake(240, 160)];
	[menuFont renderStringAt:CGPointMake(200, 160) text:@"Put all of your settings options in here."];
}

@end

//
//  SystemMenu.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/4/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "SystemMenu.h"
#import "Image.h"
#import "BitmapFont.h"


@implementation SystemMenu

- (void)dealloc {
	
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
		//Here you would generate your system rects.
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {}

- (void)render {
	
	[backgroundImage renderCenteredAtPoint:CGPointMake(240, 160)];
	[menuFont renderStringAt:CGPointMake(50, 250) text:@"Put save file 1 here"];
	[menuFont renderStringAt:CGPointMake(50, 150) text:@"Put save file 2 here"];
	[menuFont renderStringAt:CGPointMake(50, 50) text:@"Put save file 3 here"];
}



@end

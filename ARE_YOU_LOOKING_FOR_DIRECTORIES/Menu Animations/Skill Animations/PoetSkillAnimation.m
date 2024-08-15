//
//  PoetSkillAnimation.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/7/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "PoetSkillAnimation.h"


@implementation PoetSkillAnimation

- (void)dealloc {
	
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
		skillExplanation = @"The Poet has the ability to summon the Gods, but since I have not implemented this yet, I have no animation to show.";
	}
	return self;
}

- (void)resetAnimation {
}

@end

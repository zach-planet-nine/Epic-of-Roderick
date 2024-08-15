//
//  RangerSkillAnimation.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/7/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "RangerSkillAnimation.h"
#import "Frog.h"
#import "FrogSingleEnemy.h"
#import "ImageRenderManager.h"


@implementation RangerSkillAnimation

- (void)dealloc {
	
	if (frog) {
		[frog release];
	}
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
		frog = [[Frog alloc] init];
		frog.renderPoint = CGPointMake(100, 90);
		skillExplanation = @"The Ranger is able to call upon the help of animals. Draw a line from the Ranger's current animal companion to one of the four battle zones. It's almost like having a fourth party member.";
		fse = [[FrogSingleEnemy alloc] initSkillAnimationToEnemy:exampleEnemy from:frog];
		fse.active = NO;
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	[super updateWithDelta:aDelta];
	if (fse.active) {
		[frog updateWithDelta:aDelta];
		[fse updateWithDelta:aDelta];
	}
	if (skillTimer < 0) {
		[fse resetAnimation];	
		skillTimer = 5;
	}
}

- (void)render {
	
	[frog render];
	[exampleEnemy render];
	if (fse.active) {
		[[ImageRenderManager sharedImageRenderManager] renderImages];
		[fse render];
	}
	
}

- (void)resetAnimation {
	[fse resetAnimation];	
	skillTimer = 5;
}
	


@end

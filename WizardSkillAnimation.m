//
//  WizardSkillAnimation.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/7/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "WizardSkillAnimation.h"
#import "BattleWizard.h"
#import "RollingBones.h"
#import "Textbox.h"


@implementation WizardSkillAnimation

- (void)dealloc {
	
	if (bones) {
		[bones release];
	}
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
		wizard = [[BattleWizard alloc] initWithBattleLocation:2];
		wizard.renderPoint = CGPointMake(60, 60);
		bones = [[RollingBones alloc] initFrom:wizard];
		bones.active = YES;
		skillExplanation = @"The Wizard is able to cast bones to divine the future. What he divines will come to pass, but we don't necessarily know when. With practice the Wizard's predictions will get more exact and come to pass quicker."; 
		tb = [[Textbox alloc] initWithRect:CGRectMake(100, 15, 280, 60) color:Color4fMake(0.4, 0.4, 0.4, 0.8) duration:3.5 animating:YES text:@"Wizard: I sense that some stuff will happen to some things..."];
		tb.active = NO;
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	[super updateWithDelta:aDelta];
	if (bones.active) {
		[bones updateWithDelta:aDelta];
	}
	if (bones.active == NO && tb.active == NO) {
		[tb resetAnimatingWithDuration:3.3];
	}
	if (skillTimer < 0) {
		[bones resetAnimation];	
		skillTimer = 5;
	}
	if (tb.active) {
		[tb updateWithDelta:aDelta];
	}
}

- (void)render {
	
	[wizard render];
	if (bones.active) {
		[bones render];
	}
	if (tb.active) {
		[tb render];
	}
}

- (void)resetAnimation {
	[bones resetAnimation];	
	skillTimer = 5;
}
	

	
@end

//
//  DwarfSkillAnimation.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/7/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "DwarfSkillAnimation.h"
#import "BattleDwarf.h"
#import "Dwarfapult.h"
#import "ImageRenderManager.h"


@implementation DwarfSkillAnimation

- (void)dealloc {
	
	if (dwarfapult) {
		[dwarfapult release];
	}
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
		
		dwarf = [[BattleDwarf alloc] initWithBattleLocation:2];
		dwarfapult = [[Dwarfapult alloc] initToEnemy:exampleEnemy from:dwarf];
		dwarfapult.active = NO;
		dwarf.renderPoint = CGPointMake(100, 90);
		skillExplanation = @"The Dwarf automatically attacks depending on what he's had to drink. Experiment with different combinations of drinks to see what happens. This is his ingenious dwarfapult!";
	}
	return self;
}

- (void)updateWithDelta:(float)aDelta {
	
	
	[super updateWithDelta:aDelta];
	if (dwarfapult.active) {
		[dwarfapult updateWithDelta:aDelta];
	}
	if (skillTimer < 0) {
		[dwarfapult resetAnimation];	
		skillTimer = 5;
	}
}

- (void)render {
	
	[exampleEnemy render];
	[dwarf render];
	if (dwarfapult.active) {
		[[ImageRenderManager sharedImageRenderManager] renderImages];
		[dwarfapult render];
	}
}

- (void)resetAnimation {
	
	[dwarfapult resetAnimation];
	skillTimer = 5;
}

@end

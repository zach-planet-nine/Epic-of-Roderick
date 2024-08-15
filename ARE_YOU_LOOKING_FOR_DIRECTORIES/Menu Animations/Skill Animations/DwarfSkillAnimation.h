//
//  DwarfSkillAnimation.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/7/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractSkillAnimation.h"

@class Dwarfapult;
@class BattleDwarf;

@interface DwarfSkillAnimation : AbstractSkillAnimation {

	BattleDwarf *dwarf;
	Dwarfapult *dwarfapult;
}

@end

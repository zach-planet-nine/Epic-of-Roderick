//
//  WizardSkillAnimation.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/7/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractSkillAnimation.h"

@class RollingBones;
@class BattleWizard;
@class Textbox;

@interface WizardSkillAnimation : AbstractSkillAnimation {

	RollingBones *bones;
	BattleWizard *wizard;
	Textbox *tb;
}

@end

//
//  RangerSkillAnimation.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/7/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractSkillAnimation.h"

@class Frog;
@class FrogSingleEnemy;


@interface RangerSkillAnimation : AbstractSkillAnimation {

	Frog *frog;
	FrogSingleEnemy *fse;
	
}

@end

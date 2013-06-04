//
//  RoderickSkillAnimation.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/6/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractSkillAnimation.h"

@class Pond;
@class PondSingleEnemyAttack;

@interface RoderickSkillAnimation : AbstractSkillAnimation {

	Pond *pond;
	PondSingleEnemyAttack *psea;
}

@end

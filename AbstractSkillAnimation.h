//
//  AbstractSkillAnimation.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/6/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractGameObject.h"

@class AbstractBattleEnemy;

@interface AbstractSkillAnimation : AbstractGameObject {

	AbstractBattleEnemy *exampleEnemy;
	float skillTimer;
	NSString *skillExplanation;
}

@property (nonatomic, retain) NSString *skillExplanation;

- (void)updateWithDelta:(float)aDelta;

- (void)render;

- (void)resetAnimation;

@end

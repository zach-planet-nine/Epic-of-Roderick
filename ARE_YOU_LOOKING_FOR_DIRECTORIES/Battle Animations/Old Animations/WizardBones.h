//
//  WizardBones.h
//  TEORBattleTest
//
//  Created by Zach Babb on 5/24/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"


@interface WizardBones : AbstractBattleAnimation {

	NSMutableArray *bones;
	//float duration;
	int roll;
	CGPoint fontRenderPoint;
}


@end

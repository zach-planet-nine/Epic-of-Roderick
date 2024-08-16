//
//  RollingBones.h
//  TEORBattleTest
//
//  Created by Zach Babb on 5/31/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"

@class BattleWizard;

@interface RollingBones : AbstractBattleAnimation {
	
	NSMutableArray *bones;
	BattleWizard *wizard;
}

- (id)initFrom:(BattleWizard *)aWizard;

@end

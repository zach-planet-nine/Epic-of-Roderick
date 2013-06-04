//
//  Bleeder.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/7/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "AbstractBattleAnimation.h"

@interface Bleeder : AbstractBattleAnimation

+ (void)addBleederTo:(AbstractBattleEntity *)aEntity withDuration:(float)aDuration;

- (id)initWithTarget:(AbstractBattleEntity *)aEntity withDuration:(float)aDuration;

@end

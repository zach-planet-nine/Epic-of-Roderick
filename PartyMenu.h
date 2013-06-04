//
//  PartyMenu.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/4/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractSubMenu.h"
#import "Global.h"


@interface PartyMenu : AbstractSubMenu {

	NSMutableArray *newParty;
	BOOL swapOn;
	CGRect characterRects[6];
	int currentSelectedIndex;
	Color4f selectedColor;
	float colorFlash;
}

@end

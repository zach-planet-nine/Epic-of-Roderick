//
//  ItemsMenu.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/4/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractSubMenu.h"


@interface ItemsMenu : AbstractSubMenu {
	
	CGRect itemRects[10];
	NSMutableArray *itemImages;
	
	NSString *currentInformation;
}

@end

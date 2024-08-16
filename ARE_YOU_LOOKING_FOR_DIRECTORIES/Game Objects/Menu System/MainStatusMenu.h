//
//  MainStatusMenu.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/3/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractSubMenu.h"
#import "Global.h"

@class Animation;
@class Character;

@interface MainStatusMenu : AbstractSubMenu {

	//Rects to manage touches
	CGRect character1Rect;
	CGRect character2Rect;
	CGRect character3Rect;
	CGRect iconRects[9]; //An array of rects for icons
	
	NSMutableArray *iconAnimations;
	int currentTopCharacter;
	
    Character *roderick;
	
}

@property (nonatomic, assign) int currentTopCharacter;


@end

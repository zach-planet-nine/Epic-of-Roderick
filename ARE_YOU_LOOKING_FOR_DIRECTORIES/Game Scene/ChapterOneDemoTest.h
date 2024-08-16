//
//  ChapterOneDemoTest.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/10/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractScene.h"

@interface ChapterOneDemoTest : AbstractScene {
    BOOL roderickBattleTutorial;
    BOOL blocked[100][100];
    int portals[100][100];
    CGPoint portalDestination[7];
    
}

@property (nonatomic, assign) BOOL roderickBattleTutorial;

@end

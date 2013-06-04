//
//  ChapterOneDemoTestV2.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/18/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "AbstractScene.h"

@interface ChapterOneDemoTestV2 : AbstractScene {
    
    BOOL roderickBattleTutorial;
    BOOL roderickHasDied;
    BOOL blocked[100][100];
    int portals[100][100];
    CGPoint portalDestination[7];
}

@property (nonatomic, assign) BOOL roderickBattleTutorial;

@end

//
//  CutSceneTest.h
//  TEORCutSceneTest
//
//  Created by Zach Babb on 5/22/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractScene.h"
#import "Global.h"

@class TiledMap;
@class Robo;
@class Marle;


@interface CutSceneTest : AbstractScene {

	
	Scale2f cameraPositionZ;
	int zoomer;
	Robo *character;
	Marle *character2;
	
}

- (void)moveToNextStageInScene;

@end

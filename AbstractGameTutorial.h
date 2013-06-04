//
//  AbstractGameTutorial.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 8/9/11.
//  Copyright (c) 2011 InstantLazer. All rights reserved.
//

#import "AbstractGameObject.h"

@class ScriptReader;

@interface AbstractGameTutorial : AbstractGameObject {
    
    ScriptReader *sharedScriptReader;
    BOOL replay;
}

@property (nonatomic, assign) BOOL replay;

- (void)advance;

- (void)endTutorial;

@end

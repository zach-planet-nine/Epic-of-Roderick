//
//  ScriptReader.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 8/5/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>

@class InputManager;

@interface ScriptReader : NSObject {
    
    int currentLine;
    int nextLine;
    int cutScene;
    NSString *scriptName;
    InputManager *sharedInputManager;
}

+ (ScriptReader *)sharedScriptReader;

- (id)initWithScript:(NSString *)aScript;

- (void)createCutScene:(int)aCutScene;

- (void)writeDialogFromLine:(int)aStartLine toLine:(int)aFinishLine;

- (void)generateCutSceneDialog:(int)aCutScene;

- (void)advanceCutScene;

- (void)endCutScene;

- (void)createTutorial:(int)aTutorial;

- (void)advanceTutorial;

- (void)endTutorial;

@end

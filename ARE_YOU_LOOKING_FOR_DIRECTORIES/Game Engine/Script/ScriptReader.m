//
//  ScriptReader.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 8/5/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "ScriptReader.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractGameTutorial.h"
#import "SynthesizeSingleton.h"
#import "Textbox.h"
#import "Choicebox.h"
#import "InputManager.h"


@implementation ScriptReader

SYNTHESIZE_SINGLETON_FOR_CLASS(ScriptReader);

- (id)init {
    
    self = [self initWithScript:@"EnglishScript"];
    return self;
}

- (id)initWithScript:(NSString *)aScript
{
    self = [super init];
    if (self) {
        
        currentLine = 0;
        nextLine = 1;
        scriptName = aScript;
        sharedInputManager = [InputManager sharedInputManager];
    }
    
    return self;
}

- (void)createCutScene:(int)aCutScene {
    
    currentLine = 1;
    nextLine = 2;
    cutScene = aCutScene;
    NSString *line = [NSString stringWithFormat:@"CutScene%dLine%d", aCutScene, currentLine];
    NSString *aDialog = [NSLocalizedStringFromTable(line, scriptName, @"none") retain];
    [Textbox textboxWithText:aDialog];
    currentLine++;
    nextLine++;
    [sharedInputManager setState:kCutScene_ScriptReader];
    
}

- (void)advanceCutScene {
     NSString *line = [NSString stringWithFormat:@"CutScene%dLine%d", cutScene, currentLine];
    NSString *aDialog = [NSLocalizedStringFromTable(line, scriptName, @"none") retain];
    if ([aDialog characterAtIndex:0] == [@"&" characterAtIndex:0]) {
        [[GameController sharedGameController].currentScene removeTextbox];
        NSString *runeName = [aDialog substringFromIndex:1];
        [Textbox centerTextboxWithText:[[NSString stringWithFormat:@"You have received a %@ runestone!", runeName] retain]];
        NSLog(@"%@", runeName);
        [aDialog release];
        [sharedInputManager setState:kCutScene_ScriptReader];
        currentLine++;
        nextLine++;
        NSLog(@"Current %d, Next %d", currentLine, nextLine);
        return;
    }
    if ([aDialog characterAtIndex:0] == [@"!" characterAtIndex:0]) {
        [[GameController sharedGameController].currentScene removeTextbox];
        NSString *runeName = [aDialog substringFromIndex:1];
        [Textbox centerTextboxWithText:[[NSString stringWithFormat:@"You have received a %@ runestone!", runeName] retain]];
        NSLog(@"%@", runeName);
        [aDialog release];
        [sharedInputManager setState:kCutScene_ScriptReader];
        currentLine++;
        nextLine++;
        NSLog(@"Current %d, Next %d", currentLine, nextLine);
        return;
    }
    if ([aDialog characterAtIndex:0] == [@"$" characterAtIndex:0]) {
        [aDialog release];
        [sharedInputManager setState:kNoTouchesAllowed];
        currentLine++;
        nextLine++;
        NSLog(@"Current %d, Next %d", currentLine, nextLine);
        [[GameController sharedGameController].currentScene moveToNextStageInScene];
        return;
    }
    if ([aDialog characterAtIndex:0] == [@"%" characterAtIndex:0]) {
        int letterIndex = 1;
        int stringSplit = 1;
        NSMutableArray *choices = [[NSMutableArray alloc] init];
        while (letterIndex < [aDialog length]) {
            if ([aDialog characterAtIndex:letterIndex] == [@"%" characterAtIndex:0]) {
                NSString *choice = [[aDialog substringWithRange:NSMakeRange(stringSplit, letterIndex - stringSplit)] retain];
                [choices addObject:choice];
                stringSplit = letterIndex;
            }
            letterIndex++;
        }
        [Choicebox choiceboxWithChoices:choices];
        [choices release];
        currentLine++;
        nextLine++;
        NSLog(@"Current %d, Next %d", currentLine, nextLine);
        return;
    }
    if ([aDialog characterAtIndex:0] == [@"(" characterAtIndex:0]) {
        [Textbox centerTextboxWithText:[[aDialog substringFromIndex:1] retain]];
        [aDialog release];
        currentLine++;
        nextLine++;
        NSLog(@"Current %d, Next %d", currentLine, nextLine);
        [sharedInputManager setState:kCutScene_ScriptReader];
        return;
    }
    [Textbox updateTextboxText:aDialog];
    line = [NSString stringWithFormat:@"CutScene%dLine%d", cutScene, nextLine];
    NSString *nextString = NSLocalizedStringFromTable(line, scriptName, @"none");
    if ([nextString characterAtIndex:0] == [@";" characterAtIndex:0]) {
        [sharedInputManager setState:kCutScene_LastLine];
        NSLog(@"Current %d, Next %d", currentLine, nextLine);
        return;
    }
    currentLine++;
    nextLine++;
    NSLog(@"Current %d, Next %d", currentLine, nextLine);
    [sharedInputManager setState:kCutScene_ScriptReader];
}

- (void)writeDialogFromLine:(int)aStartLine toLine:(int)aFinishLine {}

- (void)generateCutSceneDialog:(int)aCutScene {}

- (void)endCutScene {
    
    [[GameController sharedGameController].currentScene removeTextbox];
    [[GameController sharedGameController].currentScene moveToNextStageInScene];
}

- (void)createTutorial:(int)aTutorial {

    currentLine = 1;
    nextLine = 2;
    cutScene = aTutorial;
    NSString *line = [NSString stringWithFormat:@"Tutorial%dLine%d", aTutorial, currentLine];
    NSString *aDialog = [NSLocalizedStringFromTable(line, scriptName, @"none") retain];
    [Textbox centerTextboxWithText:aDialog];
    currentLine++;
    nextLine++;
    [sharedInputManager setState:kTutorial_TextboxOnScreen];
}

- (void)advanceTutorial {
    [sharedInputManager setState:kNoTouchesAllowed];

    NSString *line = [NSString stringWithFormat:@"Tutorial%dLine%d", cutScene, currentLine];
    NSString *aDialog = [NSLocalizedStringFromTable(line, scriptName, @"none") retain];
    
   
    if ([aDialog characterAtIndex:0] == [@"$" characterAtIndex:0]) {
        [aDialog release];
        [sharedInputManager setState:kNoTouchesAllowed];
        currentLine++;
        nextLine++;
        NSLog(@"Current %d, Next %d", currentLine, nextLine);
        for (AbstractGameTutorial *agt in [GameController sharedGameController].currentScene.activeObjects) {
            if ([agt isKindOfClass:[AbstractGameTutorial class]]) {
                [agt advance];
            }
        }
        return;
    }
    if ([aDialog characterAtIndex:0] == [@"(" characterAtIndex:0]) {
        [Textbox updateTextboxText:[[aDialog substringFromIndex:1] retain]];
        [aDialog release];
        currentLine++;
        nextLine++;
        NSLog(@"Current %d, Next %d", currentLine, nextLine);
        [sharedInputManager setState:kTutorial_TextboxOnScreen];
        return;
    }
    [Textbox updateCenterTextboxText:aDialog];
    line = [NSString stringWithFormat:@"Tutorial%dLine%d", cutScene, nextLine];
    NSString *nextString = NSLocalizedStringFromTable(line, scriptName, @"none");
    if ([nextString characterAtIndex:0] == [@";" characterAtIndex:0]) {
        [sharedInputManager setState:kTutorial_LastLine];
        NSLog(@"Current %d, Next %d", currentLine, nextLine);
        return;
    }
    currentLine++;
    nextLine++;
    NSLog(@"Current %d, Next %d", currentLine, nextLine);
    [sharedInputManager setState:kTutorial_TextboxOnScreen];
}

- (void)endTutorial {
    
    for (AbstractGameTutorial *agt in [GameController sharedGameController].currentScene.activeObjects) {
        if ([agt isKindOfClass:[AbstractGameTutorial class]]) {
            [agt endTutorial];
        }
    }
}

@end

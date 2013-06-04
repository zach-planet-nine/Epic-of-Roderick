//
//  AbstractGameTutorial.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 8/9/11.
//  Copyright (c) 2011 InstantLazer. All rights reserved.
//

#import "AbstractGameTutorial.h"
#import "ScriptReader.h"

@implementation AbstractGameTutorial

@synthesize replay;

- (void)dealloc {
    
    [super dealloc];
}

- (id)init {
    
    if (self = [super init]) {
        sharedScriptReader = [ScriptReader sharedScriptReader];
        active = YES;
        replay = NO;
    }
    return self;
}

- (void)advance {}

- (void)endTutorial {}

@end

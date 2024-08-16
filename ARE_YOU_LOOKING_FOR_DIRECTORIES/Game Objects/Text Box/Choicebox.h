//
//  Choicebox.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/24/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "Textbox.h"

@interface Choicebox : Textbox {
    
    int choices;
    NSMutableArray *choiceStrings;
    CGRect rects[5];
    CGRect displayRect;
}

+ (void)choiceboxWithChoices:(NSArray *)aChoices;

- (id)initChoiceboxWithChoices:(NSArray *)aChoices;

- (void)youWereTappedAt:(CGPoint)aLocation;

@end

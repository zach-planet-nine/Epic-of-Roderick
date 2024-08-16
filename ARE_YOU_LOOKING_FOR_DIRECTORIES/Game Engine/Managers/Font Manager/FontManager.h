//
//  FontManager.h
//  TEORCutSceneTest
//
//  Created by Zach Babb on 5/22/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BitmapFont;


@interface FontManager : NSObject {

	NSMutableDictionary *fonts;
}

@property (nonatomic, retain) NSMutableDictionary *fonts;

- (void)addFont:(BitmapFont *)aFont withKey:(NSString *)aString;

+ (FontManager *)sharedFontManager;

- (BitmapFont *)getFontWithKey:(NSString *)aFontKey;

@end

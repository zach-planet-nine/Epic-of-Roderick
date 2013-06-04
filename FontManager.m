//
//  FontManager.m
//  TEORCutSceneTest
//
//  Created by Zach Babb on 5/22/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "FontManager.h"
#import "BitmapFont.h"
#import "SynthesizeSingleton.h"


@implementation FontManager

@synthesize fonts;

SYNTHESIZE_SINGLETON_FOR_CLASS(FontManager);

- (void)dealloc {
	
	if (fonts) {
		[fonts release];
	}
	
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
		fonts = [[NSMutableDictionary alloc] init];
	}
	
	return self;
}

- (void)addFont:(BitmapFont *)aFont withKey:(NSString *)aKey {
	
	[fonts setObject:aFont forKey:aKey];
}

- (BitmapFont *)getFontWithKey:(NSString *)aFontKey {
	
	return [fonts objectForKey:aFontKey];
}

	
	

@end

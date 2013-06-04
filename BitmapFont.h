//
//  BitmapFont.h
//  TEORBattleTest
//
//  Created by Zach Babb on 5/21/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Global.h"

@class Image;
@class GameController;

#define kMaxCharsInFont 223

typedef struct _BitmapFontChar {
	int charID;
	int x;
	int y;
	int width;
	int height;
	int xOffset;
	int yOffset;
	int xAdvance;
	Image *image;
	float scale;
} BitmapFontChar;

enum {
	BitmapFontJustification_TopCentered,
	BitmapFontJustification_MiddleCentered,
	BitmapFontJustification_BottomCentered,
	BitmapFontJustification_TopRight,
	BitmapFontJustification_MiddleRight,
	BitmapFontJustification_BottomRight,
	BitmapFontJustification_TopLeft,
	BitmapFontJustification_MiddleLeft,
	BitmapFontJustification_BottomLeft
};


@interface BitmapFont : NSObject {
	
	GameController *sharedGameController;
	Image *image;
	BitmapFontChar *charsArray;
	int lineHeight;
	Color4f fontColor;
}

@property (nonatomic, retain) Image *image;
@property (nonatomic, assign) Color4f fontColor;

- (id)initWithFontImageNamed:(NSString *)aFileName controlFile:(NSString *)aControlFile scale:(Scale2f)aScale filter:(GLenum)aFilter;

- (id)initWithImage:(Image *)aImage controlFile:(NSString *)aControlFile scale:(Scale2f)aScale filter:(GLenum)aFilter;

- (void)renderStringAt:(CGPoint)aPoint text:(NSString *)aText;

- (void)renderStringAt:(CGPoint)aPoint withText:(NSString *)aText withColor:(Color4f)aColor withScale:(Scale2f)aScale;

- (void)renderStringJustifiedInFrame:(CGRect)aRect justification:(int)aJustification text:(NSString *)aText;

- (void)renderStringJustifiedInFrame:(CGRect)aRect justification:(int)aJustification text:(NSString *)aText withColor:(Color4f)aColor;

- (void)renderStringAt:(CGPoint)aPoint withText:(NSString *)aText withColor:(Color4f)aFontColor;

- (void)renderStringWrappedInRect:(CGRect)aRect withText:(NSString *)aText;

- (void)renderStringWrappedInRect:(CGRect)aRect withText:(NSString *)aText withColor:(Color4f)aColor;

- (void)renderNarrativeString:(NSString *)aText inRect:(CGRect)aRect withColor:(Color4f)aColor;

- (int)getWidthForString:(NSString *)string;

- (int)getHeightForString:(NSString *)string;

@end

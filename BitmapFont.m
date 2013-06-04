//
//  BitmapFont.m
//  TEORBattleTest
//
//  Created by Zach Babb on 5/21/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "BitmapFont.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "Image.h"

@interface BitmapFont (Private)

- (void)parseFont:(NSString *)controlFile;

- (void)parseCommon:(NSString *)line;

- (void)parseCharacterDefinition:(NSString *)line;

@end

@implementation BitmapFont

@synthesize image;
@synthesize fontColor;

- (void)dealloc {
	
	if (charsArray) {
		for (int i = 0; i < kMaxCharsInFont; i++) {
			if (charsArray[i].image) {
				[charsArray[i].image release];
			}
		}
		free(charsArray);
	}
	
	if (image) {
		[image release];
	}
	
	[super dealloc];
}

- (id)initWithFontImageNamed:(NSString *)aFileName controlFile:(NSString *)aControlFile scale:(Scale2f)aScale filter:(GLenum)aFilter {
	self = [self init];
	
	if (self != nil) {
		sharedGameController = [GameController sharedGameController];
		
		image = [[Image alloc] initWithImageNamed:aFileName filter:aFilter];
		image.scale = aScale;
		
		fontColor = Color4fMake(1.0f, 1.0f, 1.0f, 1.0f);
		
		charsArray = calloc(kMaxCharsInFont, sizeof(BitmapFontChar));
		
		[self parseFont:aControlFile];
	}
	
	return self;
}

- (id)initWithImage:(Image *)aImage controlFile:(NSString *)aControlFile scale:(Scale2f)aScale filter:(GLenum)aFilter {
	self = [self init];
	
	if (self != nil) {
		
		sharedGameController = [GameController sharedGameController];
		
		self.image = aImage;
		self.image.scale = aScale;
		
		fontColor = Color4fMake(1.0f, 1.0f, 1.0f, 1.0f);
		
		charsArray = calloc(kMaxCharsInFont, sizeof(BitmapFontChar));
		
		[self parseFont:aControlFile];
	}
	
	return self;
}

- (void)renderStringAt:(CGPoint)aPoint withText:(NSString *)aText withColor:(Color4f)aFontColor {
	
	float xScale = image.scale.x;
	float yScale = image.scale.y;
	
	for (int i = 0; i < [aText length]; i++) {
		
		unichar charID = [aText characterAtIndex:i] - 32;
		
		int y = aPoint.y + (lineHeight * yScale) - (charsArray[charID].height + charsArray[charID].yOffset) * yScale;
		int x = aPoint.x + charsArray[charID].xOffset;
		CGPoint renderPoint = CGPointMake(x, y);
		
		charsArray[charID].image.color = aFontColor;
		
		[charsArray[charID].image renderAtPoint:renderPoint];
		
		aPoint.x += charsArray[charID].xAdvance * xScale;
	}
}


- (void)renderStringAt:(CGPoint)aPoint text:(NSString *)aText {
	
	float xScale = image.scale.x;
	float yScale = image.scale.y;
	
	for (int i = 0; i < [aText length]; i++) {
		
		unichar charID = [aText characterAtIndex:i] - 32;
		
		int y = aPoint.y + (lineHeight * yScale) - (charsArray[charID].height + charsArray[charID].yOffset) * yScale;
		int x = aPoint.x + charsArray[charID].xOffset;
		CGPoint renderPoint = CGPointMake(x, y);
		
		charsArray[charID].image.color = fontColor;
		
		[charsArray[charID].image renderAtPoint:renderPoint];
		
		aPoint.x += charsArray[charID].xAdvance * xScale;
	}
}

- (void)renderStringAt:(CGPoint)aPoint withText:(NSString *)aText withColor:(Color4f)aFontColor withScale:(Scale2f)aScale {
    
    float xScale = image.scale.x;
	float yScale = image.scale.y;
	
	for (int i = 0; i < [aText length]; i++) {
		
		unichar charID = [aText characterAtIndex:i] - 32;
		
		int y = aPoint.y + (lineHeight * yScale) - (charsArray[charID].height + charsArray[charID].yOffset) * yScale;
		int x = aPoint.x + charsArray[charID].xOffset;
		CGPoint renderPoint = CGPointMake(x, y);
		
		charsArray[charID].image.color = aFontColor;
        charsArray[charID].image.scale = aScale;
		
		[charsArray[charID].image renderAtPoint:renderPoint];
		
		aPoint.x += charsArray[charID].xAdvance * xScale;
	}

    
}

- (void)renderStringJustifiedInFrame:(CGRect)aRect justification:(int)aJustification text:(NSString *)aText {
	
	CGPoint point;
	
	int textWidth = [self getWidthForString:aText];
	int textHeight = [self getHeightForString:aText];
	
	switch (aJustification) {
		case BitmapFontJustification_TopLeft:
			point.x = aRect.origin.x;
			point.y = aRect.origin.y + (aRect.size.height - textHeight) - (lineHeight - textHeight);
			break;
		case BitmapFontJustification_MiddleLeft:
			point.x = aRect.origin.x;
			point.y = aRect.origin.y + ((aRect.size.height - textHeight) / 2) - (lineHeight - textHeight);
			break;
		case BitmapFontJustification_BottomLeft:
			point.x = aRect.origin.x;
			point.y = aRect.origin.y - (lineHeight - textHeight);
			break;
		case BitmapFontJustification_TopCentered:
			point.x = aRect.origin.x + ((aRect.size.width - textWidth) / 2);
			point.y = aRect.origin.y + (aRect.size.height - textHeight) - (lineHeight - textHeight);
			break;
		case BitmapFontJustification_MiddleCentered:
			point.x = aRect.origin.x + ((aRect.size.width - textWidth) / 2);
			point.y = aRect.origin.y + ((aRect.size.height - textHeight) / 2) - (lineHeight - textHeight);
			break;
		case BitmapFontJustification_BottomCentered:
			point.x = aRect.origin.x + ((aRect.size.width - textWidth) / 2);
			point.y = aRect.origin.y - (lineHeight - textHeight);
			break;
		case BitmapFontJustification_TopRight:
			point.x = aRect.origin.x + (aRect.size.width - textWidth);
			point.y = aRect.origin.y + (aRect.size.height - textHeight) - (lineHeight - textHeight);
			break;
		case BitmapFontJustification_MiddleRight:
			point.x = aRect.origin.x + (aRect.size.width - textWidth);
			point.y = aRect.origin.y + ((aRect.size.height - textHeight) / 2) - (lineHeight - textHeight);
			break;
		case BitmapFontJustification_BottomRight:
			point.x = aRect.origin.x + (aRect.size.width - textWidth);
			point.y = aRect.origin.y - (lineHeight - textHeight);
			break;
			
		default:
			break;
	}
	
	[self renderStringAt:point text:aText];
}

- (void)renderStringJustifiedInFrame:(CGRect)aRect justification:(int)aJustification text:(NSString *)aText withColor:(Color4f)aColor {
    
    CGPoint point;
	
	int textWidth = [self getWidthForString:aText];
	int textHeight = [self getHeightForString:aText];
	
	switch (aJustification) {
		case BitmapFontJustification_TopLeft:
			point.x = aRect.origin.x;
			point.y = aRect.origin.y + (aRect.size.height - textHeight) - (lineHeight - textHeight);
			break;
		case BitmapFontJustification_MiddleLeft:
			point.x = aRect.origin.x;
			point.y = aRect.origin.y + ((aRect.size.height - textHeight) / 2) - (lineHeight - textHeight);
			break;
		case BitmapFontJustification_BottomLeft:
			point.x = aRect.origin.x;
			point.y = aRect.origin.y - (lineHeight - textHeight);
			break;
		case BitmapFontJustification_TopCentered:
			point.x = aRect.origin.x + ((aRect.size.width - textWidth) / 2);
			point.y = aRect.origin.y + (aRect.size.height - textHeight) - (lineHeight - textHeight);
			break;
		case BitmapFontJustification_MiddleCentered:
			point.x = aRect.origin.x + ((aRect.size.width - textWidth) / 2);
			point.y = aRect.origin.y + ((aRect.size.height - textHeight) / 2) - (lineHeight - textHeight);
			break;
		case BitmapFontJustification_BottomCentered:
			point.x = aRect.origin.x + ((aRect.size.width - textWidth) / 2);
			point.y = aRect.origin.y - (lineHeight - textHeight);
			break;
		case BitmapFontJustification_TopRight:
			point.x = aRect.origin.x + (aRect.size.width - textWidth);
			point.y = aRect.origin.y + (aRect.size.height - textHeight) - (lineHeight - textHeight);
			break;
		case BitmapFontJustification_MiddleRight:
			point.x = aRect.origin.x + (aRect.size.width - textWidth);
			point.y = aRect.origin.y + ((aRect.size.height - textHeight) / 2) - (lineHeight - textHeight);
			break;
		case BitmapFontJustification_BottomRight:
			point.x = aRect.origin.x + (aRect.size.width - textWidth);
			point.y = aRect.origin.y - (lineHeight - textHeight);
			break;
			
		default:
			break;
	}
	
	[self renderStringAt:point withText:aText withColor:aColor];
}

- (int)getWidthForString:(NSString *)string {
	int stringWidth = 0;
	
	for (int index = 0; index < [string length]; index++) {
		unichar charID = [string characterAtIndex:index] - 32;
		stringWidth += charsArray[charID].xAdvance * image.scale.x;
	}
	
	return stringWidth;
}

- (int)getHeightForString:(NSString *)string {
	int stringHeight = 0;
	
	for (int i = 0; i < [string length]; i++) {
		unichar charID = [string characterAtIndex:i] - 32;
		
		if (charID == ' ') {
			continue;
		}
		
		stringHeight = MAX((charsArray[charID].height * image.scale.y) + (charsArray[charID].yOffset * image.scale.y), stringHeight);
	}
	
	return stringHeight;
}

//Added code for text wrapping.
- (void)renderStringWrappedInRect:(CGRect)aRect withText:(NSString *)aText {
	int stringSplitIndex = 0;
	int stringWidth = 0;
	////NSLog(@"aRect's width is: %d.", (int)(aRect.size.width - 8));
	for (int index = 0; index < [aText length]; index++) {
		unichar charID = [aText characterAtIndex:index] - 32;
		stringWidth += charsArray[charID].xAdvance * image.scale.x;
		////NSLog(@"CharID: %d, stringWidth: %d, Rect width: %d.", (int)(charID), stringWidth, (int)(aRect.size.width - 8));
		if ((int)(stringWidth) > (int)(aRect.size.width - 8)) {
            if (stringSplitIndex != 0) {
                [self renderStringAt:CGPointMake(aRect.origin.x + 8, aRect.origin.y + (aRect.size.height - (lineHeight + 4))) text:[aText substringToIndex:stringSplitIndex]];
                [self renderStringWrappedInRect:CGRectMake(aRect.origin.x, aRect.origin.y, aRect.size.width, (aRect.size.height - ((lineHeight / 2) + 6))) 
                                       withText:[aText substringFromIndex:stringSplitIndex + 1]];
                ////NSLog(@"This is being called.");
                return;
            }
		} else if (charID == 0) {
			stringSplitIndex = index;
		}
	}
	[self renderStringAt:CGPointMake(aRect.origin.x + 8, aRect.origin.y + (aRect.size.height - (lineHeight + 4))) text:aText];
}

- (void)renderStringWrappedInRect:(CGRect)aRect withText:(NSString *)aText withColor:(Color4f)aColor {
    
    int stringSplitIndex = 0;
	int stringWidth = 0;
	////NSLog(@"aRect's width is: %d.", (int)(aRect.size.width - 8));
	for (int index = 0; index < [aText length]; index++) {
		unichar charID = [aText characterAtIndex:index] - 32;
		stringWidth += charsArray[charID].xAdvance * image.scale.x;
		////NSLog(@"CharID: %d, stringWidth: %d, Rect width: %d.", (int)(charID), stringWidth, (int)(aRect.size.width - 8));
		if ((int)(stringWidth) > (int)(aRect.size.width - 8)) {
            if (stringSplitIndex != 0) {
                [self renderStringAt:CGPointMake(aRect.origin.x + 8, aRect.origin.y + (aRect.size.height - (lineHeight + 4))) withText:[aText substringToIndex:stringSplitIndex] withColor:aColor];
                [self renderStringWrappedInRect:CGRectMake(aRect.origin.x, aRect.origin.y, aRect.size.width, (aRect.size.height - ((lineHeight / 2) + 6))) 
                                       withText:[aText substringFromIndex:stringSplitIndex + 1] withColor:aColor];
                ////NSLog(@"This is being called.");
                return;
            }
		} else if (charID == 0) {
			stringSplitIndex = index;
		}
	}
	[self renderStringAt:CGPointMake(aRect.origin.x + 8, aRect.origin.y + (aRect.size.height - (lineHeight + 4))) withText:aText withColor:aColor];
}

- (void)renderNarrativeString:(NSString *)aText inRect:(CGRect)aRect withColor:(Color4f)aColor {
    
    int stringSplitIndex = 0;
	int stringWidth = 0;
	////NSLog(@"aRect's width is: %d.", (int)(aRect.size.width - 8));
	for (int index = 0; index < [aText length]; index++) {
		unichar charID = [aText characterAtIndex:index] - 32;
		stringWidth += charsArray[charID].xAdvance * image.scale.x;
		////NSLog(@"CharID: %d, stringWidth: %d, Rect width: %d.", (int)(charID), stringWidth, (int)(aRect.size.width - 8));
		if ((int)(stringWidth) > (int)(aRect.size.width - 8)) {
            if (stringSplitIndex != 0) {
                [self renderStringJustifiedInFrame:CGRectMake(aRect.origin.x, aRect.origin.y + aRect.size.height - (lineHeight + 4), aRect.size.width, lineHeight + 4) justification:BitmapFontJustification_MiddleCentered text:[aText substringToIndex:stringSplitIndex] withColor:aColor];
                //[self renderStringAt:CGPointMake(aRect.origin.x + 8, aRect.origin.y + (aRect.size.height - (lineHeight + 4))) withText:[aText substringToIndex:stringSplitIndex] withColor:aColor];
                [self renderNarrativeString:[aText substringFromIndex:stringSplitIndex + 1] inRect:CGRectMake(100, 100, 280, (aRect.size.height - (lineHeight + 4))) withColor:aColor];
                //[self renderStringWrappedInRect:CGRectMake(aRect.origin.x, aRect.origin.y, aRect.size.width, (aRect.size.height - ((lineHeight / 2) + 6))) 
                  //                     withText:[aText substringFromIndex:stringSplitIndex + 1] withColor:aColor];
                ////NSLog(@"This is being called.");
                return;
            }
		} else if (charID == 0) {
			stringSplitIndex = index;
		}
	}
	[self renderStringJustifiedInFrame:CGRectMake(aRect.origin.x, aRect.origin.y + aRect.size.height - (lineHeight + 4), aRect.size.width, lineHeight + 4) justification:BitmapFontJustification_MiddleCentered text:aText withColor:aColor];
}
	
	

@end

@implementation BitmapFont (Private)

- (void)parseFont:(NSString *)aControlFile {
	
	NSString *contents = [NSString stringWithContentsOfFile:
						  [[NSBundle mainBundle] pathForResource:aControlFile ofType:@"fnt"] encoding:NSASCIIStringEncoding error:nil];
	
	NSArray *lines = [[NSArray alloc] initWithArray:[contents componentsSeparatedByString:@"\n"]];
	
	NSEnumerator *nse = [lines objectEnumerator];
	
	NSString *line;
	
	while (line = [nse nextObject]) {
		
		if ([line hasPrefix:@"common"]) {
			[self parseCommon:line];
		} else if([line hasPrefix:@"char id"]) {
			[self parseCharacterDefinition:line];
		}
	}
	
	[lines release];
}

- (void)parseCommon:(NSString *)line {
	
	int scaleW;
	int scaleH;
	int pages;
	
	sscanf([line UTF8String], "common lineHeight=%i base=%*i scaleW=%i scaleH=%i pages=%i", &lineHeight, &scaleW, &scaleH, &pages);
	
}

- (void)parseCharacterDefinition:(NSString *)line {
	
	int charID;
	
	sscanf([line UTF8String], "char id=%i", &charID);
	
	charID -= 32;
	
	sscanf([line UTF8String], "char id=%*i x=%i y=%i width=%i height=%i xoffset=%i yoffset=%i xadvance=%i",
		   &charsArray[charID].x, &charsArray[charID].y, &charsArray[charID].width,
		   &charsArray[charID].height, &charsArray[charID].xOffset, &charsArray[charID].yOffset, &charsArray[charID].xAdvance);
	
	charsArray[charID].image = [[image subImageInRect:CGRectMake(charsArray[charID].x, 
																 charsArray[charID].y, 
																 charsArray[charID].width,
																 charsArray[charID].height)] retain];
	
	charsArray[charID].image.scale = image.scale;
}

@end


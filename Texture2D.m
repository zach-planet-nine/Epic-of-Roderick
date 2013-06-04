//
//  Texture2D.m
//  TEORBattleTest
//
//  Created by Zach Babb on 5/21/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <OpenGLES/ES1/glext.h>
#import "Texture2D.h"

#define kMaxTextureSize 1024

@implementation Texture2D

@synthesize contentSize;
@synthesize pixelFormat;
@synthesize width;
@synthesize height;
@synthesize name;
@synthesize maxS;
@synthesize maxT;
@synthesize textureRatio;

- (void)dealloc {
	if (name) {
		glDeleteTextures(1, &name);
	}
	[super dealloc];
}

- (id)initWithImage:(UIImage *)aImage filter:(GLenum)aFilter {
	
	self = [super init];
	if (self != nil) {
		CGImageRef image;
		
		image = [aImage CGImage];
		
		CGImageAlphaInfo info = CGImageGetAlphaInfo(image);
		BOOL hasAlpha = ((info == kCGImageAlphaPremultipliedLast) ||
						 (info == kCGImageAlphaLast) ||
						 (info == kCGImageAlphaFirst) ? YES : NO);
		
		if (CGImageGetColorSpace(image)) {
			if (hasAlpha) {
				pixelFormat = kTexture2DPixelFormat_RGBA8888;
			}
			else {
				pixelFormat = kTexture2DPixelFormat_RGB565;
			}
		}
		else {
			pixelFormat = kTexture2DPixelFormat_A8;
		}
		
		contentSize = CGSizeMake(CGImageGetWidth(image), CGImageGetHeight(image));
		
		NSUInteger pot;
		
		width = contentSize.width;
		if ((width != 1) && (width & (width - 1))) {
			pot = 1;
			while (pot < width) {
				pot *= 2;
			}
			width = pot;
		}
		
		height = contentSize.height;
		if ((height != 1) && (height & (height - 1))) {
			pot = 1;
			while (pot < height) {
				pot *= 2;
			}
			height = pot;
		}
		
		CGAffineTransform transform = CGAffineTransformIdentity;
		
		while ((width > kMaxTextureSize) || (height > kMaxTextureSize)) {
			width /= 2;
			height /=2;
			transform = CGAffineTransformScale(transform, 0.5, 0.5);
			contentSize.width *= 0.5;
			contentSize.height *= 0.5;
		}
		
		CGColorSpaceRef colorSpace;
		CGContextRef context = nil;
		GLvoid *data = nil;
		
		switch (pixelFormat) {
			case kTexture2DPixelFormat_RGBA8888:
				colorSpace = CGColorSpaceCreateDeviceRGB();
				data = malloc(height * width * 4);
				context = CGBitmapContextCreate(data, width, height, 8, 4 * width, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
				CGColorSpaceRelease(colorSpace);
				break;
				
			case kTexture2DPixelFormat_RGB565:
				colorSpace = CGColorSpaceCreateDeviceRGB();
				data = malloc(height * width * 4);
				context = CGBitmapContextCreate(data, width, height, 8, 4 * width, colorSpace, kCGImageAlphaNoneSkipLast | kCGBitmapByteOrder32Big);
				CGColorSpaceRelease(colorSpace);
				break;
				
			case kTexture2DPixelFormat_A8:
				data = malloc(height * width);
				context = CGBitmapContextCreate(data, width, height, 8, width, NULL, kCGImageAlphaOnly);
				break;
				
			default:
				[NSException raise:NSInternalInconsistencyException format:@"Invalid pixel format"];
		}
		
		CGContextClearRect(context, CGRectMake(0, 0, width, height));
		CGContextTranslateCTM(context, 0, height - contentSize.height);
		
		if (!CGAffineTransformIsIdentity(transform)) {
			CGContextConcatCTM(context, transform);
		}
		
		CGContextDrawImage(context, CGRectMake(0, 0, CGImageGetWidth(image), CGImageGetHeight(image)), image);
		
		if (pixelFormat == kTexture2DPixelFormat_RGB565) {
			void *tempData = malloc(height * width * 2);
			unsigned int *inPixel32 = (unsigned int *)data;
			unsigned short *outPixel16 = (unsigned short *)tempData;
			for (int i = 0; i < width * height; ++i, ++inPixel32) {
				*outPixel16++ = ((((*inPixel32 >> 0) & 0xFF) >> 3) << 11) |
				((((*inPixel32 >> 8) & 0xFF) >> 2) << 5) |
				((((*inPixel32 >> 16) & 0xFF) >> 3) << 0);
			}
			free(data);
			data = tempData;
		}
		
		glGenTextures(1, &name);
		glBindTexture(GL_TEXTURE_2D, name);
		
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, aFilter);
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, aFilter);
		
		switch (pixelFormat) {
			case kTexture2DPixelFormat_RGBA8888:
				glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, data);
				break;
			case kTexture2DPixelFormat_RGB565:
				glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, width, height, 0, GL_RGB, GL_UNSIGNED_SHORT_5_6_5, data);
				break;
			case kTexture2DPixelFormat_A8:
				glTexImage2D(GL_TEXTURE_2D, 0, GL_ALPHA, width, height, 0, GL_ALPHA, GL_UNSIGNED_BYTE, data);
				break;
			default:
				[NSException raise:NSInternalInconsistencyException format:@""];
				break;
		}
		
		maxS = contentSize.width / (float)width;
		maxT = contentSize.height / (float)height;
		
		textureRatio.width = 1.0f / (float)width;
		textureRatio.height = 1.0f / (float)height;
		
		CGContextRelease(context);
		free(data);
	}
	
	return self;
}

@end
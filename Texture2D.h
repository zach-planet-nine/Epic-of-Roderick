//
//  Texture2D.h
//  TEORBattleTest
//
//  Created by Zach Babb on 5/21/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <OpenGLES/ES1/gl.h>

typedef enum {
	kTexture2DPixelFormat_Automatic = 0,
	kTexture2DPixelFormat_RGBA8888,
	kTexture2DPixelFormat_RGB565,
	kTexture2DPixelFormat_A8,
} Texture2DPixelFormat;



@interface Texture2D : NSObject {
	
@private
	
	GLuint name;
	CGSize contentSize;
	NSUInteger width;
	NSUInteger height;
	GLfloat maxS;
	GLfloat maxT;
	CGSize textureRatio;
	Texture2DPixelFormat pixelFormat;
}

@property (nonatomic, readonly) GLuint name;
@property (nonatomic, readonly) CGSize contentSize;
@property (nonatomic, readonly) NSUInteger width;
@property (nonatomic, readonly) NSUInteger height;
@property (nonatomic, readonly) GLfloat maxS;
@property (nonatomic, readonly) GLfloat maxT;
@property (nonatomic, readonly) CGSize textureRatio;
@property (nonatomic, readonly) Texture2DPixelFormat pixelFormat;

- (id) initWithImage:(UIImage *)aImage filter:(GLenum)aFilter;

@end

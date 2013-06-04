//
//  Image.h
//  TEORBattleTest
//
//  Created by Zach Babb on 5/21/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Global.h"

@class Texture2D;
@class TextureManager;
@class ImageRenderManager;
@class GameController;


@interface Image : NSObject {
	
	TextureManager *sharedTextureManager;
	GameController *sharedGameController;
	ImageRenderManager *sharedImageRenderManager;
	
	NSString *imageFileName;
	NSString *imageFileType;
	Texture2D *texture;
	CGSize fullTextureSize;
	CGSize textureSize;
	CGSize imageSize;
	CGSize originalImageSize;
	CGSize maxTextureSize;
	CGPoint textureOffset;
	float rotation;
	Scale2f scale;
	BOOL flipHorizontally;
	BOOL flipVertically;
	NSUInteger IVAIndex;
	GLuint textureName;
	CGPoint point;
	CGPoint rotationPoint;
	Color4f color;
	BOOL dirty;
	GLenum minMagFilter;
	CGRect subImageRectangle;
	CGSize textureRatio;
	CGPoint renderPoint;
	
	ImageDetails *imageDetails;
	float matrix[9];
	
}

@property (nonatomic, retain) NSString *imageFileName;
@property (nonatomic, retain) NSString *imageFileType;
@property (nonatomic, retain) Texture2D *texture;
@property (nonatomic, assign) CGSize fullTextureSize;
@property (nonatomic, assign) CGSize textureSize;
@property (nonatomic, assign) CGSize textureRatio;
@property (nonatomic, assign) CGSize maxTextureSize;
@property (nonatomic, assign) NSUInteger IVAIndex;
@property (nonatomic, assign) GLuint textureName;
@property (nonatomic, assign) GLenum minMagFilter;
@property (nonatomic, assign) ImageDetails *imageDetails;
@property (nonatomic, assign) CGSize imageSize;
@property (nonatomic, assign) CGPoint textureOffset;
@property (nonatomic, assign) float rotation;
@property (nonatomic, assign) Scale2f scale;
@property (nonatomic, assign) BOOL flipHorizontally;
@property (nonatomic, assign) BOOL flipVertically;
@property (nonatomic, assign) CGPoint point;
@property (nonatomic, assign) Color4f color;
@property (nonatomic, assign) CGPoint rotationPoint;
@property (nonatomic, assign) CGRect subImageRectangle;
@property (nonatomic, assign) CGPoint renderPoint;

- (id)initWithImageNamed:(NSString *)aName filter:(GLenum)aFilter;

- (id)initWithImageNamed:(NSString *)aName filter:(GLenum)aFilter subTexture:(CGRect)aSubTexture;

- (Image *)subImageInRect:(CGRect)aRect;

- (Image *)imageDuplicate;

- (void)setImageSizeToRender:(CGSize)aImageSize;

- (void)render;

- (void)renderAtPoint:(CGPoint)aPoint;

- (void)renderAtPoint:(CGPoint)aPoint scale:(Scale2f)aScale rotation:(float)aRotation;

- (void)renderCentered;

- (void)renderCenteredAtPoint:(CGPoint)aPoint;

- (void)renderCenteredAtPoint:(CGPoint)aPoint scale:(Scale2f)aScale rotation:(float)aRotation;

@end

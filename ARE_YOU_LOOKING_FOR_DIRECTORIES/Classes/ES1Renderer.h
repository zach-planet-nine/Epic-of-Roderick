//
//  ES1Renderer.h
//  TEORBattleTest
//
//  Created by Zach Babb on 5/21/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "ESRenderer.h"

#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

@class GameController;

@interface ES1Renderer : NSObject <ESRenderer>
{
@private
    EAGLContext *context;
	
    // The pixel dimensions of the CAEAGLLayer
    GLint backingWidth;
    GLint backingHeight;
	
    // The OpenGL ES names for the framebuffer and renderbuffer used to render to this view
    GLuint defaultFramebuffer, colorRenderbuffer;
	
	GameController *sharedGameController;
}

- (void)render;
- (BOOL)resizeFromLayer:(CAEAGLLayer *)layer;

@end

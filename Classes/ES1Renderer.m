//
//  ES1Renderer.m
//  TEORBattleTest
//
//  Created by Zach Babb on 5/21/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "ES1Renderer.h"
#import "GameController.h"

@interface ES1Renderer (Private)

- (void)initOpenGL;
@end


@implementation ES1Renderer

// Create an OpenGL ES 1.1 context
- (id)init
{
    if ((self = [super init]))
    {
        context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
		
        if (!context || ![EAGLContext setCurrentContext:context])
        {
            [self release];
            return nil;
        }
		
        // Create default framebuffer object. The backing will be allocated for the current layer in -resizeFromLayer
        glGenFramebuffersOES(1, &defaultFramebuffer);
        glGenRenderbuffersOES(1, &colorRenderbuffer);
        glBindFramebufferOES(GL_FRAMEBUFFER_OES, defaultFramebuffer);
        glBindRenderbufferOES(GL_RENDERBUFFER_OES, colorRenderbuffer);
        glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_COLOR_ATTACHMENT0_OES, GL_RENDERBUFFER_OES, colorRenderbuffer);
		sharedGameController = [GameController sharedGameController];
    }
	
    return self;
}

- (void)render
{
	glClear(GL_COLOR_BUFFER_BIT);
	
	[sharedGameController renderCurrentScene];
	
	[context presentRenderbuffer:GL_RENDERBUFFER_OES];
    /*CGContextRef context2 = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context2, [UIColor colorWithRed:0.0f green:1.0f blue:0.0f alpha:1.0f].CGColor);
    CGContextSetFillColorWithColor(context2, [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:1.0f].CGColor);
    CGContextAddRect(context2, CGRectMake(50, 50, 10, 50));
    CGContextFillPath(context2);
    CGContextSaveGState(context2);
    CGContextSetShadowWithColor(context2, CGSizeZero, 2.0f, [UIColor colorWithRed:0.0f green:1.0f blue:0.0f alpha:1.0f].CGColor);
    CGContextTranslateCTM(context2, 100, 100);
    CGContextRotateCTM(context2, 0.15f);
    CGContextScaleCTM(context2, 1.0f, 1.0f);
    CGContextSetLineWidth(context2, 3.0f);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 54.0f, 50.0f);
    CGPathAddLineToPoint(path, NULL, 54.0f, 100.0f);
    CGContextAddPath(context2, path);
    CGContextStrokePath(context2);*/
}

- (BOOL)resizeFromLayer:(CAEAGLLayer *)layer
{	
    // Allocate color buffer backing based on the current layer size
    glBindRenderbufferOES(GL_RENDERBUFFER_OES, colorRenderbuffer);
    [context renderbufferStorage:GL_RENDERBUFFER_OES fromDrawable:layer];
    glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_WIDTH_OES, &backingWidth);
    glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_HEIGHT_OES, &backingHeight);
	
    if (glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES) != GL_FRAMEBUFFER_COMPLETE_OES)
    {
        //NSLog(@"Failed to make complete framebuffer object %x", glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES));
        return NO;
    }
	
	[self initOpenGL];
	
    return YES;
}

- (void)dealloc
{
    // Tear down GL
    if (defaultFramebuffer)
    {
        glDeleteFramebuffersOES(1, &defaultFramebuffer);
        defaultFramebuffer = 0;
    }
	
    if (colorRenderbuffer)
    {
        glDeleteRenderbuffersOES(1, &colorRenderbuffer);
        colorRenderbuffer = 0;
    }
	
    // Tear down context
    if ([EAGLContext currentContext] == context)
        [EAGLContext setCurrentContext:nil];
	
    [context release];
    context = nil;
	
    [super dealloc];
}

@end

@implementation ES1Renderer (Private)

-(void) initOpenGL {
	
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	
	glOrthof(0, backingWidth, 0, backingHeight, -1, 1);
	
	glViewport(0, 0, backingWidth, backingHeight);
	
	glMatrixMode(GL_MODELVIEW);
	glLoadIdentity();
	
	glTexEnvi(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_ALPHA);
	
	glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
	
	glDisable(GL_DEPTH_TEST);
	
	glEnableClientState(GL_VERTEX_ARRAY);
	glEnableClientState(GL_COLOR_ARRAY);
	glEnable(GL_TEXTURE_2D);
	
	glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
	glEnableClientState(GL_TEXTURE_COORD_ARRAY);
	glEnable(GL_BLEND);
	
	glLoadIdentity();
	glTranslatef(160, 240, 0);
	glRotatef(270, 0, 0, 1);
	glTranslatef(-240, -160, 0);
}

@end

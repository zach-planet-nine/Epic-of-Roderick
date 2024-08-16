//
//  EAGLView.m
//  TEORBattleTest
//
//  Created by Zach Babb on 5/21/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "EAGLView.h"

#import "ES1Renderer.h"
#import "GameController.h"
#import "InputManager.h"
#import "AbstractScene.h"

@implementation EAGLView

@synthesize animating;
@dynamic animationFrameInterval;

// You must implement this method
+ (Class)layerClass
{
    return [CAEAGLLayer class];
}

//The EAGL view is stored in the nib file. When it's unarchived it's sent -initWithCoder:
- (id)initWithCoder:(NSCoder*)coder
{    
    if ((self = [super initWithCoder:coder]))
    {
        // Get the layer
        CAEAGLLayer *eaglLayer = (CAEAGLLayer *)self.layer;
		
        eaglLayer.opaque = TRUE;
        eaglLayer.drawableProperties = [NSDictionary dictionaryWithObjectsAndKeys:
                                        [NSNumber numberWithBool:FALSE], kEAGLDrawablePropertyRetainedBacking, kEAGLColorFormatRGBA8, kEAGLDrawablePropertyColorFormat, nil];
		
		renderer = [[ES1Renderer alloc] init];
		
		if (!renderer)
		{
			[self release];
			return nil;
		}
        
		
        animating = FALSE;
        displayLinkSupported = FALSE;
        animationFrameInterval = 1;
        displayLink = nil;
        animationTimer = nil;
		
		[self setMultipleTouchEnabled:YES];
		
        // A system version of 3.1 or greater is required to use CADisplayLink. The NSTimer
        // class is used as fallback when it isn't available.
        NSString *reqSysVer = @"3.1";
        NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
        if ([currSysVer compare:reqSysVer options:NSNumericSearch] != NSOrderedAscending)
            displayLinkSupported = TRUE;
		sharedGameController = [GameController sharedGameController];
		sharedInputManager = [InputManager sharedInputManager];
		UIPinchGestureRecognizer *pgr = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(thereWasAPinch:)];
		pgr.cancelsTouchesInView = NO;
		pgr.delaysTouchesBegan = NO;
		pgr.delaysTouchesEnded = NO;
		[self addGestureRecognizer:pgr];
		[pgr release];
    }
	
    return self;
}

#define MAXIMUM_FRAME_RATE 45
#define MINIMUM_FRAME_RATE 15
#define UPDATE_INTERVAL (1.0 / MAXIMUM_FRAME_RATE)
#define MAX_CYCLES_PER_FRAME (MAXIMUM_FRAME_RATE / MINIMUM_FRAME_RATE)

- (void)gameLoop {
	
	static double lastFrameTime = 0.0f;
	static double cyclesLeftOver = 0.0f;
	double currentTime;
	double updateIterations;
	
	currentTime = CACurrentMediaTime();
	updateIterations = ((currentTime - lastFrameTime) + cyclesLeftOver);
	
	if(updateIterations > (MAX_CYCLES_PER_FRAME * UPDATE_INTERVAL))
		updateIterations = (MAX_CYCLES_PER_FRAME * UPDATE_INTERVAL);
	
	while (updateIterations >= UPDATE_INTERVAL) {
		updateIterations -= UPDATE_INTERVAL;
		
		[sharedGameController updateCurrentSceneWithDelta:UPDATE_INTERVAL];
	}
	
	cyclesLeftOver = updateIterations;
	lastFrameTime = currentTime;
	
	[self drawView:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation = UIInterfaceOrientationLandscapeRight);
}

- (void)drawView:(id)sender
{
    [renderer render];
    
}

- (void)layoutSubviews
{
    [renderer resizeFromLayer:(CAEAGLLayer*)self.layer];
    [self drawView:nil];
}

- (NSInteger)animationFrameInterval
{
    return animationFrameInterval;
}

- (void)setAnimationFrameInterval:(NSInteger)frameInterval
{
    // Frame interval defines how many display frames must pass between each time the
    // display link fires. The display link will only fire 30 times a second when the
    // frame internal is two on a display that refreshes 60 times a second. The default
    // frame interval setting of one will fire 60 times a second when the display refreshes
    // at 60 times a second. A frame interval setting of less than one results in undefined
    // behavior.
    if (frameInterval >= 1)
    {
        animationFrameInterval = frameInterval;
		
        if (animating)
        {
            [self stopAnimation];
            [self startAnimation];
        }
    }
}

- (void)startAnimation
{
    if (!animating)
    {
        if (displayLinkSupported)
        {
            // CADisplayLink is API new to iPhone SDK 3.1. Compiling against earlier versions will result in a warning, but can be dismissed
            // if the system version runtime check for CADisplayLink exists in -initWithCoder:. The runtime check ensures this code will
            // not be called in system versions earlier than 3.1.
			
            displayLink = [NSClassFromString(@"CADisplayLink") displayLinkWithTarget:self selector:@selector(gameLoop)];
            [displayLink setFrameInterval:animationFrameInterval];
            [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        }
        else
            animationTimer = [NSTimer scheduledTimerWithTimeInterval:(NSTimeInterval)((1.0 / 60.0) * animationFrameInterval) target:self selector:@selector(gameLoop) userInfo:nil repeats:TRUE];
		
        animating = TRUE;
		lastTime = CFAbsoluteTimeGetCurrent();
    }
}

- (void)stopAnimation
{
    if (animating)
    {
        if (displayLinkSupported)
        {
            [displayLink invalidate];
            displayLink = nil;
        }
        else
        {
            [animationTimer invalidate];
            animationTimer = nil;
        }
		
        animating = FALSE;
    }
}

/*- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	
	[[sharedGameController currentScene] touchesBegan:touches withEvent:event view:self];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	
	[[sharedGameController currentScene] touchesMoved:touches withEvent:event view:self];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	
	[[sharedGameController currentScene] touchesEnded:touches withEvent:event view:self];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
	
	[[sharedGameController currentScene] touchesCancelled:touches withEvent:event view:self];
}*/

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	
	[sharedInputManager touchesBegan:touches withEvent:event view:self];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	
	[sharedInputManager touchesMoved:touches withEvent:event view:self];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	
	[sharedInputManager touchesEnded:touches withEvent:event view:self];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
	
	[sharedInputManager touchesCancelled:touches withEvent:event view:self];
}

- (void)thereWasAPinch:(UIPinchGestureRecognizer *)aGestureRecognizer {
    if (sharedGameController.gameState == kGameState_Battle) {
        return;
    }
	CGPoint pinchLocation = [sharedGameController adjustTouchOrientationForTouch:[aGestureRecognizer locationInView:self]];
		//NSLog(@"Pinch scale? %f", aGestureRecognizer.scale);
	if (aGestureRecognizer.scale > 1.8 && 130 < pinchLocation.y < 190 && sharedInputManager.state != kWalkingAround_BothSidesDown) {
		[sharedInputManager thereWasAPinchOpen];
	} else if (aGestureRecognizer.scale < 1 && 130 < pinchLocation.y < 190 && sharedInputManager.state != kWalkingAround_BothSidesDown) {
		[sharedInputManager thereWasAPinchClose];
	}
}

- (void)dealloc
{
    [renderer release];
	
    [super dealloc];
}

@end

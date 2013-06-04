//
//  TEORWorldMapTestAppDelegate.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 5/26/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "TEORWorldMapTestAppDelegate.h"
#import "EAGLView.h"
#import "GameController.h"
#import "AbstractScene.h"

@implementation TEORWorldMapTestAppDelegate

@synthesize window;
@synthesize glView;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    //Adding a line to test Xcode's integration with github.
    // Override point for customization after application launch.
    
	[glView startAnimation];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
	
	[glView stopAnimation];
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
	
	[glView startAnimation];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    
	[glView stopAnimation];
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
    NSLog(@"You received a memory warning.");
    NSLog(@"With %d objects and %d entities.", [[GameController sharedGameController].currentScene.activeObjects count], [[GameController sharedGameController].currentScene.activeEntities count]);
}


- (void)dealloc {
    [window release];
	[glView release];
    [super dealloc];
}


@end

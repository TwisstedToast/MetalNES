
#import "AppDelegate.h"
#import "RenderViewControllerOSX.h"

#import <AVFoundation/AVFoundation.h>
#include <string>

#import <GLKit/GLKit.h>

#include "Core/Path.h"
#include <pthread.h>
#include "Application.h"

void SetCurrentThreadName(const char* threadName)
{
;
    [[NSThread currentThread] setName:    [NSString stringWithUTF8String:threadName] ]; // For Cocoa
    pthread_setname_np(threadName); // For GDB.
}


@implementation AppDelegate

{
    RenderViewControllerOSX *_viewController;
}

- (void)applicationWillFinishLaunching:(NSNotification *)notification
{
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
#ifndef NDEBUG
    NSLog(@"AppDelegate::applicationDidFinishLaunching");
#endif
    NSRect frame = NSMakeRect(0, 0, 1280, 720);
    NSUInteger styleMask = NSWindowStyleMaskTitled
        | NSWindowStyleMaskClosable
        | NSWindowStyleMaskMiniaturizable
        | NSWindowStyleMaskResizable;

    self.window = [[NSWindow alloc] initWithContentRect:frame
                                              styleMask:styleMask
                                                backing:NSBackingStoreBuffered
                                                  defer:NO];
    [self.window setTitle:@"MetalNes"];
    [self.window center];

    _viewController = [[RenderViewControllerOSX alloc] init];
    _viewController.launchArgs = self.launchArgs;
    (void)_viewController.view;
#ifndef NDEBUG
    NSLog(@"AppDelegate loaded content view %@", _viewController.view);
#endif
    [self.window setContentViewController:_viewController];
    [self.window makeKeyAndOrderFront:nil];
    [NSApp activateIgnoringOtherApps:YES];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    AppShutdown();
}

- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)app {
    return NSTerminateNow;
}

- (BOOL) applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender
{
    return YES;
}


-(IBAction)saveState:(id)sender
{
    
}
-(IBAction)loadState:(id)sender
{
    
}



@end

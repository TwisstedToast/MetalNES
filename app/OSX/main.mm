
#import <Cocoa/Cocoa.h>

#include "UnitTests.h"
#import "AppDelegate.h"

static AppDelegate *s_app_delegate;

int main(int argc, const char * argv[])
{
    if (argc >=2 ) {
        if (strcmp(argv[1], "runtests") == 0)
        {
            UnitTestsSetArgs(argc, argv);
            return RunUnitTests();
        }
    }

    @autoreleasepool
    {
        NSApplication *app = [NSApplication sharedApplication];
        s_app_delegate = [[AppDelegate alloc] init];
        NSMutableArray<NSString *> *launchArgs = [NSMutableArray array];
        for (int i = 1; i < argc; i++)
        {
            [launchArgs addObject:[NSString stringWithUTF8String:argv[i]]];
        }
        s_app_delegate.launchArgs = launchArgs;
        [app setActivationPolicy:NSApplicationActivationPolicyRegular];
        [app setDelegate:s_app_delegate];
        [app run];
    }
    return 0;
}

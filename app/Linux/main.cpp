
#include <assert.h>
#include <stdio.h>
#include <sys/stat.h>
#include <sys/types.h>
#include "Core/File.h"

#if __linux__ || __APPLE__
#include <pthread.h>
#endif

#include "Application.h"
#include "imgui_support.h"
#include "../external/imgui/imgui.h"


void SetCurrentThreadName(const char* threadName)
{
#if __linux__
    pthread_setname_np(pthread_self(), threadName); // For GDB.
#elif __APPLE__
    pthread_setname_np(threadName); // For GDB.
#endif
}



int main(int argc, const char *argv[])
{
	std::string _resourceDir = "./";
	std::string _userDir = ".metalnes/";
    render::ContextPtr _context = nullptr;

    Core::Directory::Create(_userDir);

    
    std::vector<std::string> args;
    for (int i=1; i < argc; i++)
    {
        args.push_back(std::string(argv[i]));
    }

#if __APPLE__
    if (!_context)
    {
        fprintf(stderr, "MetalNes: no render context is created in app/Linux/main.cpp on macOS. Build the Cocoa app path instead.\n");
        return 1;
    }
#endif

    AppInit(_context, _resourceDir, _userDir, args);

    while (!AppShouldQuit())
    {
    	AppRender(_context);
    }

    AppShutdown();
	return 0;
	
}

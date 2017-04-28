@import Foundation;
@import XPCSupport;
#import <StringManipulation-Swift.h>

int main(int argc, const char *argv[])
{
    ServiceDelegate *delegate = [ServiceDelegate new];
    NSXPCListener *listener = [NSXPCListener serviceListener];
    listener.delegate = delegate;
    
    [listener resume];
    return 0;
}

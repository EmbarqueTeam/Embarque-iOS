//
// MXGoogleAnalytics.h
//
// Copyright (c) 2013-2014 MXGoogleAnalytics
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "MXGoogleAnalytics.h"
#import "GAI.h"
#import "GAIFields.h"
#import "GAIDictionaryBuilder.h"

@implementation MXGoogleAnalytics

+ (void)ga_inicializeWithTrackingId:(NSString *)trackingId
{
    // Optional: automatically send uncaught exceptions to Google Analytics.
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    // Optional: set Google Analytics dispatch interval to e.g. 20 seconds.
    [GAI sharedInstance].dispatchInterval = 20;
    // Optional: set Logger to VERBOSE for debug information.
    [[[GAI sharedInstance] logger] setLogLevel:kGAILogLevelError];
    // Initialize tracker. Replace with your tracking ID.
    [[GAI sharedInstance] trackerWithTrackingId:trackingId];
}

+ (void)ga_allowIDFACollection:(BOOL)allow
{
    /*Para ativar recursos de publicidade gráfica para iOS, colete o identificador para anunciantes (IDFA, na sigla em inglês). Para ativar a coleta do IDFA, vincule as bibliotecas libAdIdAccess.a e AdSupport.framework ao seu aplicativo e defina allowIDFACollection como YES em cada acompanhador que coletará o IDFA.*/
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    
    [tracker setAllowIDFACollection:allow];
}

#pragma mark - Application
+ (void)ga_trackApplicationLauchingWithOptions:(NSDictionary *)launchOptions
{
    NSDictionary *userInfoRemote = [launchOptions objectForKey: UIApplicationLaunchOptionsRemoteNotificationKey];
    
    if (userInfoRemote != nil ){
        [MXGoogleAnalytics ga_trackEventWith:@"Launch" action:@"Remote"];
    }else{
        NSDictionary *userInfoLocal = [launchOptions objectForKey: UIApplicationLaunchOptionsLocalNotificationKey];
        if (userInfoLocal != nil ){
            [MXGoogleAnalytics ga_trackEventWith:@"Launch" action:@"Local"];
        }else{
            [MXGoogleAnalytics ga_trackEventWith:@"Launch" action:@"Organic"];
        }
    }
}

#pragma mark - Screen
+ (void)ga_trackScreen:(NSString *)screen
{
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    
    // This screen name value will remain set on the tracker and sent with
    // hits until it is set to a new value or to nil.
    [tracker set:kGAIScreenName
           value:screen];
    
    // Previous V3 SDK versions
    //[tracker send:[[GAIDictionaryBuilder createAppView] build]];
    
    // New SDK versions
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
}

#pragma mark - Event
+ (void)ga_trackEventWith:(NSString *)category action:(NSString *)action label:(NSString *)label value:(NSNumber *)value
{
    // May return nil if a tracker has not already been initialized with a property
    // ID.
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:category     // Event category (required)
                                                          action:action  // Event action (required)
                                                           label:label          // Event label
                                                           value:value] build]];    // Event value
}

+ (void)ga_trackEventWith:(NSString *)category action:(NSString *)action label:(NSString *)label
{
    [MXGoogleAnalytics ga_trackEventWith:category action:action label:label value:nil];
}

+ (void)ga_trackEventWith:(NSString *)category action:(NSString *)action
{
    [MXGoogleAnalytics ga_trackEventWith:category action:action label:@"" value:nil];
}
@end

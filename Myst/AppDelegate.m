//
//  AppDelegate.m
//  DiamondTrade
//
//  Created by Vipul Jikadra on 08/09/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import "AppDelegate.h"
#import "UtilityMethods.h"
#import "Database.h"

#define SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@import Firebase;
@import FirebaseInstanceID;
@import FirebaseMessaging;

@interface AppDelegate ()
{
    
}
@end
@implementation AppDelegate
@synthesize vcContainerViewController,navigationController,window;
    
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
        // Override point for customization after application launch.
        
//                for (NSString *familyName in [UIFont familyNames]){
//                    NSLog(@"Family name: %@", familyName);
//                    for (NSString *fontName in [UIFont fontNamesForFamilyName:familyName])
//                    {
//                        NSLog(@"--Font name: %@", fontName);
//                    }
//                }
    
     [Fabric with:@[[Crashlytics class]]];
        
        [[Database sharedDatabase] deleteRowFromNotification:@""];
        _datapass = [[NSMutableDictionary alloc]init];
        
        [self copyDatabaseIfNeeded];
        
        _filterDict= [[NSMutableDictionary alloc]init];
        window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        vcContainerViewController = [[ContainerViewController alloc] initWithNibName:@"ContainerViewController" bundle:nil];
        
        UserInfo * ob = (UserInfo *) [obNet getUserInfoObject];
        if (IsObNotNil(ob))
        {
            vcContainerViewController.newVC = VC_TutorialPage;
        }
        else
        {
            vcContainerViewController.newVC = VC_TutorialPage;
        }
    
        //AddNewCard * vc = [[AddNewCard alloc] initWithNibName:@"AddNewCard" bundle:nil];
        navigationController = [[UINavigationController alloc] initWithRootViewController:vcContainerViewController];
        
        navigationController.navigationBarHidden = YES;
        
        window.rootViewController = navigationController;
        [window makeKeyAndVisible];
    
        return YES;
    }
- (void) copyDatabaseIfNeeded
{
    //Using NSFileManager we can perform many file system operations.
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    
    NSString *dbPath = [UtilityMethods getDBPath];
    BOOL success = [fileManager fileExistsAtPath:dbPath];
    
    if(!success)
    {
        
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"DtradeDB.sqlite"];
        success = [fileManager copyItemAtPath:defaultDBPath toPath:dbPath error:&error];
        
        if (!success)
        NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
    }
}

- (void)applicationWillResignActive:(UIApplication *)application
    {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
- (void)applicationDidEnterBackground:(UIApplication *)application
    {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
- (void)applicationWillEnterForeground:(UIApplication *)application
    {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
- (void)applicationDidBecomeActive:(UIApplication *)application
    {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
       
        
    }
    
- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
    
    @end

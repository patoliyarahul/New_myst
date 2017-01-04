//
//  AppDelegate.m
//  DiamondTrade
//
//  Created by Vipul Jikadra on 08/09/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import "AppDelegate.h"
#import "UtilityMethods.h"


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
    
    [Fabric with:@[[Crashlytics class]]];
    
    _datapass = [[NSMutableDictionary alloc]init];
    _packages = [[NSMutableDictionary alloc]init];
    _intructions = [[NSMutableDictionary alloc]init];
    _PackagePrice =[[NSMutableDictionary alloc] init];
    _locationDict = [[NSMutableDictionary alloc]init];
    _CardDetail = [[NSMutableDictionary alloc] init];
    
    window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    vcContainerViewController = [[ContainerViewController alloc] initWithNibName:@"ContainerViewController" bundle:nil];
    
    UserInfo * ob = (UserInfo *) [obNet getUserInfoObject];
    if (IsObNotNil(ob))
    {
        vcContainerViewController.newVC = VC_HomePage;
    }
    else
    {
        vcContainerViewController.newVC = VC_TutorialPage;
    }
    
    navigationController = [[UINavigationController alloc] initWithRootViewController:vcContainerViewController];
    
    navigationController.navigationBarHidden = YES;
    
    window.rootViewController = navigationController;
    
    [window makeKeyAndVisible];
    
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_9_x_Max) {
        UIUserNotificationType allNotificationTypes =
        (UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings =
        [UIUserNotificationSettings settingsForTypes:allNotificationTypes categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    } else {
        // iOS 10 or later
#if defined(__IPHONE_10_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
        UNAuthorizationOptions authOptions =
        UNAuthorizationOptionAlert
        | UNAuthorizationOptionSound
        | UNAuthorizationOptionBadge;
        [[UNUserNotificationCenter currentNotificationCenter]
         requestAuthorizationWithOptions:authOptions
         completionHandler:^(BOOL granted, NSError * _Nullable error) {
         }
         ];
        
        // For iOS 10 display notification (sent via APNS)
        [[UNUserNotificationCenter currentNotificationCenter] setDelegate:self];
        // For iOS 10 data message (sent via FCM)
        //   [[FIRMessaging messaging] setRemoteMessageDelegate:self];
#endif
    }
    
    
    [[UIApplication sharedApplication] registerForRemoteNotifications];    // [START configure_firebase]
    [FIRApp configure];
    // [END configure_firebase]
    
    // Add observer for InstanceID token refresh callback.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tokenRefreshNotification:)
                                                 name:kFIRInstanceIDTokenRefreshNotification object:nil];
    
    NSString *token = [[FIRInstanceID instanceID] token];

    
        return YES;
}
#define iOS10 Delegate method

//Called when a notification is delivered to a foreground app.
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler{
    NSLog(@"User Info : %@",notification.request.content.userInfo);
    completionHandler(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge);
}

//Called to let your app know which action was selected by the user for a given notification.
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler{
    NSLog(@"User Info : %@",response.notification.request.content.userInfo);
    completionHandler();
    
//    NSDateFormatter *formatter;
//    NSString        *dateString;
//    
//    formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"dd-MM-yyyy hh:mm a"];
//    
//    dateString = [formatter stringFromDate:[NSDate date]];
//    
//    
//    if ([[[[response.notification.request.content.userInfo valueForKey:@"aps"] valueForKey:@"alert"] valueForKey:@"type"] integerValue] == 2 )
//    {
//        
//        [[Database sharedDatabase]Insert_Record:[[[response.notification.request.content.userInfo valueForKey:@"aps"] valueForKey:@"alert"] valueForKey:@"type"] category_image:[[[response.notification.request.content.userInfo valueForKey:@"aps"] valueForKey:@"alert"] valueForKey:@"category_image"] image_path:[[[response.notification.request.content.userInfo valueForKey:@"aps"] valueForKey:@"alert"] valueForKey:@"image_path"] message:[[[response.notification.request.content.userInfo valueForKey:@"aps"] valueForKey:@"alert"] valueForKey:@"message"] category_id:[[[response.notification.request.content.userInfo valueForKey:@"aps"] valueForKey:@"alert"] valueForKey:@"Category_Id"] subcat_name:[[[response.notification.request.content.userInfo valueForKey:@"aps"] valueForKey:@"alert"] valueForKey:@"subcat_name"] subcategory_id:[[[response.notification.request.content.userInfo valueForKey:@"aps"] valueForKey:@"alert"] valueForKey:@"subCatId"] date:dateString];
//    }
//    else
//    {
//        [[Database sharedDatabase]Insert_Record:[[[response.notification.request.content.userInfo valueForKey:@"aps"] valueForKey:@"alert"] valueForKey:@"type"] category_image:@"" image_path:@"" message:[[[response.notification.request.content.userInfo valueForKey:@"aps"] valueForKey:@"alert"] valueForKey:@"title"] category_id:@"" subcat_name:@"" subcategory_id:@"" date:dateString];
//    }
//    
//    UIApplication *application;
//    
//    UIApplicationState state = [application applicationState];
//    if (state == UIApplicationStateActive)
//    {
//        if ([[[[response.notification.request.content.userInfo valueForKey:@"aps"] valueForKey:@"alert"] valueForKey:@"type"] integerValue] == 2 )
//        {
//            [vcContainerViewController addCustomPopupNoti:[[[response.notification.request.content.userInfo valueForKey:@"aps"] valueForKey:@"alert"] valueForKey:@"body"] imagepath:[[[response.notification.request.content.userInfo valueForKey:@"aps"] valueForKey:@"alert"] valueForKey:@"image_path"] category_image:[[[response.notification.request.content.userInfo valueForKey:@"aps"] valueForKey:@"alert"] valueForKey:@"category_image"] category_id:[[[response.notification.request.content.userInfo valueForKey:@"aps"] valueForKey:@"alert"] valueForKey:@"Category_Id"] subcat_name:[[[response.notification.request.content.userInfo valueForKey:@"aps"] valueForKey:@"alert"] valueForKey:@"subcat_name"] subcategory_id:[[[response.notification.request.content.userInfo valueForKey:@"aps"] valueForKey:@"alert"] valueForKey:@"subCatId"] dict:[[response.notification.request.content.userInfo valueForKey:@"aps"] valueForKey:@"alert"]];
//        }
//        else
//        {
//            [vcContainerViewController addCustomPopup:[NSString stringWithFormat:@"%@ ",[[[response.notification.request.content.userInfo valueForKey:@"aps"] valueForKey:@"alert"] valueForKey:@"body"]]];
//        }
//        
//    }
//    else if (state == UIApplicationStateInactive)
//    {
//        if ([[[[response.notification.request.content.userInfo valueForKey:@"aps"] valueForKey:@"alert"] valueForKey:@"type"] integerValue] == 2 )
//        {
//            [vcContainerViewController addCustomPopupNoti:[[[response.notification.request.content.userInfo valueForKey:@"aps"] valueForKey:@"alert"] valueForKey:@"body"] imagepath:[[[response.notification.request.content.userInfo valueForKey:@"aps"] valueForKey:@"alert"] valueForKey:@"image_path"] category_image:[[[response.notification.request.content.userInfo valueForKey:@"aps"] valueForKey:@"alert"] valueForKey:@"category_image"] category_id:[[[response.notification.request.content.userInfo valueForKey:@"aps"] valueForKey:@"alert"] valueForKey:@"Category_Id"] subcat_name:[[[response.notification.request.content.userInfo valueForKey:@"aps"] valueForKey:@"alert"] valueForKey:@"subcat_name"] subcategory_id:[[[response.notification.request.content.userInfo valueForKey:@"aps"] valueForKey:@"alert"] valueForKey:@"subCatId"] dict:[[response.notification.request.content.userInfo valueForKey:@"aps"] valueForKey:@"alert"]];
//        }
//        else
//        {
//            [vcContainerViewController addCustomPopup:[NSString stringWithFormat:@"%@ ",[[[response.notification.request.content.userInfo valueForKey:@"aps"] valueForKey:@"alert"] valueForKey:@"body"]]];
//        }
//    }
    
}
- (void)tokenRefreshNotification:(NSNotification *)notification
{
    // Note that this callback will be fired everytime a new token is generated, including the first
    // time. So if you need to retrieve the token as soon as it is available this is where that
    // should be done.
    NSString *refreshedToken = [[FIRInstanceID instanceID] token];
    NSLog(@"InstanceID token: %@", refreshedToken);
    
    // Connect to FCM since connection may have failed when attempted before having a token.
    [self connectToFcm];
    
    // TODO: If necessary send token to application server.
}
- (void)connectToFcm
{
    [[FIRMessaging messaging] connectWithCompletion:^(NSError * _Nullable error)
     {
         if (error != nil)
         {
             NSLog(@"Unable to connect to FCM. %@", error);
         }
         else
         {
             NSLog(@"Connected to FCM.");
         }
     }];
}

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [[FIRInstanceID instanceID] setAPNSToken:deviceToken
                                        type:FIRInstanceIDAPNSTokenTypeSandbox];
    NSString* newToken = [deviceToken description];
    newToken = [newToken stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    newToken = [newToken stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"token:: %@",newToken);
    
    _TokenId = newToken;
    
//    UserInfo * ob = (UserInfo *) [obNet getUserInfoObject];
//    if (IsObNotNil(ob))
//    {
//        NSMutableDictionary * mD = [NSMutableDictionary new];
//        mD[@"Id"] = [ob valueForKey:@"Id"];
//        mD[@"Fcm_Id"] = KAppDelegate.TokenId;
//        
//        [obNet JSONFromWebServices:Fcmregistration Parameter:mD Method:@"POST" AI:YES PopUP:YES Caller:CALLER WithBlock:^(id json)
//         {
//             if (IsObNotNil(json))
//             {
//                 // ToastMSG(json[@"message"]);
//                 
//             }
//             
//         }];
//        
//    }
//    else
//    {
//        
//    }
}

- (void)application:(UIApplication *)application
didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"Registration for remote notification failed with error: %@", error.localizedDescription);
    // [END receive_apns_token_error]
    NSDictionary *userInfo = @{@"error" :error.localizedDescription};
    [[NSNotificationCenter defaultCenter] postNotificationName:_registrationKey
                                                        object:nil
                                                      userInfo:userInfo];
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
    [self connectToFcm];
    
}
    
- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
    
    @end

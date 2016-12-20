//
//  AppDelegate.h
//  DiamondTrade
//
//  Created by Vipul Jikadra on 07/10/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfo.h"
#import "ContainerViewController.h"
#import <UserNotifications/UserNotifications.h>

#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>
@import Firebase;
@protocol CustomPopupDelegate <NSObject>
- (void) addCustomPopup:(NSString *) msg;
    @end

@interface AppDelegate : UIResponder <UIApplicationDelegate,UNUserNotificationCenterDelegate>
    
@property (strong, nonatomic) ContainerViewController * vcContainerViewController;
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController * navigationController;

@property (strong, nonatomic) UserInfo * userInfo;
@property int sortByUpORDown;
@property int sortByFavRating;
- (void) resetSortingParameter;
@property (strong, nonatomic) id <CustomPopupDelegate> delegate;
- (void) pushTesthd;
@property(nonatomic) NSString *catImage;
@property(nonatomic) int index;
@property(nonatomic) NSMutableDictionary *filterDict;
@property(nonatomic) BOOL ClearFire;
@property(nonatomic, readonly, strong) NSString *registrationKey;
@property(nonatomic, readonly, strong) NSString *messageKey;
@property(nonatomic, readonly, strong) NSString *gcmSenderID;
@property(nonatomic, readonly, strong) NSDictionary *registrationOptions;

@property(nonnull)NSString *TokenId;
@property(nonnull)NSMutableDictionary *datapass;

@property(nonatomic) NSMutableDictionary *packages;
@property(nonatomic) NSMutableDictionary *intructions;
@property(nonatomic) NSMutableDictionary *PackagePrice;
@property(nonatomic) NSMutableDictionary *locationDict;
@end

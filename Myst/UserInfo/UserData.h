//
//  UserData.h
//  Myst
//
//  Created by Vipul Jikadra on 13/12/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface UserData : JSONModel
@property (nonatomic) NSString * verification_code;
@property (nonatomic) NSString * email;
@property (nonatomic) NSString * name;
@property (nonatomic) NSString * cust_id;
@property (nonatomic) NSString * phone;
@property (nonatomic) NSString * device_id;
@property (nonatomic) NSString * fcmid;
@property (nonatomic) NSString * mode;
@property (nonatomic) NSString * pushNotification;
@property (nonatomic) NSString * emailNotification;
@end

//
//  UserInfo.h
//  SaveLife
//
//  Created by animesh on 03/11/14.
//  Copyright (c) 2014 vsure. All rights reserved.
//

#import "JSONModel.h"
#import <Foundation/Foundation.h>

@interface UserInfo : JSONModel
@property(nonatomic,strong)NSString *Name;
@property(nonatomic,strong)NSString *Email;
@property (strong, nonatomic) NSString * City_Id;
@property (strong, nonatomic) NSString * Image;
@property (strong, nonatomic) NSString * Unique_Id;
@property (strong, nonatomic) NSString * Mobile;
@property (strong, nonatomic) NSString * Id;
@property (strong, nonatomic) NSString * City_Name;
- (id) init;

- (id) initWith:(UserInfo *) ob;

@end








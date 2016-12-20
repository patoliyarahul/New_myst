//
//  LocationObData.h
//  Myst
//
//  Created by Vipul Jikadra on 19/12/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface LocationObData : JSONModel
@property (nonatomic) NSString * loc_id;
@property (nonatomic) NSString * cust_id;
@property (nonatomic) NSString * loc_type;
@property (nonatomic) NSString * fullname;
@property (nonatomic) NSString * street;
@property (nonatomic) NSString * unit;
@property (nonatomic) NSString * city;
@property (nonatomic) NSString * state;
@property (nonatomic) NSString * zipcode;
@property (nonatomic) NSString * country_id;
@property (nonatomic) NSString * instruction;
@property (nonatomic) NSString * latitude;
@property (nonatomic) NSString * longitude;
@end

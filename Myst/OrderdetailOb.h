//
//  OrderdetailOb.h
//  Myst
//
//  Created by Vipul Jikadra on 31/12/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface OrderdetailOb : JSONModel
@property (nonatomic) NSString * order_total;
@property (nonatomic) NSString * exp_year;
@property (nonatomic) NSString * holder_name;
@property (nonatomic) NSString * status;
@property (nonatomic) NSString * created_on;
@property (nonatomic) NSString * country_id;
@property (nonatomic) NSString * zipcode;
@property (nonatomic) NSString * street;
@property (nonatomic) NSString * state;
@property (nonatomic) NSString * card_no;
@property (nonatomic) NSString * order_id;
@property (nonatomic) NSString * ondemand;
@property (nonatomic) NSString * cust_id;
@property (nonatomic) NSString * loc_type;
@property (nonatomic) NSString * city;
@property (nonatomic) NSString * message;
@property (nonatomic) NSString * unit;
@property (nonatomic) NSString * schedule;
@property (nonatomic) NSString * loc_id;
@property (nonatomic) NSString * cvv;
@property (nonatomic) NSString * longitude;
@property (nonatomic) NSString * instruction;
@property (nonatomic) NSString * latitude;
@property (nonatomic) NSString * pay_id;
@property (nonatomic) NSString * fullname;
@property (nonatomic) NSString * full_name;
@end

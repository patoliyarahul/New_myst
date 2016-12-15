//
//  VehicleObData.h
//  Myst
//
//  Created by Vipul Jikadra on 16/12/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface VehicleObData : JSONModel
@property (nonatomic) NSString * veh_id;
@property (nonatomic) NSString * cust_id;
@property (nonatomic) NSString * type;
@property (nonatomic) NSString * model_year;
@property (nonatomic) NSString * make;
@property (nonatomic) NSString * model;
@property (nonatomic) NSString * color;
@property (nonatomic) NSString * license_plate_no;
@end

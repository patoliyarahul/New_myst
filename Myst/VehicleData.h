//
//  VehicleData.h
//  Myst
//
//  Created by Vipul Jikadra on 15/12/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface VehicleData : JSONModel
@property (nonatomic) NSString * name;
@property (nonatomic) NSString * type_id;
@end

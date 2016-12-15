//
//  VehicleOb.h
//  Myst
//
//  Created by Vipul Jikadra on 16/12/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "Message.h"
#import "VehicleObData.h"
@interface VehicleOb : JSONModel
@property (nonatomic) int success;
@property (nonatomic) Message * message;
@property (nonatomic) NSMutableArray<VehicleObData *> *data;
@end

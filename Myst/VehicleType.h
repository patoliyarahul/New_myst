//
//  VehicleType.h
//  Myst
//
//  Created by Vipul Jikadra on 15/12/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "Message.h"
#import "VehicleData.h"
@interface VehicleType : JSONModel
@property (nonatomic) int success;
@property (nonatomic) Message * message;
@property (nonatomic) NSMutableArray<VehicleData *> *data;
@end

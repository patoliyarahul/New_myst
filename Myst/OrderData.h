//
//  OrderData.h
//  Myst
//
//  Created by Vipul Jikadra on 31/12/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "OrderdetailOb.h"
#import "OrderpackagesOb.h"
@interface OrderData : JSONModel
@property (nonatomic) OrderdetailOb *order_detail;
@property (nonatomic) NSMutableArray<OrderpackagesOb *> *order_packages;
@end

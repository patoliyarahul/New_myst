//
//  PaymentOb.h
//  Myst
//
//  Created by Vipul Jikadra on 22/12/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "PaymentData.h"
@interface PaymentOb : JSONModel
@property (nonatomic) int success;
@property (nonatomic) Message * message;
@property (nonatomic) NSMutableArray<PaymentData *> *data;
@end

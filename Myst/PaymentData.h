//
//  PaymentData.h
//  Myst
//
//  Created by Vipul Jikadra on 22/12/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface PaymentData : JSONModel
@property (nonatomic) NSString * pay_id;
@property (nonatomic) NSString * cust_id;
@property (nonatomic) NSString * holder_name;
@property (nonatomic) NSString * card_no;
@property (nonatomic) NSString * cvv;
@property (nonatomic) NSString * exp_year;
@end

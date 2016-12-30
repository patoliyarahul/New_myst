//
//  PaymentMethodPage.m
//  Myst
//
//  Created by Vipul Jikadra on 22/12/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import "PaymentMethodPage.h"
#import "PaymentCell.h"
#import "PaymentOb.h"
#import "PaymentData.h"
@interface PaymentMethodPage ()
{
    PaymentOb *pOB;
}
@end

@implementation PaymentMethodPage

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    tblPayment.hidden = YES;
    tblPayment.delegate = self;
    tblPayment.dataSource = self;
    [tblPayment registerNib:[UINib nibWithNibName:@"PaymentCell" bundle:nil] forCellReuseIdentifier:@"PaymentCell"];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSMutableDictionary * mD = [NSMutableDictionary new];
    
    UserInfo *ob = [obNet getUserInfoObject];
   
    
    mD[@"cust_id"] = ob.data.cust_id;
    [obNet JSONFromWebServices:WS_getPayment Parameter:mD Method:@"POST" AI:YES PopUP:YES Caller:CALLER WithBlock:^(id json)
     {
         if (IsObNotNil(json))
         {
             
             if ([json[@"success"] integerValue] == 1)
             {
                 NSError* err = nil;
                 pOB = [[PaymentOb alloc]initWithDictionary:json error:&err];
                 
                 if (pOB.data.count > 0)
                 {
                     tblPayment.hidden = NO;
                     [tblPayment reloadData];
                     popup.hidden = YES;
                 }
                 else
                 {
                     popup.hidden = NO;
                     tblPayment.hidden = YES;
                 }
             }
             else
             {
                 ToastMSG(json[@"message"][@"title"]);
                 popup.hidden = NO;
                 tblPayment.hidden = YES;
             }
             
         }
         else
         {
             ToastMSG(json[@"message"][@"title"]);
         }
         
     }];
   
    
}
#pragma mark TableView Delegate methods For Menu


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return pOB.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"PaymentCell";
    PaymentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[PaymentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.layer.backgroundColor = [UIColor clearColor].CGColor;
    cell.backgroundColor = [UIColor clearColor];
    
    PaymentData *obData = pOB.data[indexPath.row];
    
    NSString *code = [[obData valueForKey:@"card_no"] substringFromIndex: [[obData valueForKey:@"card_no"] length] - 4];

    cell.lblCard.text = [NSString stringWithFormat:@"Ending in %@",code];
    
    int whichCard =  [self validateCardNumber:[obData valueForKey:@"card_no"]];
    
    switch (whichCard) {
        case Visa: {
            [cell.imgCard setImage:[UIImage imageNamed:@"visa.png"]];
        }
            break;
        case Master: {
            [cell.imgCard setImage:[UIImage imageNamed:@"mastercrd.png"]];
        }
            break;
        case Express: {
            [cell.imgCard setImage:[UIImage imageNamed:@"american.png"]];
        }
            break;
        case Diners: {
            [cell.imgCard setImage:[UIImage imageNamed:@"dinersclub.png"]];
        }
            break;
        case JSB: {
            [cell.imgCard setImage:[UIImage imageNamed:@"jcb.png"]];
        }
            break;
        case Discover: {
            [cell.imgCard setImage:[UIImage imageNamed:@"discover.png"]];
        }
            break;
        case NoONe: {
            [cell.imgCard setHidden:YES];
        }
            break;
            
        default:
            break;
    }


    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PaymentData *obData = pOB.data[indexPath.row];
    [KAppDelegate.CardDetail setObject:obData forKey:[obData valueForKey:@"cust_id"]];
    [_delegate PopViewController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (int) validateCardNumber:(NSString *)cardNumber
{
    
    NSString *newString = [cardNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    newString = [cardNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    NSString * regVisa = @"^4[0-9]{12}(?:[0-9]{3})?$";
    NSString * regMaster = @"^5[1-5][0-9]{14}$";
    NSString * regExpress = @"^3[47][0-9]{13}$";
    NSString * regDiners = @"^3(?:0[0-5]|[68][0-9])[0-9]{11}$";
    NSString * regDiscover = @"^6(?:011|5[0-9]{2})[0-9]{12}$";
    NSString * regJSB = @"^(?:2131|1800|35\\d{3})\\d{11}$";
    
    NSPredicate *predicateVisa = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regVisa];
    NSPredicate *predicateMaster = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regMaster];
    NSPredicate *predicateExpress = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regExpress];
    NSPredicate *predicateDiners = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regDiners];
    NSPredicate *predicateDiscover = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regDiscover];
    NSPredicate *predicateJSB = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regJSB];
    
    if ([predicateDiners evaluateWithObject:newString]) {
        noOfCharacterInCardNumber = 14;
        return Diners;
    } else if ([predicateExpress evaluateWithObject:newString]) {
        noOfCharacterInCardNumber = 15;
        return Express;
    } else if ([predicateVisa evaluateWithObject:newString]) {
        noOfCharacterInCardNumber = 16;
        return Visa;
    } else if ([predicateMaster evaluateWithObject:newString]) {
        noOfCharacterInCardNumber = 16;
        return Master;
    } else if ([predicateDiscover evaluateWithObject:newString]) {
        noOfCharacterInCardNumber = 16;
        return Discover;
    } else if ([predicateJSB evaluateWithObject:newString]) {
        noOfCharacterInCardNumber = 16;
        return JSB;
    } else {
        noOfCharacterInCardNumber = 16;
        return NoONe;
    }
}
- (IBAction)addFire:(id)sender
{
    NSMutableDictionary *senddict = [[NSMutableDictionary alloc] init];
    [senddict setObject:@"PaymentMethodPage" forKey:@"From"];
    [_delegate Push:VC_AddPaymentPage Data:senddict];
}
@end

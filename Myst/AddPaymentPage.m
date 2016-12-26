//
//  AddPaymentPage.m
//  Myst
//
//  Created by Vipul Jikadra on 21/12/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import "AddPaymentPage.h"

@interface AddPaymentPage ()
{
    UIBarButtonItem *doneButton;
    UIToolbar *toolBar;
}
@end

@implementation AddPaymentPage

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    tfCardNumber.delegate = self;
    tfCvv.delegate = self;
    tfExpiryDate.delegate = self;
    
    [self borderWork];
    
    doneButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Done" style:UIBarButtonItemStyleDone
                                   target:self action:@selector(doneone:)];
    toolBar = [[UIToolbar alloc]initWithFrame:
                          CGRectMake(0, self.view.frame.size.height-
                                     tfCardNumber.frame.size.height-50, 320, 50)];
    [toolBar setBarStyle:UIBarStyleBlackOpaque];
    NSArray *toolbarItems = [NSArray arrayWithObjects:
                             doneButton, nil];
    [toolBar setItems:toolbarItems];
    
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == tfCardNumber)
    {
        tfCardNumber.inputAccessoryView = toolBar;
    }
    else if (textField == tfCvv)
    {
        tfCvv.inputAccessoryView = toolBar;
    }
    else if (textField == tfExpiryDate)
    {
        tfExpiryDate.inputAccessoryView = toolBar;
    }
}
-(void)doneone:(id)sender
{
    [self.view endEditing:YES];
}
- (void) borderWork
{
    [obNet startSpaceTo:tfCardNumber Space:SpaceForTextField];
    [obNet startSpaceTo:tfCvv Space:SpaceForTextField];
    [obNet startSpaceTo:tfExpiryDate Space:SpaceForTextField];
  
    [tfCardNumber setValue:colorTextHintSecond forKeyPath:@"_placeholderLabel.textColor"];
    [tfCvv setValue:colorTextHintSecond forKeyPath:@"_placeholderLabel.textColor"];
    [tfExpiryDate setValue:colorTextHintSecond forKeyPath:@"_placeholderLabel.textColor"];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    tfCvv.text = @"";
    tfExpiryDate.text = @"";
    tfCardNumber.text = @"";
    
    [obNet SetTextFieldBorder:tfCardNumber];
    [obNet SetTextFieldBorder:tfCvv];
    [obNet SetTextFieldBorder:tfExpiryDate];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == tfCardNumber)
    {
        [tfCvv becomeFirstResponder];
    }
    else  if (textField == tfCvv)
    {
        [tfExpiryDate becomeFirstResponder];
    }
    else  if (textField == tfExpiryDate)
    {
        [textField resignFirstResponder];
    }

    [self borderWork];
    
    return YES;
}
- (int) validateCardNumber
{
    
    NSString *newString = [tfCardNumber.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    newString = [tfCardNumber.text stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
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

- (IBAction)btnAddHiphen:(id)sender
{
    
    if (tfCardNumber.text.length > 3) {
        int whichCard = [self validateCardNumber];
        
        tfCardNumber.text = [tfCardNumber.text stringByReplacingOccurrencesOfString:@"-" withString:@""];
        
        [imgCard setHidden:NO];
        
        switch (whichCard) {
            case Visa: {
                [imgCard setImage:[UIImage imageNamed:@"visa.png"]];
            }
                break;
            case Master: {
                [imgCard setImage:[UIImage imageNamed:@"mastercrd.png"]];
            }
                break;
            case Express: {
                [imgCard setImage:[UIImage imageNamed:@"american.png"]];
            }
                break;
            case Diners: {
                [imgCard setImage:[UIImage imageNamed:@"dinersclub.png"]];
            }
                break;
            case JSB: {
                [imgCard setImage:[UIImage imageNamed:@"jcb.png"]];
            }
                break;
            case Discover: {
                [imgCard setImage:[UIImage imageNamed:@"discover.png"]];
            }
                break;
            case NoONe: {
                [imgCard setHidden:YES];
            }
                break;
                
            default:
                break;
        }
        
        if (whichCard == Express) {
            if (tfCardNumber.text.length <= 15) {//NSLog(@"JD-3");
                NSString * newCard = @"";
                int ii = 0;
                for (int i = 0; i < tfCardNumber.text.length; i++) {
                    if ((i == 4 && i > 0) || (i == 10 && i > 0)) {
                        if (i == 4 && i > 0) {
                            if (ii < 3) {
                                newCard = [NSString stringWithFormat:@"%@-%c", newCard, [tfCardNumber.text characterAtIndex:i]];
                                ii++;
                            } else if (ii == 3) {
                                newCard = [NSString stringWithFormat:@"%@%c", newCard, [tfCardNumber.text characterAtIndex:i]];
                                ii++;
                            }
                        } else if (i == 10 && i > 0) {
                            if (ii < 3) {
                                newCard = [NSString stringWithFormat:@"%@-%c", newCard, [tfCardNumber.text characterAtIndex:i]];
                                ii++;
                            } else if (ii == 3) {
                                newCard = [NSString stringWithFormat:@"%@%c", newCard, [tfCardNumber.text characterAtIndex:i]];
                                ii++;
                            }
                        }
                    } else {
                        newCard = [NSString stringWithFormat:@"%@%c", newCard, [tfCardNumber.text characterAtIndex:i]];
                    }
                }
                
                tfCardNumber.text = newCard;
            }
        } else if (whichCard == Diners) {
            if (tfCardNumber.text.length <= 16) {//NSLog(@"JD-3-5");
                NSString * newCard = @"";
                int ii = 0;
                for (int i = 0; i < tfCardNumber.text.length; i++) {
                    if (i%4 == 0 && i > 0) {
                        if (ii < 3) {
                            newCard = [NSString stringWithFormat:@"%@-%c", newCard, [tfCardNumber.text characterAtIndex:i]];
                            ii++;
                        } else if (ii == 3) {
                            newCard = [NSString stringWithFormat:@"%@%c", newCard, [tfCardNumber.text characterAtIndex:i]];
                            ii++;
                        }
                    } else {
                        newCard = [NSString stringWithFormat:@"%@%c", newCard, [tfCardNumber.text characterAtIndex:i]];
                    }
                }
                
                tfCardNumber.text = newCard;
            }
        } else {//NSLog(@"JD-3-4");
            if (tfCardNumber.text.length <= 16) {//NSLog(@"JD-3-5");
                NSString * newCard = @"";
                int ii = 0;
                for (int i = 0; i < tfCardNumber.text.length; i++) {
                    if (i%4 == 0 && i > 0) {
                        if (ii < 3) {
                            newCard = [NSString stringWithFormat:@"%@-%c", newCard, [tfCardNumber.text characterAtIndex:i]];
                            ii++;
                        } else if (ii == 3) {
                            newCard = [NSString stringWithFormat:@"%@%c", newCard, [tfCardNumber.text characterAtIndex:i]];
                            ii++;
                        }
                    } else {
                        newCard = [NSString stringWithFormat:@"%@%c", newCard, [tfCardNumber.text characterAtIndex:i]];
                    }
                }
                
                tfCardNumber.text = newCard;
            }
        }
    }

}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (tfCardNumber == textField) {
        textField.text = [textField.text  stringByReplacingOccurrencesOfString:@"-" withString:@""];
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        if (newLength > 16) {
            return NO;
        } else {
            return YES;
        }
    } else if (tfCvv == textField) {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        if (newLength > 4) {
            return NO;
        } else {
            return YES;
        }
    } else if (tfExpiryDate == textField) {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        NSLog(@"newLength %ld", (unsigned long)newLength);
        
        if (newLength == 3) {
            
            NSString *string = tfExpiryDate.text;
            if ([string rangeOfString:@"/"].location == NSNotFound) {
                tfExpiryDate.text = [NSString stringWithFormat:@"%@/", tfExpiryDate.text];
            }
        }
        
        if (newLength == 5) {
            [self timeValidation:[NSString stringWithFormat:@"%@%@", textField.text, string]];
        }
        
        if (newLength > 5) {
            return NO;
        } else {
            return YES;
        }
    }
    
    return YES;
}
- (void) timeValidation:(NSString *) tf
{
    NSString * strYr = tf;
    
    NSArray * arr = [strYr componentsSeparatedByString:@"/"];
    
    if (arr.count == 2) {
        int monthTf = [arr[0] intValue];
        int yearTf  = [arr[1] intValue];
        if (monthTf > 12) {
            ToastMSGK(@"Invalid expiry date!", YES);
            strCardExpired = nil;
        } else {
            if (yearTf < year) {
                ToastMSGK(@"Invalid expiry date!", YES);
                strCardExpired = nil;
            } else if (yearTf == year) {
                if (monthTf > month) {
                    strCardExpired = @"";
                } else {
                    ToastMSGK(@"Invalid expiry date!", YES);
                    strCardExpired = nil;
                }
            } else if (yearTf > year) {
                strCardExpired = @"";
            }
        }
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)Submit
{
    [self.view endEditing:YES];
     if (tfCvv.text.length == 0)
    {
        ToastMSGK(@"Please Enter Your CVV.", NO);
    }
    else if (!IsObNotNil(strCardExpired))
    {
        ToastMSGK(@"Invalid expiry date!", NO);
    }
    else if (tfCardNumber.text.length == 0)
    {
        ToastMSGK(@"Please Enter Card Number!", NO);
    }
    else
    {
        [KAppDelegate.CardDetail setObject:@"Amex Ending With 3795" forKey:@"number"];
        
        UserInfo *ob = [obNet getUserInfoObject];
        NSMutableDictionary * mD = [NSMutableDictionary new];
        
        mD[@"cust_id"] = ob.data.cust_id;
        mD[@"holder_name"] = @"test";
        mD[@"card_no"] = tfCardNumber.text;
        mD[@"cvv"] = tfCvv.text;
        mD[@"exp_year"] = tfExpiryDate.text;
        
        [obNet JSONFromWebServices:WS_addPayment Parameter:mD Method:@"POST" AI:YES PopUP:YES Caller:CALLER WithBlock:^(id json)
         {
             if (IsObNotNil(json))
             {
                 if ([json[@"success"] integerValue] == 1)
                 {
                     ToastMSG(json[@"message"][@"title"]);
                      [_delegate PopViewController];
                 }
                 else
                 {
                     ToastMSG(json[@"message"][@"title"]);
                 }
             }
             else
             {
                 ToastMSG(json[@"message"][@"title"]);
             }
         }];
        
   
    }
}

@end

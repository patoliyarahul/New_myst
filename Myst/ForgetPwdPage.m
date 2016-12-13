//
//  ForgetPwdPage.m
//  Myst
//
//  Created by Vipul Jikadra on 12/12/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import "ForgetPwdPage.h"

@interface ForgetPwdPage ()
{
    
}
@end

@implementation ForgetPwdPage

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
   tfEmail.delegate = self;
   lblMsg.text = @"Please enter the email associated with your account.\nif email exists, we will send you an intrusction on how to\nreset your password.";
    [self borderWork];
    [self HighLite];
}
- (void) borderWork
{
    
    [obNet SetTextFieldBorder:tfEmail];
  
    
    [obNet startSpaceTo:tfEmail Space:SpaceForTextField];
   
    [tfEmail setValue:colorTextHint forKeyPath:@"_placeholderLabel.textColor"];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
   
    [tfEmail resignFirstResponder];

    [self HighLite];
    [self borderWork];
    
    return YES;
}
-(void)HighLite
{
    if (tfEmail.text.length != 0)
    {
        [tfSubmit setBackgroundColor:[obNet colorWithHexString:@ButtonBackgrondcolor]];
        tfSubmit.alpha = 1.0;
        tfSubmit.userInteractionEnabled = YES;
    }
    else
    {
        [tfSubmit setBackgroundColor:[obNet colorWithHexString:@ButtonBackgrondcolor]];
        tfSubmit.alpha = 0.5;
        tfSubmit.userInteractionEnabled = false;

    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)submitFire:(id)sender
{
    BOOL validateEmail =[obNet NSStringIsValidEmail:tfEmail.text];
    
    NSString * msg = nil;
    
    if (tfEmail.text.length == 0)
    {
        msg = @"Email is empty";
    }
    else if (!validateEmail)
    {
        msg = @"Email is not valid";
    }
    if (msg)
    {
        ToastMSG(msg);
    }
    else
    {
//        NSMutableDictionary * mD = [NSMutableDictionary new];
//        
//        
//        mD[@"email"] = tfEmail.text;
//        
//        [obNet JSONFromWebServices:WS_loginUser Parameter:mD Method:@"POST" AI:YES PopUP:YES Caller:CALLER WithBlock:^(id json)
//         {
//             if (IsObNotNil(json))
//             {
//                 
//                 if ([json[@"success"] integerValue] == 1)
//                 {
//                     
//                     NSError* err = nil;
//                     
//                     UserInfo *ob = [[UserInfo alloc]initWithDictionary:json error:&err];
//                     
//                     [obNet setUserInfoObject:ob];
//                     NSLog(@"ob == %@",ob);
//                     ToastMSG(@"user successfully created at backend");
//                     [_delegate Push:VC_HomePage Data:nil];
//                     
//                 }
//                 else
//                 {
//                     ToastMSG(json[@"message"][@"title"]);
//                 }
//                 
//             }
//             else
//             {
//                 ToastMSG(json[@"message"][@"title"]);
//             }
//             
//         }];

    }
}
@end

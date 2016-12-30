//
//  LoginPage.m
//  Myst
//
//  Created by Vipul Jikadra on 12/12/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import "LoginPage.h"

@interface LoginPage ()
{
    
}
@end

@implementation LoginPage

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    lblForgetpwd.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(textViewTapped:)];
    [lblForgetpwd addGestureRecognizer:gestureRecognizer];
    
    tfEmail.delegate = self;
    tfPwd.delegate = self;
    btnCross.hidden = YES;
    
    [self HighLite];
    
    [self borderWork];
    
//    tfEmail.text = @"jips2598@gmail.com";
//    tfPwd.text = @"12345678";
    
    [tfEmail setCustomDoneTarget:self action:@selector(doneAction:)];
    [tfPwd setCustomDoneTarget:self action:@selector(doneAction:)];

}
-(void)doneAction:(UITextField*)textField
{
    [self HighLite];
}
-(void)textViewTapped:(UITapGestureRecognizer *)recognizer
{
    [self.delegate Push:VC_ForgetPwdPage Data:nil];
}
- (void) borderWork
{
    
    [obNet SetTextFieldBorder:tfEmail];
    [obNet SetTextFieldBorder:tfPwd];
    
    [obNet startSpaceTo:tfEmail Space:SpaceForTextField];
    [obNet startSpaceTo:tfPwd Space:SpaceForTextField];

    
    [tfEmail setValue:colorTextHint forKeyPath:@"_placeholderLabel.textColor"];
    [tfPwd setValue:colorTextHint forKeyPath:@"_placeholderLabel.textColor"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == tfEmail)
    {
        [tfPwd becomeFirstResponder];
    }
    else
    {
        [tfPwd resignFirstResponder];
    }
    
    [self HighLite];
    [self borderWork];
    
    return YES;
}
-(void)HighLite
{
    if (tfEmail.text.length != 0 && tfPwd.text.length != 0)
    {
        [btnSubmit setBackgroundColor:[obNet colorWithHexString:@ButtonBackgrondcolor]];
        btnSubmit.alpha = 1.0;
         btnCross.hidden = NO;
        btnSubmit.userInteractionEnabled = YES;
    }
    else
    {
        [btnSubmit setBackgroundColor:[obNet colorWithHexString:@ButtonBackgrondcolor]];
        btnSubmit.alpha = 0.5;
        btnCross.hidden = YES;
        btnSubmit.userInteractionEnabled = false;
    }
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{

}

#define SubmitAction
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
    else if (tfPwd.text.length == 0)
    {
        msg = @"Password is empty";
    }
    else if (tfPwd.text.length < 8)
    {
        msg = @"Password is atleast 8 charcter long";
    }
    if (msg)
    {
        ToastMSG(msg);
    }
    else
    {
        NSMutableDictionary * mD = [NSMutableDictionary new];
        

        mD[@"email"] = tfEmail.text;
        mD[@"password"] = tfPwd.text;
        
        [obNet JSONFromWebServices:WS_loginUser Parameter:mD Method:@"POST" AI:YES PopUP:YES Caller:CALLER WithBlock:^(id json)
         {
             if (IsObNotNil(json))
             {
                 
                 if ([json[@"success"] integerValue] == 1)
                 {
                     
                     NSError* err = nil;
                     
                     UserInfo *ob = [[UserInfo alloc]initWithDictionary:json error:&err];
                     
                     [obNet setUserInfoObject:ob];
                     NSLog(@"ob == %@",ob);
                     UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Welcome to Myst Wash" message:[NSString stringWithFormat:@"%@",@"Begin by Requesting a Wash,\n or explore our packages."] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                     [alert show];
                     [_delegate Push:VC_HomePage Data:nil];
                     
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
- (IBAction)crossFire:(id)sender
{
    tfEmail.text = @"";
     btnCross.hidden = YES;
}
@end

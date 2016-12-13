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
    if (msg)
    {
        ToastMSG(msg);
    }
    else
    {
         [_delegate Push:VC_HomePage Data:nil];
    }

}
- (IBAction)crossFire:(id)sender
{
    tfEmail.text = @"";
     btnCross.hidden = YES;
}
@end

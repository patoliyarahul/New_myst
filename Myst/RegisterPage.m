//
//  RegisterPage.m
//  Myst
//
//  Created by Vipul Jikadra on 09/12/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import "RegisterPage.h"

@interface RegisterPage ()

@end

@implementation RegisterPage

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    tfname.delegate = self;
    tfEmail.delegate = self;
    tfPwd.delegate = self;
    tfConfirmPwd.delegate = self;
    
    [obNet SetTextFieldBorder:tfEmail];
    [obNet SetTextFieldBorder:tfname];
    [obNet SetTextFieldBorder:tfPwd];
    [obNet SetTextFieldBorder:tfConfirmPwd];
    keyboardFrameBeginRect = CGRectMake(0.0, 0.0, 320.0, 253.0);
    [self borderWork];
    
    lblTerms.userInteractionEnabled = YES;
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(textViewTapped:)];
    [lblTerms addGestureRecognizer:gestureRecognizer];
    
    [self HighLite];
}
-(void)textViewTapped:(UITapGestureRecognizer *)recognizer
{
    [self.delegate Push:VC_TermsPage Data:nil];
}
- (void) borderWork
{

    [obNet startSpaceTo:tfEmail Space:SpaceForTextField];
    [obNet startSpaceTo:tfname Space:SpaceForTextField];
    [obNet startSpaceTo:tfPwd Space:SpaceForTextField];
    [obNet startSpaceTo:tfConfirmPwd Space:SpaceForTextField];

    [tfEmail setValue:colorTextHint forKeyPath:@"_placeholderLabel.textColor"];
    [tfname setValue:colorTextHint forKeyPath:@"_placeholderLabel.textColor"];
    [tfPwd setValue:colorTextHint forKeyPath:@"_placeholderLabel.textColor"];
    [tfConfirmPwd setValue:colorTextHint forKeyPath:@"_placeholderLabel.textColor"];
    
}
- (void)viewDidLayoutSubviews
{
    [backScrl setContentSize:CGSizeMake([obNet deviceFrame].size.width, [obNet deviceFrame].size.height)];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == tfname)
    {
        [tfEmail becomeFirstResponder];
    }
    else  if (textField == tfEmail)
    {
      [tfPwd becomeFirstResponder];
    }
    else  if (textField == tfPwd)
    {
        [tfConfirmPwd becomeFirstResponder];
    }
    else  if (textField == tfConfirmPwd)
    {
        [textField resignFirstResponder];
    }
    [backScrl setContentOffset:CGPointZero];
    [backScrl setContentSize:CGSizeZero];
    
    [self HighLite];
    [self borderWork];
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == tfname || textField == tfEmail)
    {
        
    }
    else
    {
        float newY = self.view.frame.size.height - keyboardFrameBeginRect.size.height - textField.frame.size.height * 3;
        
        if (newY > 0)
        {
            [backScrl setContentOffset:CGPointMake(0, newY)];
        }
        else
        {
            [backScrl setContentOffset:CGPointZero];
        }
        
    }
}
-(void)HighLite
{
    if (tfname.text.length != 0 && tfEmail.text.length != 0 && tfPwd.text.length != 0 && tfConfirmPwd.text.length !=0)
    {
        [btnSubmit setBackgroundColor:[obNet colorWithHexString:@ButtonBackgrondcolor]];
        btnSubmit.alpha = 1.0;
        btnSubmit.userInteractionEnabled = YES;
    }
    else
    {
        [btnSubmit setBackgroundColor:[obNet colorWithHexString:@ButtonBackgrondcolor]];
        btnSubmit.alpha = 0.5;
        btnSubmit.userInteractionEnabled = false;
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
    
    if (tfname.text.length == 0)
    {
        msg = @"Name is empty";
    }
    else if (tfEmail.text.length == 0)
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
    else if (tfConfirmPwd.text.length == 0)
    {
        msg = @"Confirm Password is empty";
    }
    else if (![tfConfirmPwd.text isEqualToString:tfPwd.text])
    {
        msg = @"Password and Confirm Password is not same";
    }
    if (msg)
    {
        ToastMSG(msg);
    }
    else
    {
        NSMutableDictionary * mD = [NSMutableDictionary new];
        
        mD[@"fullname"] = tfname.text;
        mD[@"email"] = tfEmail.text;
        mD[@"password"] = tfPwd.text;
    
        [obNet JSONFromWebServices:WS_registerUser Parameter:mD Method:@"POST" AI:YES PopUP:YES Caller:CALLER WithBlock:^(id json)
         {
             if (IsObNotNil(json))
             {
                 
                 if ([json[@"success"] integerValue] == 1)
                 {
     
                     NSError* err = nil;
                     
                     UserInfo *ob = [[UserInfo alloc]initWithDictionary:json error:&err];
                     
                     [obNet setUserInfoObject:ob];
                     NSLog(@"ob == %@",ob);
                     ToastMSG(@"user successfully created at backend");
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
@end

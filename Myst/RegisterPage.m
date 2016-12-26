//
//  RegisterPage.m
//  Myst
//
//  Created by Vipul Jikadra on 09/12/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import "RegisterPage.h"

@interface RegisterPage ()
{
    
}
@end

@implementation RegisterPage

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    tfname.delegate = self;
    tfEmail.delegate = self;
    tfPwd.delegate = self;
    tfmobileNumber.delegate = self;
    
    [obNet SetTextFieldBorder:tfEmail];
    [obNet SetTextFieldBorder:tfname];
    [obNet SetTextFieldBorder:tfPwd];
    [obNet SetTextFieldBorder:tfmobileNumber];
    keyboardFrameBeginRect = CGRectMake(0.0, 0.0, 320.0, 253.0);
    [self borderWork];
    
    lblTerms.userInteractionEnabled = YES;
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(textViewTapped:)];
    [lblTerms addGestureRecognizer:gestureRecognizer];
    
    [self HighLite];
    asYouTypeFormatter = [[NBAsYouTypeFormatter alloc] initWithRegionCode:@"IN"];
    
     [tfEmail setCustomDoneTarget:self action:@selector(doneAction:)];
     [tfname setCustomDoneTarget:self action:@selector(doneAction:)];
     [tfPwd setCustomDoneTarget:self action:@selector(doneAction:)];
     [tfmobileNumber setCustomDoneTarget:self action:@selector(doneAction:)];
}
-(void)doneAction:(UITextField*)textField
{
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
    [obNet startSpaceTo:tfmobileNumber Space:SpaceForTextField];

    [tfEmail setValue:colorTextHint forKeyPath:@"_placeholderLabel.textColor"];
    [tfname setValue:colorTextHint forKeyPath:@"_placeholderLabel.textColor"];
    [tfPwd setValue:colorTextHint forKeyPath:@"_placeholderLabel.textColor"];
    [tfmobileNumber setValue:colorTextHint forKeyPath:@"_placeholderLabel.textColor"];
    
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
        [tfmobileNumber becomeFirstResponder];
    }
    else  if (textField == tfmobileNumber)
    {
        [textField resignFirstResponder];
    }
    [backScrl setContentOffset:CGPointZero];
    [backScrl setContentSize:CGSizeZero];
    
    [self HighLite];
    [self borderWork];
    
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    // Just allow 10 digits
    
        if(textField == tfmobileNumber)
        {
         if(!(([string length] + range.location) > 11))
         {
            // Something entered by user
            if(range.length == 0)
            {
                [tfmobileNumber setText:[asYouTypeFormatter inputDigit:string]];
            }
            
            // Backspace
            else if(range.length == 1)
            {
                [tfmobileNumber setText:[asYouTypeFormatter removeLastDigit]];
            }
            
        }
             return NO;
    }
    else
    {
        return YES;
    }
    
}

-(void)HighLite
{
    if (tfname.text.length != 0 && tfEmail.text.length != 0 && tfPwd.text.length != 0 && tfmobileNumber.text.length !=0)
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
    else if (tfPwd.text.length < 8)
    {
        msg = @"Password is atleast 8 charcter long";
    }
    else if (tfmobileNumber.text.length == 0)
    {
        msg = @"Mobile Number is empty";
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
        mD[@"phone"] = tfmobileNumber.text;
        
        
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
@end

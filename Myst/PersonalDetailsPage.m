//
//  PersonalDetailsPage.m
//  Myst
//
//  Created by Vipul Jikadra on 30/12/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import "PersonalDetailsPage.h"

@interface PersonalDetailsPage ()

@end

@implementation PersonalDetailsPage

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    tfName.delegate = self;
    tfEmail.delegate = self;
    tfMobile.delegate = self;
    
    [obNet SetTextFieldBorder:tfName];
    [obNet SetTextFieldBorder:tfEmail];
    [obNet SetTextFieldBorder:tfMobile];
    
    asYouTypeFormatter = [[NBAsYouTypeFormatter alloc] initWithRegionCode:@"US"];
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    UserInfo *ob = [obNet getUserInfoObject];
    
    tfName.text = ob.data.name;
    tfEmail.text = ob.data.email;
    tfMobile.text = ob.data.phone;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    // Just allow 10 digits
    
    if(textField == tfMobile)
    {
        if(!(([string length] + range.location) > 14))
        {
            // Something entered by user
            if(range.length == 0)
            {
                [tfMobile setText:[asYouTypeFormatter inputDigit:string]];
            }
            
            // Backspace
            else if(range.length == 1)
            {
                [tfMobile setText:[asYouTypeFormatter removeLastDigit]];
            }
            
        }
        return NO;
    }
    else
    {
        return YES;
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)Submit
{
    BOOL validateEmail =[obNet NSStringIsValidEmail:tfEmail.text];
    
    NSString * msg = nil;
    
    if (tfName.text.length == 0)
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
    else if (tfMobile.text.length == 0)
    {
        msg = @"Mobile Number is empty";
    }
    else if (tfMobile.text.length < 14)
    {
        msg = @"Mobile Number is Not Valid";
    }
    if (msg)
    {
        ToastMSG(msg);
    }
    else
    {
        NSMutableDictionary * mD = [NSMutableDictionary new];
        
        UserInfo *ob = [obNet getUserInfoObject];
        mD[@"cust_id"] = ob.data.cust_id;
        mD[@"fullname"] = tfName.text;
        mD[@"email"] = tfEmail.text;
      //  mD[@"phone"] = tfmobileNumber.text;
        
        
        [obNet JSONFromWebServices:WS_editprofile Parameter:mD Method:@"POST" AI:YES PopUP:YES Caller:CALLER WithBlock:^(id json)
         {
             if (IsObNotNil(json))
             {
                 
                 if ([json[@"success"] integerValue] == 1)
                 {
                     NSError* err = nil;
                     UserInfo *ob = [[UserInfo alloc]initWithDictionary:json error:&err];
                     NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
                     [defaults removeObjectForKey:USERLOGINDATA];
                     [defaults synchronize];
                     [obNet setUserInfoObject:ob];
                    
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

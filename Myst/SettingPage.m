//
//  SettingPage.m
//  Myst
//
//  Created by Vipul Jikadra on 30/12/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import "SettingPage.h"

@interface SettingPage ()
{
    UITapGestureRecognizer *GestureOne;
    UITapGestureRecognizer *GestureSecond;
    UITapGestureRecognizer *GestureThird;
    
    UserInfo *ob;
}
@end

@implementation SettingPage

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
     [obNet SetviewBorder:viewPush];
     [obNet SetviewBorder:viewEmail];
     [obNet SetviewBorder:viewPersonalDeatil];
    
    
    GestureOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewOnPersionalDetailTapped:)];
    viewPersonalDeatil.userInteractionEnabled = YES;
    [viewPersonalDeatil addGestureRecognizer:GestureOne];
    
    
    GestureSecond = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewOnPushTapped:)];
    viewPush.userInteractionEnabled = YES;
    [viewPush addGestureRecognizer:GestureSecond];
    
    
    GestureThird = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewOnEmailTapped:)];
    viewEmail.userInteractionEnabled = YES;
    [viewEmail addGestureRecognizer:GestureThird];
    
    
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    ob = [obNet getUserInfoObject];
   
    [self setSwitch];
}
-(void)setSwitch
{
    
    if ([ob.data.emailNotification isEqualToString:@"1"])
    {
        [switchEmail setOn:true];
    }
    else
    {
        [switchEmail setOn:false];
    }
    
    if ([ob.data.pushNotification isEqualToString:@"1"])
    {
        [switchPush setOn:true];
    }
    else
    {
        [switchPush setOn:false];
    }
    
}
-(void)viewOnPersionalDetailTapped:(UIGestureRecognizer *)recognizer
{
    [_delegate Push:VC_PersonalDetailsPage Data:nil];
}
-(void)viewOnPushTapped:(UIGestureRecognizer *)recognizer
{
    
}
-(void)viewOnEmailTapped:(UIGestureRecognizer *)recognizer
{
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pushFire:(id)sender
{
    if([sender isOn])
    {
        NSLog(@"Switch is ON");
        
        flagPush = true;
    }
    else
    {
        NSLog(@"Switch is OFF");
        
        flagPush = false;
    }
    
    [self updateSetting];
}

- (IBAction)emailFire:(id)sender
{
    NSLog(@"value = %@",sender);
    
    if([sender isOn])
    {
        NSLog(@"Switch is ON");
        
        flagEmail = true;
        
    }
    else
    {
        NSLog(@"Switch is OFF");
        
        flagEmail = false;
    }
    
    [self updateSetting];
}

-(void)updateSetting
{
    NSMutableDictionary * mD = [NSMutableDictionary new];
    
    
    mD[@"cust_id"] = ob.data.cust_id;
    
    if (flagPush)
    {
        mD[@"pushNotification"] = @"1";
    }
    else
    {
        mD[@"pushNotification"] = @"0";
    }
    
    
    if (flagEmail)
    {
        mD[@"emailNotification"] = @"1";
    }
    else
    {
        mD[@"emailNotification"] = @"0";
    }
    
    
    
    
    [obNet JSONFromWebServices:WS_disablenotification Parameter:mD Method:@"POST" AI:YES PopUP:YES Caller:CALLER WithBlock:^(id json)
     {
         if (IsObNotNil(json))
         {
             
             if ([json[@"success"] integerValue] == 1)
             {
                 
                 NSError* err = nil;
                 
                 UserInfo *ob1 = [[UserInfo alloc]initWithDictionary:json error:&err];
                 
                 [obNet setUserInfoObject:ob1];
                 NSLog(@"ob == %@",ob1);
                 [self setSwitch];
                 ToastMSG(json[@"message"][@"title"]);
                 
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
- (IBAction)DeleteFire:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Are You Sure Want To Delete This Account", nil];
  
    [actionSheet showInView:self.view];
}
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        NSMutableDictionary * mD = [NSMutableDictionary new];
        mD[@"cust_id"] = ob.data.cust_id;
        [obNet JSONFromWebServices:WS_DeleteAccount Parameter:mD Method:@"POST" AI:YES PopUP:YES Caller:CALLER WithBlock:^(id json)
         {
             if (IsObNotNil(json))
             {
                 
                 if ([json[@"success"] integerValue] == 1)
                 {
                     NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
                     [defaults removeObjectForKey:USERLOGINDATA];
                     [defaults synchronize];
                     
                     [_delegate Push:VC_TutorialPage Data:nil];
                     
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

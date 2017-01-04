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
    
}

- (IBAction)emailFire:(id)sender
{
    
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
        UserInfo *ob = [obNet getUserInfoObject];
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

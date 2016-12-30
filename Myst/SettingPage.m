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
}
@end

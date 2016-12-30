//
//  HomePage.m
//  Myst
//
//  Created by Vipul Jikadra on 14/12/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import "HomePage.h"

@interface HomePage ()
{
    
}
@end

@implementation HomePage

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [obNet SetTextFieldBorder:tfName];
    [obNet setBorder:btnTrack Color:[UIColor whiteColor] CornerRadious:5.0 BorderWidth:1.0];
    
//    if (IsObNotNil([[[obNet getUserInfoObject] valueForKey:@"data"] valueForKey:@"name"]))
//    {
//        tfName.text = [[[obNet getUserInfoObject] valueForKey:@"data"] valueForKey:@"name"];
//    }

    [obNet setBorder:btnTrack Color:[UIColor whiteColor] CornerRadious:0.0 BorderWidth:1.0];
    [obNet setBorder:btnPackges Color:[UIColor whiteColor] CornerRadious:0.0 BorderWidth:1.0];
    [obNet setBorder:btnSendrequest Color:[UIColor whiteColor] CornerRadious:0.0 BorderWidth:1.0];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)requestFire:(id)sender
{
    [_delegate Push:VC_AddvehiclePage Data:nil];
}

- (IBAction)TrackFire:(id)sender
{
   
}

- (IBAction)packagesFire:(id)sender
{
    [_delegate Push:VC_ExplorePackagePage Data:nil];
}

- (IBAction)sendRequestFire:(id)sender
{
    [_delegate Push:VC_RequestDemoPage Data:nil];
}
@end

//
//  AddvehiclePage.m
//  Myst
//
//  Created by Vipul Jikadra on 15/12/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import "AddvehiclePage.h"
#import "HomePage.h"
#import "VehicleOb.h"
#import "VehicleListCell.h"
@interface AddvehiclePage ()
{
    VehicleOb *vOB;
}
@end

@implementation AddvehiclePage

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    tblVehicle.delegate = self;
    tblVehicle.dataSource = self;
    
    tblVehicle.hidden = YES;
    btnNext.hidden = YES;
    [carview bringSubviewToFront:carImage];
    
    carview.hidden = YES;
    
    [tblVehicle registerNib:[UINib nibWithNibName:@"VehicleListCell" bundle:nil] forCellReuseIdentifier:@"VehicleList"];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSMutableDictionary * mD = [NSMutableDictionary new];
    
    UserInfo *ob = [obNet getUserInfoObject];
    
    mD[@"cust_id"] = ob.data.cust_id;
    [obNet JSONFromWebServices:WS_getVehicle Parameter:mD Method:@"POST" AI:YES PopUP:YES Caller:CALLER WithBlock:^(id json)
     {
         if (IsObNotNil(json))
         {
             
             if ([json[@"success"] integerValue] == 1)
             {
                 NSError* err = nil;
                 vOB = [[VehicleOb alloc]initWithDictionary:json error:&err];
                 
                 if (vOB.data.count > 0)
                 {
                     carview.hidden = YES;
                     [tblVehicle reloadData];
                     tblVehicle.hidden = NO;
                     btnNext.hidden = NO;
                 }
                 else
                 {
                     carview.hidden = NO;
                     btnNext.hidden = YES;

                 }
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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark TableView Delegate methods For Menu

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //minimum size of your cell, it should be single line of label if you are not clear min. then return UITableViewAutomaticDimension;
    return UITableViewAutomaticDimension;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return vOB.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"VehicleList";
    VehicleListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[VehicleListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.layer.backgroundColor = [UIColor clearColor].CGColor;
    cell.backgroundColor = [UIColor clearColor];
    
    VehicleObData *obData = vOB.data[indexPath.row];
    
    cell.lblYear.text = [NSString stringWithFormat:@"%@ %@ %@",[obData valueForKey:@"model_year"] , [obData valueForKey:@"make"] , [obData valueForKey:@"model"]];
    cell.lblType.text = [obData valueForKey:@"type"];
    
    cell.lblPackage.text = @"1311113311313";
    cell.imgCheck.hidden = YES;
    cell.btnMsg.hidden = YES;
    
    [cell.btnSelect addTarget:self action:@selector(SelectFire:event:) forControlEvents:UIControlEventTouchUpInside];
    

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
-(IBAction)SelectFire:(id)sender event:(id)event
{
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:tblVehicle];
    NSIndexPath *indexPath = [tblVehicle indexPathForRowAtPoint:currentTouchPosition];
    
    [_delegate Push:VC_SelectPackage Data:nil];

}
- (IBAction)addVehicleFire:(id)sender
{
    [self.delegate ShowVehicleView];
}

- (IBAction)nextFire:(id)sender
{
    
}
@end
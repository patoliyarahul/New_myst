//
//  ManageVehiclePage.m
//  Myst
//
//  Created by Vipul Jikadra on 28/12/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import "ManageVehiclePage.h"
#import "ManageVehiclePageCell.h"
#import "VehicleOb.h"
#import "VehicleData.h"
@interface ManageVehiclePage ()
{
    
    VehicleOb *vOB;
    VehicleObData *obDatas;
}
@end

@implementation ManageVehiclePage

- (void)viewDidLoad
{
    [super viewDidLoad];
    tblVehicle.delegate = self;
    tblVehicle.dataSource = self;
    [tblVehicle registerNib:[UINib nibWithNibName:@"ManageVehiclePageCell" bundle:nil] forCellReuseIdentifier:@"ManageVehiclePageCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    NSMutableDictionary * mD = [NSMutableDictionary new];
    
    UserInfo *ob = [obNet getUserInfoObject];
    

    carview.hidden = YES;
    
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
                    
                 }
                 else
                 {
                     carview.hidden = NO;
                     
                 }
             }
             else
             {
                 ToastMSG(json[@"message"][@"title"]);
                 carview.hidden = NO;
             }
             
         }
         else
         {
             ToastMSG(json[@"message"][@"title"]);
         }
         
     }];

}

#pragma mark TableView Delegate methods For Menu


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return vOB.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"ManageVehiclePageCell";
    ManageVehiclePageCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[ManageVehiclePageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.layer.backgroundColor = [UIColor clearColor].CGColor;
    cell.backgroundColor = [UIColor clearColor];
   
    VehicleObData *obData = vOB.data[indexPath.row];
    cell.lblVehicleName.text = [NSString stringWithFormat:@"%@ %@ %@",[obData valueForKey:@"model_year"] , [obData valueForKey:@"make"] , [obData valueForKey:@"model"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    VehicleObData *obData = vOB.data[indexPath.row];
    NSMutableDictionary *sendDict = [NSMutableDictionary new];
    [sendDict setObject:@"Edit Vehicle" forKey:@"title"];
    [sendDict setObject:obData forKey:@"data"];
    [self.delegate ShowVehicleView:sendDict];
}
- (IBAction)addVehicleFire:(id)sender
{
    VehicleObData *obData = [VehicleObData new];
    NSMutableDictionary *sendDict = [NSMutableDictionary new];
    [sendDict setObject:@"Add a Vehicle" forKey:@"title"];
    [sendDict setObject:obData forKey:@"data"];
    [self.delegate ShowVehicleView:sendDict];
}
@end

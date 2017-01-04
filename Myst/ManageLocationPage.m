//
//  ManageLocationPage.m
//  Myst
//
//  Created by Vipul Jikadra on 28/12/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import "ManageLocationPage.h"
#import "ManageLocationPageCell.h"
#import "LocationOb.h"
#import "LocationObData.h"

@interface ManageLocationPage ()
{
    LocationOb *lOB;
    LocationObData *obDatas;
    UserInfo *ob;
}
@end

@implementation ManageLocationPage

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    tblLocation.delegate = self;
    tblLocation.dataSource = self;
    
    tblLocation.hidden = YES;
    [tblLocation registerNib:[UINib nibWithNibName:@"ManageLocationPageCell" bundle:nil] forCellReuseIdentifier:@"ManageLocationPageCell"];

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
     tblLocation.hidden = YES;
    
    NSMutableDictionary * mD = [NSMutableDictionary new];
    ob = [obNet getUserInfoObject];
    viewPopup.hidden = YES;
    
    mD[@"cust_id"] = ob.data.cust_id;
    [obNet JSONFromWebServices:WS_getLocation Parameter:mD Method:@"POST" AI:YES PopUP:YES Caller:CALLER WithBlock:^(id json)
     {
         if (IsObNotNil(json))
         {
             
             if ([json[@"success"] integerValue] == 1)
             {
                 NSError* err = nil;
                 lOB = [[LocationOb alloc]initWithDictionary:json error:&err];
                 
                 if (lOB.data.count > 0)
                 {
                     viewPopup.hidden = YES;
                     [tblLocation reloadData];
                     tblLocation.hidden = NO;
             
                 }
                 else
                 {
                     viewPopup.hidden = NO;
                     tblLocation.hidden = YES;
                     
                 }
             }
             else
             {
                 ToastMSG(json[@"message"][@"title"]);
                 viewPopup.hidden = NO;
                 tblLocation.hidden = YES;
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
    return lOB.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"ManageLocationPageCell";
    ManageLocationPageCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[ManageLocationPageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.layer.backgroundColor = [UIColor clearColor].CGColor;
    cell.backgroundColor = [UIColor clearColor];
    
    
    LocationObData *obData = lOB.data[indexPath.row];
    cell.lblLocation.text = [NSString stringWithFormat:@"%@ %@ \n%@ %@ %@",[obData valueForKey:@"street"] , [obData valueForKey:@"unit"] , [obData valueForKey:@"city"],[obData valueForKey:@"state"] ,[obData valueForKey:@"zipcode"]];
    cell.lblLocType.text = [obData valueForKey:@"loc_type"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LocationObData *obData = lOB.data[indexPath.row];
    NSMutableDictionary *sendDict = [NSMutableDictionary new];
    [sendDict setObject:@"Edit Location" forKey:@"title"];
    [sendDict setObject:obData forKey:@"data"];
    [self.delegate ShowLocationView:sendDict];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)AddLocationFire:(id)sender
{
    LocationObData *obData = [LocationObData new];
    NSMutableDictionary *sendDict = [NSMutableDictionary new];
    [sendDict setObject:@"Add a Location" forKey:@"title"];
    [sendDict setObject:obData forKey:@"data"];
    [_delegate ShowLocationView:sendDict];
}
@end

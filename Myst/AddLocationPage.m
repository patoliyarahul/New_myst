//
//  AddLocationPage.m
//  Myst
//
//  Created by Vipul Jikadra on 19/12/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import "AddLocationPage.h"
#import "LocationOb.h"
#import "LocationObData.h"
#import "LocationCell.h"
@interface AddLocationPage ()
{
    LocationOb *lOB;
    LocationObData *obDatas;
    UserInfo *ob;
}
@end

@implementation AddLocationPage

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    tblLocation.delegate = self;
    tblLocation.dataSource = self;
    
    tblLocation.hidden = YES;
    btnNext.hidden = YES;
    btnPlus.hidden = YES;
    [tblLocation registerNib:[UINib nibWithNibName:@"LocationCell" bundle:nil] forCellReuseIdentifier:@"LocationCell"];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSMutableDictionary * mD = [NSMutableDictionary new];
    
    ob = [obNet getUserInfoObject];
    
    //packages = [NSMutableArray new];
    
    
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
                     btnNext.hidden = NO;
                     btnPlus.hidden = NO;
                 }
                 else
                 {
                     viewPopup.hidden = NO;
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
    
    if (KAppDelegate.packages.count != 0)
    {
        viewFotter.hidden = NO;
        int a = 0;
        for (NSString* key in [KAppDelegate.PackagePrice allKeys])
        {
            NSLog(@"key ==== %@",key);
            
            a = a + [[KAppDelegate.PackagePrice objectForKey:key]integerValue];
        }
        
        lblTotal.text = [NSString stringWithFormat:@"$%i",a];
    }
    else
    {
        viewFotter.hidden = YES;
    }
    
    if (KAppDelegate.locationDict.count != 0)
    {
        [btnNext setTitleColor:[obNet colorWithHexString:@"0AE587"] forState:UIControlStateNormal];
        [btnNext setImage:[UIImage imageNamed:@"angle-double-right - FontAwesome"] forState:UIControlStateNormal];
        btnNext.userInteractionEnabled = YES;
        
    }
    else
    {
        [btnNext setTitleColor:[obNet colorWithHexString:@"D8D8D8"] forState:UIControlStateNormal];
        [btnNext setImage:[UIImage imageNamed:@"angle-double-right unselected- FontAwesome"] forState:UIControlStateNormal];
        btnNext.userInteractionEnabled = NO;
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark TableView Delegate methods For Menu


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return lOB.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"LocationCell";
    LocationCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[LocationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.layer.backgroundColor = [UIColor clearColor].CGColor;
    cell.backgroundColor = [UIColor clearColor];
    
    
    LocationObData *obData = lOB.data[indexPath.row];
    
    cell.lblName.text = [NSString stringWithFormat:@"%@ %@ \n%@ %@ %@",[obData valueForKey:@"street"] , [obData valueForKey:@"unit"] , [obData valueForKey:@"city"],[obData valueForKey:@"state"] ,[obData valueForKey:@"zipcode"]];

    [cell.btnSelect addTarget:self action:@selector(SelectFire:event:) forControlEvents:UIControlEventTouchUpInside];
    
    if ([[KAppDelegate.locationDict valueForKey:[obData valueForKey:@"loc_id"]] isEqualToString:[obData valueForKey:@"loc_id"]])
    {
         cell.imgCheck.hidden = NO;
         cell.btnSelect.hidden = YES;
         
         NSIndexPath* selectedCellIndexPath= [NSIndexPath indexPathForRow:indexPath.row inSection:0];
         [self tableView:tblLocation didSelectRowAtIndexPath:selectedCellIndexPath];
         [tblLocation selectRowAtIndexPath:selectedCellIndexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
     }
    else
     {
         cell.imgCheck.hidden = YES;
         cell.btnSelect.hidden = NO;
     }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    KAppDelegate.locationDict = [NSMutableDictionary new];
    
    LocationObData *obData = lOB.data[indexPath.row];
    [KAppDelegate.locationDict setObject:[obData valueForKey:@"loc_id"] forKey:[obData valueForKey:@"loc_id"]];
    
    [self highLite];
}
-(void)highLite
{
    if (KAppDelegate.locationDict.count != 0)
    {
        [btnNext setTitleColor:[obNet colorWithHexString:@"0AE587"] forState:UIControlStateNormal];
        [btnNext setImage:[UIImage imageNamed:@"angle-double-right - FontAwesome"] forState:UIControlStateNormal];
        btnNext.userInteractionEnabled = YES;
    }
    else
    {
        [btnNext setTitleColor:[obNet colorWithHexString:@"D8D8D8"] forState:UIControlStateNormal];
        [btnNext setImage:[UIImage imageNamed:@"angle-double-right unselected- FontAwesome"] forState:UIControlStateNormal];
        btnNext.userInteractionEnabled = NO;
    }
}
-(IBAction)SelectFire:(id)sender event:(id)event
{
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:tblLocation];
    NSIndexPath *indexPath = [tblLocation indexPathForRowAtPoint:currentTouchPosition];
    
    KAppDelegate.locationDict = [NSMutableDictionary new];
    
    LocationObData *obData = lOB.data[indexPath.row];
    [KAppDelegate.locationDict setObject:[obData valueForKey:@"loc_id"] forKey:[obData valueForKey:@"loc_id"]];
    
    [tblLocation reloadData];
    
    [self highLite];
}
- (IBAction)nextFire:(id)sender
{
    NSMutableDictionary *senddict = [[NSMutableDictionary alloc] init];
    [senddict setObject:[_dataInfo valueForKey:@"Vehicle"] forKey:@"Vehicle"];
    [_delegate Push:VC_CheckoutPage Data:senddict];
}

- (IBAction)plusFire:(id)sender
{
     [_delegate ShowLocationView];
}

- (IBAction)AddLocationFire:(id)sender
{
    [_delegate ShowLocationView];
}
@end

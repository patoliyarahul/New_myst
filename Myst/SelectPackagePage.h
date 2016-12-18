//
//  SelectPackagePage.h
//  Myst
//
//  Created by Vipul Jikadra on 16/12/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectPackagePage : UIViewController<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
{
    
    IBOutlet UILabel *lblMake;
    IBOutlet UITableView *tablePackage;
    
    NSMutableArray *packages;
    
   
}
@property(nonatomic) NSMutableDictionary *dataInfo;
@end

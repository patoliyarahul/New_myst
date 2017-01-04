//
//  RequestDemoPage.h
//  Myst
//
//  Created by Vipul Jikadra on 31/12/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DelegateRequestDemoPage <NSObject>

- (void) Push:(int)vc Data:(id)dataInfo;
- (void) PopViewController;
- (void) addCustomPopup:(NSString *) msg;

@end
@interface RequestDemoPage : UIViewController<UITableViewDelegate , UITableViewDataSource>
{
    IBOutlet UITableView *tblPckage;
    
    NSMutableArray *name;
    NSMutableArray *Descrption;
    NSMutableArray *image;
}
@property (weak, nonatomic) id <DelegateRequestDemoPage> delegate;
@end

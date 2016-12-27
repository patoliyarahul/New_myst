//
//  ExplorePackagePage.h
//  Myst
//
//  Created by Vipul Jikadra on 27/12/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DelegateExplorePackagePage <NSObject>

- (void) Push:(int)vc Data:(id)dataInfo;
- (void) PopViewController;
- (void) addCustomPopup:(NSString *) msg;
-(void)ShowLocationView;
@end
@interface ExplorePackagePage : UIViewController<UITableViewDelegate , UITableViewDataSource>
{
    IBOutlet UITableView *tblPckage;
}
@property (weak, nonatomic) id <DelegateExplorePackagePage> delegate;
@end

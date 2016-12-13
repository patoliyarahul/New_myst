//
//  TutorialPage.h
//  Myst
//
//  Created by Vipul Jikadra on 09/12/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DelegateTutorialPage <NSObject>

- (void) Push:(int)vc Data:(id)dataInfo;
- (void) PopViewController;
- (void) addCustomPopup:(NSString *) msg;
@end
@interface TutorialPage : UIViewController<UIPageViewControllerDataSource,UIPageViewControllerDelegate>
{
    
    IBOutlet UIImageView *imgMyst;
    
    IBOutlet UILabel *lblMsg;
    
    IBOutlet UIPageControl *pageIndicator;
    
    IBOutlet UIButton *btnGetstart;
    
    IBOutlet UIButton *btnLogin;
    
    int CurrentIndex;
     NSMutableArray *lables;
}
@property (strong, nonatomic) UIPageViewController *pageController;
@property (weak, nonatomic) id <DelegateTutorialPage> delegate;
- (IBAction)StartFire:(id)sender;
- (IBAction)loginFire:(id)sender;

@end

//
//  TipAndReviewPage.h
//  Myst
//
//  Created by Vipul Jikadra on 03/01/17.
//  Copyright © 2017 Vipul Jikadra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCSStarRatingView.h"
@protocol DelegateTipAndReviewPage <NSObject>
- (void) Push:(int)vc Data:(id)dataInfo;
- (void) PopViewController;
- (void) addCustomPopup:(NSString *) msg;
-(void)ShowTipView:(NSMutableDictionary *)data;
@end
@interface TipAndReviewPage : UIViewController
{
    
    IBOutlet UIScrollView *backScrl;
    
    IBOutlet UIImageView *imgTip;
    
    IBOutlet UIImageView *imgDriver;
    
    IBOutlet UILabel *lblDriverName;
    
    IBOutlet UIActivityIndicatorView *AI;
    
    IBOutlet UIView *viewFooter;
    
    IBOutlet UIButton *btnNext;
    
    IBOutlet UILabel *lblTotal;
    
    IBOutlet UIButton *btnOne;
    
    IBOutlet UIButton *btnSecond;
    
    IBOutlet UIButton *btnThird;
    
    IBOutlet UIButton *btnFourth;
    
    IBOutlet UIButton *btnOther;
    
    
    IBOutlet UIView *viewReview;
    
    IBOutlet UITextView *commnets;
    
    IBOutlet UIButton *btnSubmit;
    
    IBOutlet HCSStarRatingView *viewRate;
    
     float originalXOfCardImg;
    
    float rateingValue;
    
    float amount;
}

- (IBAction)NotipFire:(id)sender;
- (IBAction)TenPercentageFire:(id)sender;
- (IBAction)FifteenPercentageFire:(id)sender;
- (IBAction)TwentyPercentageFire:(id)sender;
- (IBAction)OtherFire:(id)sender;
- (IBAction)nextFire:(id)sender;
@property(nonatomic)NSMutableDictionary *dataInfo;

- (IBAction)submitFire:(id)sender;
- (IBAction)RatingFire:(HCSStarRatingView *)sender;
@property (weak, nonatomic) id <DelegateTipAndReviewPage> delegate;
@end

//
//  TutorialPage.m
//  Myst
//
//  Created by Vipul Jikadra on 09/12/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import "TutorialPage.h"
#import "TutorailChuldPage.h"
@interface TutorialPage ()
{
    
}
@end

@implementation TutorialPage

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    self.pageController.delegate = self;
    self.pageController.dataSource = self;
    [[self.pageController view] setFrame:[[self view] bounds]];
    
    TutorailChuldPage *initialViewController = [self viewControllerAtIndex:0];
    
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:self.pageController];
    [[self view] addSubview:[self.pageController view]];
    
    [self.pageController didMoveToParentViewController:self];
    
  //  [obNet setBorder:btnGetstart Color:nil CornerRadious:5.0 BorderWidth:0.0];
    [self.view bringSubviewToFront:btnLogin];
    [self.view bringSubviewToFront:imgMyst];
    [self.view bringSubviewToFront:lblMsg];
    [self.view bringSubviewToFront:btnGetstart];
    [self.view bringSubviewToFront:pageIndicator];
    
    lables = [[NSMutableArray alloc] initWithObjects:@"On-Demand Car Wash Concierge",@"Request a Wash",@"Our trained detailer will arrive \n to wash your car",@"Your car is washed and \n ready for night out.", nil];
    
    lblMsg.text = [lables objectAtIndex:0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (TutorailChuldPage *)viewControllerAtIndex:(NSUInteger)index
{
    
    TutorailChuldPage *childViewController = [[TutorailChuldPage alloc] initWithNibName:@"TutorailChuldPage" bundle:nil];
    childViewController.index = index;
    
    return childViewController;
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(TutorailChuldPage *)viewController index];
    
    if (index == 0) {
        return nil;
    }
    
    // Decrease the index by 1 to return
    index--;
    
    return [self viewControllerAtIndex:index];
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    
    NSUInteger index = [(TutorailChuldPage *)viewController index];
    
    index++;
    
    if (index == 4)
    {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
    
}
- (void)pageViewController:(UIPageViewController *)pvc didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    if (!completed)
    {
        return;
    }
    NSUInteger currentIndex = [[_pageController.viewControllers lastObject] index];
    pageIndicator.currentPage = currentIndex;
    lblMsg.text = [lables objectAtIndex:currentIndex];
    NSLog(@"tryindex == %lu",(unsigned long)currentIndex);
    
    if (currentIndex == 0)
    {
        imgMyst.hidden = NO;
    }
    else
    {
        imgMyst.hidden = YES;
    }
}
- (IBAction)StartFire:(id)sender
{
    [_delegate Push:VC_RegisterPage Data:nil];
}

- (IBAction)loginFire:(id)sender
{
     [_delegate Push:VC_LoginPage Data:nil];
}
@end

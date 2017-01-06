//
//  TutorailChuldPage.m
//  Myst
//
//  Created by Vipul Jikadra on 09/12/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import "TutorailChuldPage.h"

@interface TutorailChuldPage ()

@end

@implementation TutorailChuldPage

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
     imgBack.image = [UIImage imageNamed:[NSString stringWithFormat:@"screen%i",self.index]];
     
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

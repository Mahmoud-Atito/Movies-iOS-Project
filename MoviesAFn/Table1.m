//
//  Table1.m
//  project1
//
//  Created by Sayed Abdo on 9/11/17.
//  Copyright © 2017 Sayed Abdo. All rights reserved.
//

#import "Table1.h"
#import "signup.h"

@interface Table1 ()

@end

@implementation Table1
- (IBAction)logout:(id)sender {
    //signup *signup1 = [signup new];
   // [self.navigationController popToViewController:signup1 animated:YES];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    signup *vc = [storyboard instantiateViewControllerWithIdentifier:@"login"];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self.navigationItem setHidesBackButton:YES];
    /*UIBarButtonItem *btnReload = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(btnReloadPressed:)];
    self.navigationController.topViewController.navigationItem.rightBarButtonItem = btnReload;
    btnReload.enabled=TRUE;
    btnReload.style=UIBarButtonSystemItemRefresh;*/
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

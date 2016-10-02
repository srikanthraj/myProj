//
//  HomePageAfterRegViewController.m
//  MyDream
//
//  Created by admin on 2016-09-30.
//  Copyright © 2016 admin. All rights reserved.
//

#import "HomePageAfterRegViewController.h"
#import "HomePageViewController.h"
#import "AppDelegate.h"
#import "UserBasicInfo.h"
#import "ViewController.h"


@interface HomePageAfterRegViewController ()
@property (nonatomic) AppDelegate *appDelegate;

@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *addressLine1TextField;
@property (weak, nonatomic) IBOutlet UITextField *addressLine2TextField;
@property (weak, nonatomic) IBOutlet UITextField *cityTextField;

@property (weak, nonatomic) IBOutlet UITextField *zipCodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

//-(void) updateLogList;

@end

@implementation HomePageAfterRegViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.appDelegate = [[UIApplication sharedApplication] delegate];
    self.userNameLabel.text = self.userName;
    //[self updateLogList];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)continueTapped:(id)sender {
    
    UserBasicInfo *userBasicInfo = [self.appDelegate createUserBasicInfo];
    
    userBasicInfo.user_name = [self.userNameLabel text];
    userBasicInfo.user_first_name = [self.firstNameTextField text];
    userBasicInfo.user_last_name = [self.lastNameTextField text];
    userBasicInfo.user_address_line1 = [self.addressLine1TextField text];
    userBasicInfo.user_address_line2 = [self.addressLine2TextField text];
    userBasicInfo.user_city = [self.cityTextField text];
    userBasicInfo.user_zip = [self.zipCodeTextField text];
    userBasicInfo.user_phone = [self.phoneTextField text];
    userBasicInfo.user_email = [self.emailTextField text];
    
    [self.appDelegate saveContext];
    //[self updateLogList];
    
    HomePageViewController *hPViewController =
    [[HomePageViewController alloc] initWithNibName:@"HomePageViewController" bundle:nil];
    
    hPViewController.userName  = userBasicInfo.user_name;
    [self.navigationController pushViewController:hPViewController animated:YES];
    
    //HomePageViewController *hpvc = [[HomePageViewController alloc]init];
    [self presentViewController:hPViewController animated:YES completion:nil];
}

@end

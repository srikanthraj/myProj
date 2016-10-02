//
//  RegisterViewController.m
//  MyDream
//
//  Created by admin on 2016-09-29.
//  Copyright © 2016 admin. All rights reserved.
//

#import "RegisterViewController.h"
#import "HomePageAfterRegViewController.h"
#include "AppDelegate.h"
#include "UserBasicInfo.h"

@interface RegisterViewController ()

@property (nonatomic) AppDelegate *appDelegate;
@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UILabel *successLabel;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.passwordField.secureTextEntry = YES;
    self.appDelegate = [[UIApplication sharedApplication] delegate];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)registerTapped:(id)sender {
    
    //Let's create an empty mutable dictionary:
    NSMutableDictionary *keychainItem = [NSMutableDictionary dictionary];
    
    NSString *username = self.userNameField.text;
    NSString *password = self.passwordField.text;
    
    NSString *website = @"http://www.myawesomeservice.com";
    
    //Populate it with the data and the attributes we want to use.
    
    keychainItem[(__bridge id)kSecClass] = (__bridge id)kSecClassInternetPassword; // We specify what kind of keychain item this is.
    keychainItem[(__bridge id)kSecAttrAccessible] = (__bridge id)kSecAttrAccessibleWhenUnlocked; // This item can only be accessed when the user unlocks the device.
    keychainItem[(__bridge id)kSecAttrServer] = website;
    keychainItem[(__bridge id)kSecAttrAccount] = username;
    
    //Check if this keychain item already exists.
    
    if(SecItemCopyMatching((__bridge CFDictionaryRef)keychainItem, NULL) == noErr)
    {
        
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"The Username Already Exists" message:@"Please try to login."preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *aa = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        
        [ac addAction:aa];
        [self presentViewController:ac animated:YES completion:nil];
        
    }else
    {
        
        keychainItem[(__bridge id)kSecValueData] = [password dataUsingEncoding:NSUTF8StringEncoding]; //Our password
        
        OSStatus sts = SecItemAdd((__bridge CFDictionaryRef)keychainItem, NULL);
        NSLog(@"Error Code: %d", (int)sts);
        
        self.successLabel.text = @"Successfully  Registered!!";
        
        HomePageAfterRegViewController *hPARegViewController =
        [[HomePageAfterRegViewController alloc] initWithNibName:@"HomePageAfterRegViewController" bundle:nil];
        
        hPARegViewController.userName  = username;
        [self.navigationController pushViewController:hPARegViewController animated:YES];
        
        //HomePageAfterRegViewController *hpReg = [[HomePageAfterRegViewController alloc] init];
        
        [self presentViewController:hPARegViewController animated:YES completion:nil];
        
        
    }
}

@end

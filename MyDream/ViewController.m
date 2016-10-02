//
//  ViewController.m
//  MyDream
//
//  Created by admin on 2016-09-29.
//  Copyright © 2016 admin. All rights reserved.
//

#import "ViewController.h"
#include "RegisterViewController.h"

#include "HomePageViewController.h"
#include "UserBasicInfo.h"
#import "AppDelegate.h"


@interface ViewController ()
@property (nonatomic) AppDelegate *appDelegate;

@property (weak, nonatomic) IBOutlet UITextField *loginUserNameText;
@property (weak, nonatomic) IBOutlet UITextField *loginPasswordText;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.loginPasswordText.secureTextEntry = YES;
    self.appDelegate = [[UIApplication sharedApplication] delegate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)registerTapped:(id)sender {
    
    RegisterViewController *regView = [[RegisterViewController alloc]init];
    [self presentViewController:regView animated:YES completion:nil];
    
}
- (IBAction)loginButtonTapped:(id)sender {
    
    
    //Let's create an empty mutable dictionary:
    NSMutableDictionary *keychainItem = [NSMutableDictionary dictionary];
    
    NSString *usernameEntered = self.loginUserNameText.text;
    NSString *passwordEntered = self.loginPasswordText.text;
    
    NSString *website = @"http://www.myawesomeservice.com";
    
    //Populate it with the data and the attributes we want to use.
    
    keychainItem[(__bridge id)kSecClass] = (__bridge id)kSecClassInternetPassword; // We specify what kind of keychain item this is.
    keychainItem[(__bridge id)kSecAttrAccessible] = (__bridge id)kSecAttrAccessibleWhenUnlocked; // This item can only be accessed when the user unlocks the device.
    keychainItem[(__bridge id)kSecAttrServer] = website;
    keychainItem[(__bridge id)kSecAttrAccount] = usernameEntered;
    
    //Check if this keychain item already exists.
    
    keychainItem[(__bridge id)kSecReturnData] = (__bridge id)kCFBooleanTrue;
    keychainItem[(__bridge id)kSecReturnAttributes] = (__bridge id)kCFBooleanTrue;
    
    CFDictionaryRef result = nil;
    
    OSStatus sts = SecItemCopyMatching((__bridge CFDictionaryRef)keychainItem, (CFTypeRef *)&result);
    
    NSLog(@"Error Code: %d", (int)sts);
    
    if(sts == noErr)
    {
        NSDictionary *resultDict = (__bridge_transfer NSDictionary *)result;
        NSData *pswd = resultDict[(__bridge id)kSecValueData];
        NSString *password = [[NSString alloc] initWithData:pswd encoding:NSUTF8StringEncoding];
        
        if([self.loginPasswordText.text isEqualToString:password]) { // Login Successful
            
            HomePageViewController *hPViewController =
            [[HomePageViewController alloc] initWithNibName:@"HomePageViewController" bundle:nil];
            
            hPViewController.userName  = usernameEntered;
            [self.navigationController pushViewController:hPViewController animated:YES];
            
            [self presentViewController:hPViewController animated:YES completion:nil];
            
        }
        
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Incorrect Password", nil)
                                                            message:NSLocalizedString(@"You have Entered Incorrect Password, Please Try again!", )
                                                           delegate:nil
                                                  cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                                  otherButtonTitles:nil];
            [alert show];

        }
        
        
    }else
    {
        RegisterViewController *rvc = [[RegisterViewController alloc]init];
        
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"No UserName Found" message:@"No Username found, Please Register" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *aa = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
            [self presentViewController:rvc animated:YES completion:nil];
            
        }];
        [ac addAction:aa];
        [self presentViewController:ac animated:YES completion:nil];
        
    }

}

@end

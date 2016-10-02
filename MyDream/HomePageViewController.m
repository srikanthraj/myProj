//
//  HomePageViewController.m
//  MyDream
//
//  Created by admin on 2016-09-29.
//  Copyright © 2016 admin. All rights reserved.
//

#import "HomePageViewController.h"
#import "HomePageAfterRegViewController.h"
#import "HomePageViewController.h"
#import "AppDelegate.h"
#import "UserBasicInfo.h"
#import "ViewController.h"
#import "NewInvitationViewController.h"

@interface HomePageViewController ()

@property (nonatomic) AppDelegate *appDelegate;
@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;
-(void) updateLogList;
@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.appDelegate = [[UIApplication sharedApplication] delegate];
    [self updateLogList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) updateLogList {
    NSManagedObjectContext *moc =  self.appDelegate.managedObjectContext;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"UserBasicInfo"];
    
    
    //NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"User"];
    request.predicate = [NSPredicate predicateWithFormat:@"user_name == %@",self.userName];
    //request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"id" ascending:YES]];

    
    
    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:request error:&error];
    
    if(!results){
        
        NSLog(@"Error fetching UserBasicInfo Object %@\n%@",[error localizedDescription], [error userInfo]);
        abort();
        
    }
    
    
    for(UserBasicInfo *ubi in results){
        self.welcomeLabel.text = [self.welcomeLabel.text stringByAppendingString:ubi.user_first_name];
    }
}

- (IBAction)newInviteTapped:(id)sender {
    
    NewInvitationViewController *newInvite = [[NewInvitationViewController alloc]init];
    [self presentViewController:newInvite animated:YES completion:nil];
}

@end

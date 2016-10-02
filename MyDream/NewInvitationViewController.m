//
//  NewInvitationViewController.m
//  MyDream
//
//  Created by admin on 2016-10-01.
//  Copyright © 2016 admin. All rights reserved.
//

#import "NewInvitationViewController.h"
#import "AppDelegate.h"
#import "UserBasicInfo.h"
#import "ViewController.h"

@interface NewInvitationViewController ()

@property (nonatomic) AppDelegate *appDelegate;
@property (weak, nonatomic) IBOutlet UITextField *inviteFirstName;
@property (weak, nonatomic) IBOutlet UITextField *inviteLastName;
@property (weak, nonatomic) IBOutlet UITextField *invitePhone;

@property (weak, nonatomic) IBOutlet UITextField *inviteEMail;
@property (weak, nonatomic) IBOutlet UILabel *userNotExistsLabel;
@property (weak, nonatomic) IBOutlet UILabel *inviteSuccessLabel;
@property (weak, nonatomic) IBOutlet UIButton *sendInviteButton;

-(BOOL) checkUserExists;
@end

@implementation NewInvitationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.userNotExistsLabel setHidden:YES];
    [self.inviteSuccessLabel setHidden:YES];
    self.appDelegate = [[UIApplication sharedApplication] delegate];
    
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL) checkUserExists {
    
    NSManagedObjectContext *moc =  self.appDelegate.managedObjectContext;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"UserBasicInfo"];
    
    if( ([self.invitePhone.text length] !=0) && ([self.inviteEMail.text length] !=0)){
        
        
        request.predicate = [NSPredicate predicateWithFormat:@"user_first_name == %@ AND user_last_name == %@ AND user_phone == %@ AND user_email == %@",self.inviteFirstName.text , self.inviteLastName.text , self.invitePhone.text , self.inviteEMail.text];
    }
    
    else if([self.invitePhone.text length] !=0) {
    
    request.predicate = [NSPredicate predicateWithFormat:@"user_first_name == %@ AND user_last_name == %@ AND user_phone == %@",self.inviteFirstName.text , self.inviteLastName.text , self.invitePhone.text];
    }
    
    else if([self.inviteEMail.text length] !=0) {
        
        request.predicate = [NSPredicate predicateWithFormat:@"user_first_name == %@ AND user_last_name == %@ AND user_email == %@",self.inviteFirstName.text , self.inviteLastName.text , self.inviteEMail.text];
    }
    
    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:request error:&error];
    
    if(!results){
        
        NSLog(@"Error fetching UserBasicInfo Object %@\n%@",[error localizedDescription], [error userInfo]);
        abort();
        
    }
    
    NSLog(@"Results length %lu",(unsigned long)[results count]);
    
    if([results count] >= 1){
        return YES;
    }
    else {
        return NO;
    }

    
}

- (IBAction)sendInviteButtonTapped:(id)sender {
    
    if([self checkUserExists]) {
        
        NSString *toAppend = [self.inviteFirstName.text stringByAppendingString:@"!!"];
        self.inviteSuccessLabel.text = [self.inviteSuccessLabel.text stringByAppendingString:toAppend];
        [self.inviteSuccessLabel setHidden:NO];
        [self.userNotExistsLabel setHidden:YES];
        
    }
    
    else {
        [self.userNotExistsLabel setHidden:NO];
        [self.inviteSuccessLabel setHidden:YES];
    }
    
}


@end

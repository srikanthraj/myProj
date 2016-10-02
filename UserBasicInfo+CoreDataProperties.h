//
//  UserBasicInfo+CoreDataProperties.h
//  MyDream
//
//  Created by admin on 2016-09-30.
//  Copyright © 2016 admin. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "UserBasicInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserBasicInfo (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *user_name;
@property (nullable, nonatomic, retain) NSString *user_first_name;
@property (nullable, nonatomic, retain) NSString *user_last_name;
@property (nullable, nonatomic, retain) NSString *user_address_line1;
@property (nullable, nonatomic, retain) NSString *user_address_line2;
@property (nullable, nonatomic, retain) NSString *user_city;
@property (nullable, nonatomic, retain) NSString *user_zip;
@property (nullable, nonatomic, retain) NSString *user_email;
@property (nullable, nonatomic, retain) NSString *user_phone;

@end

NS_ASSUME_NONNULL_END

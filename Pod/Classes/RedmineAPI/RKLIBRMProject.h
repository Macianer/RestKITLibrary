//
//  RKLIBRMProject.h
//  RestKit_Redmine_API
//
//  Created by Ronny Meissner on 28.03.14.
//  Copyright (c) 2014 Ronny Meissner. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RKLIBRMProject : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *projectId;
@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) NSString *descriptionString;
@property (nonatomic, strong) NSString *homepage;
@property (nonatomic, strong) NSDate *createdOn;
@property (nonatomic, strong) NSDate *updateOn;
@property (nonatomic, strong) NSNumber *isPublic;

-(instancetype) projectWithName:(NSString *) name
                 withIdentifier:(NSString *) identifier
                withDescription:(NSString *) description;
@end

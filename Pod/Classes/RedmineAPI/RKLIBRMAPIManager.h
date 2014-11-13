//
//  RKLIBRMAPIManager.h
//  Pods
//
//  Created by Ronny Meissner on 25/09/14.
//
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>
#import "RKLIBRM.h"
#import "RKLIBRMIssues.h"

/*!
 *  Configure a API Object for Redmine requests (see http://www.redmine.org/).
 *
 *  @return A RKObjectManager for Redmine API.
 */
@interface RKLIBRMAPIManager : NSObject

+ (instancetype)sharedManager;

@property (nonatomic, strong) RKObjectManager *objectManager;

/*!
 *  @brief Configure Redmine API
 *
 *  @param url      Redmine Server URL as NSString.
 *  @param username Specific redmine user name.
 *  @param password Related user password to user name.
 */
- (void)configureWithUrl:(NSString *)url withUser:(NSString *)username withPassword:(NSString *)password;

- (void)getProjectsWithSuccess:(void (^)(RKObjectRequestOperation *operation, RKLIBRMProjects *projects))success
                       failure:(void (^)(RKObjectRequestOperation *operation, NSError *error))failure;

- (void)getProjectWithId:(NSNumber *)projectId
             withInclude:(NSString *)includes
                 Success:(void (^)(RKObjectRequestOperation *operation, RKLIBRMProject *project))success
                 failure:(void (^)(RKObjectRequestOperation *operation, NSError *error))failure;

- (void)postProjectWithName:(NSString *)name withIdentifier:(NSString *)identifier withDescription:(NSString *)descriptionString success:(void (^)(RKObjectRequestOperation *operation, RKLIBRMProject *project))success
                    failure:(void (^)(RKObjectRequestOperation *operation, NSError *error))failure;
#pragma mark issues
- (void)getIssuesWithSuccess:(void (^)(RKObjectRequestOperation *operation, RKLIBRMIssues *issues))success
                     failure:(void (^)(RKObjectRequestOperation *operation, NSError *error))failure;

- (NSString *)uploadTokenFromImage:(UIImage *)image withFileName:(NSString *)fileName;

@end

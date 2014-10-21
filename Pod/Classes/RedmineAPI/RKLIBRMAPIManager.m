//
//  RKLIBRMAPIManager.m
//  Pods
//
//  Created by Ronny Meissner on 25/09/14.
//
//

#import "RKLIBRMAPIManager.h"
#import "RKLIBDef.h"
#import "RKLIBRMMappingHelper.h"


@implementation RKLIBRMAPIManager {
	NSString *_password;
	NSString *_user;
	NSString *_url;
}
+ (instancetype)sharedManager {
	static RKLIBRMAPIManager *sharedMapper = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
	    sharedMapper = [[RKLIBRMAPIManager alloc] init];
	});
	return sharedMapper;
}

- (void)configureWithUrl:(NSString *)url withUser:(NSString *)username withPassword:(NSString *)password {
	_url = url;
	_user = username;
	_password = password;
}

- (RKObjectManager *)objectManager {
	if (!_objectManager) {
		[self _initObjectManager];
	}
	return _objectManager;
}

/*!
 *  Configure a RKObjectManager for Redmine requests.
 */
- (void)_initObjectManager {
	RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:[AFHTTPClient clientWithBaseURL:[NSURL URLWithString:_url]]];
	[objectManager.HTTPClient setAuthorizationHeaderWithUsername:_user password:_password];

	[objectManager setAcceptHeaderWithMIMEType:RKMIMETypeJSON];


	RKResponseDescriptor *projectResponse = [RKResponseDescriptor responseDescriptorWithMapping:[RKLIBRMMappingHelper projectsMapping] method:RKRequestMethodGET pathPattern:@"/projects.json" keyPath:nil statusCodes:[NSIndexSet indexSetWithIndex:RKStatusCodeClassSuccessful]];

	RKResponseDescriptor *issuesResponse = [RKResponseDescriptor responseDescriptorWithMapping:[RKLIBRMMappingHelper issuesMapping] method:RKRequestMethodGET pathPattern:@"/issues.json" keyPath:nil statusCodes:[NSIndexSet indexSetWithIndex:RKStatusCodeClassSuccessful]];

	RKRequestDescriptor *projectRequest = [RKRequestDescriptor requestDescriptorWithMapping:[RKLIBRMMappingHelper projectMapping].inverseMapping objectClass:[RKLIBRMProject class] rootKeyPath:nil method:RKRequestMethodPOST];

	[objectManager addResponseDescriptor:projectResponse];
	[objectManager addResponseDescriptor:issuesResponse];
	[objectManager addRequestDescriptor:projectRequest];
	_objectManager = objectManager;
}

/*!
 *  Listing projects
 *
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
- (void)getProjectWithId:(NSNumber *)projectId
             withInclude:(NSString *)includes
                 Success:(void (^)(RKObjectRequestOperation *operation, RKLIBRMProject *project))success
                 failure:(void (^)(RKObjectRequestOperation *operation, NSError *error))failure {
	NSString *path = [NSString stringWithFormat:@"/projects.%@", kJson];
	NSDictionary *dict  = nil;
	if (includes)
		dict = @{ @"include":includes };
	[self.objectManager getObjectsAtPath:path parameters:dict success: ^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
	    if ([mappingResult.firstObject isKindOfClass:[RKLIBRMProject class]]) {
	        success(operation, mappingResult.firstObject);
		}
	} failure: ^(RKObjectRequestOperation *operation, NSError *error) {
	    failure(operation, error);
	}];
}

- (void)getProjectsWithSuccess:(void (^)(RKObjectRequestOperation *operation,  RKLIBRMProjects *projects))success
                       failure:(void (^)(RKObjectRequestOperation *operation, NSError *error))failure {
	NSString *path = [NSString stringWithFormat:@"/projects.%@", kJson];
	[self.objectManager getObjectsAtPath:path parameters:nil success: ^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
	    if ([mappingResult.firstObject isKindOfClass:[RKLIBRMProjects class]]) {
	        success(operation, mappingResult.firstObject);
		}
	} failure: ^(RKObjectRequestOperation *operation, NSError *error) {
	    failure(operation, error);
	}];
}

/*!
 *  Get a single project.
 *
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
- (void)getProjectsWithName:(NSString *)projectName success:(void (^)(RKObjectRequestOperation *operation, RKLIBRMProject *project))success
                    failure:(void (^)(RKObjectRequestOperation *operation, NSError *error))failure {
	NSString *path = [NSString stringWithFormat:@"/projects/%@.%@", projectName, kJson];
	[self.objectManager getObjectsAtPath:path parameters:nil success: ^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
	    if ([mappingResult.array isKindOfClass:[NSMutableArray class]]) {
	        success(operation, mappingResult.firstObject);
		}
	} failure: ^(RKObjectRequestOperation *operation, NSError *error) {
	    failure(operation, error);
	}];
}

/*!
 *  Create new project
 *
 *  @param name              <#name description#>
 *  @param identifier        <#identifier description#>
 *  @param descriptionString <#descriptionString description#>
 *  @param success           <#success description#>
 *  @param failure           <#failure description#>
 */
- (void)postProjectWithName:(NSString *)name withIdentifier:(NSString *)identifier withDescription:(NSString *)descriptionString success:(void (^)(RKObjectRequestOperation *operation, RKLIBRMProject *project))success
                    failure:(void (^)(RKObjectRequestOperation *operation, NSError *error))failure {
	NSString *path = [NSString stringWithFormat:@"/projects.%@", kJson];

	RKLIBRMProject *project = [RKLIBRMProject new];
	project.name = name;
	project.identifier = identifier;
	project.descriptionString = descriptionString;

	[self.objectManager postObject:project path:path parameters:nil success: ^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
	    success(operation, mappingResult.firstObject);
	} failure: ^(RKObjectRequestOperation *operation, NSError *error) {
	    failure(operation, error);
	}];
}

- (void)putWithProject:(RKLIBRMProject *)project uccess:(void (^)(RKObjectRequestOperation *operation, RKLIBRMProject *updatedProject))
    success
               failure:(void (^)(RKObjectRequestOperation *operation, NSError *error))failure {
	NSString *path = [NSString stringWithFormat:@"/projects/%@.%@", project.projectId, kJson];
	[self.objectManager putObject:project path:path parameters:nil success: ^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
	    success(operation, mappingResult.firstObject);
	} failure: ^(RKObjectRequestOperation *operation, NSError *error) {
	    failure(operation, error);
	}];
}

- (void)deleteProjectWithID:(NSNumber *)projectId {
	NSString *path = [NSString stringWithFormat:@"/projects/%@.%@", projectId, kJson];

	[self.objectManager deleteObject:nil path:path parameters:nil success: ^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
	    //
	} failure: ^(RKObjectRequestOperation *operation, NSError *error) {
	    //
	}];
}

#pragma mark issues
/*!
 *  Listing projects
 *
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
- (void)getIssuesWithSuccess:(void (^)(RKObjectRequestOperation *operation, RKLIBRMIssues *issues))success
                     failure:(void (^)(RKObjectRequestOperation *operation, NSError *error))failure {
	NSString *path = [NSString stringWithFormat:@"/issues.%@", kJson];
	[self.objectManager getObjectsAtPath:path parameters:nil success: ^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
	    if ([mappingResult.firstObject isKindOfClass:[RKLIBRMIssues class]]) {
	        success(operation, mappingResult.firstObject);
		}
	} failure: ^(RKObjectRequestOperation *operation, NSError *error) {
	    failure(operation, error);
	}];
}

@end

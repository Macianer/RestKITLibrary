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

/**
 *  Create a Singleton instance.
 *
 *  @return A Singleton instance of RKLIBRMAPIManager.
 */
+ (instancetype)sharedManager {
	static RKLIBRMAPIManager *sharedMapper = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
	    sharedMapper = [[RKLIBRMAPIManager alloc] init];
	});
	return sharedMapper;
}

/**
 *  Configrure the RKLIBRMAPIManager instance with url and login.
 *
 *  @param url      Define the redmine host url as NSString.
 *  @param username Define a specific user name as NSString.
 *  @param password Define a specific user password as NSString.
 */
- (void)configureWithUrl:(NSString *)url withUser:(NSString *)username withPassword:(NSString *)password {
    
    NSParameterAssert(url);
	_url = url;
    
    NSParameterAssert(username);
	_user = username;
    
    NSParameterAssert(password);
	_password = password;
}

- (RKObjectManager *)objectManager {
    
    // check if exists
	if (!_objectManager) {
        // create new manager
        [self _initObjectManager];
	}
	return _objectManager;
}

/*!
 *  Configure a RKObjectManager for Redmine requests.
 */
- (void)_initObjectManager {
	
    RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:[AFHTTPClient clientWithBaseURL:[NSURL URLWithString:_url]]];
    
    // set user and password
	[objectManager.HTTPClient setAuthorizationHeaderWithUsername:_user password:_password];

    // set json minetype
	[objectManager setAcceptHeaderWithMIMEType:RKMIMETypeJSON];


    // define projects response
	RKResponseDescriptor *projectsResponse = [RKResponseDescriptor responseDescriptorWithMapping:[RKLIBRMMappingHelper projectsMapping] method:RKRequestMethodGET pathPattern:@"/projects.json" keyPath:nil statusCodes:[NSIndexSet indexSetWithIndex:RKStatusCodeClassSuccessful]];

    // define projects response
    RKResponseDescriptor *projectResponse = [RKResponseDescriptor responseDescriptorWithMapping:[RKLIBRMMappingHelper projectMapping] method:RKRequestMethodGET pathPattern:@"/projects/:id.json" keyPath:nil statusCodes:[NSIndexSet indexSetWithIndex:RKStatusCodeClassSuccessful]];
    
    // define issues response
	RKResponseDescriptor *issuesResponse = [RKResponseDescriptor responseDescriptorWithMapping:[RKLIBRMMappingHelper issuesMapping] method:RKRequestMethodGET pathPattern:@"/issues.json" keyPath:nil statusCodes:[NSIndexSet indexSetWithIndex:RKStatusCodeClassSuccessful]];
    
    // define single project request
	RKRequestDescriptor *projectRequest = [RKRequestDescriptor requestDescriptorWithMapping:[RKLIBRMMappingHelper projectMapping].inverseMapping objectClass:[RKLIBRMProject class] rootKeyPath:nil method:RKRequestMethodPOST];

    // register projects response
	[objectManager addResponseDescriptor:projectsResponse];
    
    // register single project response
    [objectManager addResponseDescriptor:projectResponse];
    
    // register issues response
	[objectManager addResponseDescriptor:issuesResponse];
    
    // register project request
	[objectManager addRequestDescriptor:projectRequest];
    
	_objectManager = objectManager;
}

#pragma mark project entity

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

#pragma mark issue entity 

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

//http://www.redmine.org/projects/redmine/wiki/Rest_api#Attaching-files

- (NSString *)uploadTokenFromImage:(UIImage *)image withFileName:(NSString *)fileName {
	NSData *imgData = UIImagePNGRepresentation(image);

	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];

	AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:_url]];
	[httpClient setAuthorizationHeaderWithUsername:_user password:_password];

	NSMutableURLRequest *request = [httpClient multipartFormRequestWithMethod:@"POST" path:@"/uploads.json" parameters:nil constructingBodyWithBlock: ^(id < AFMultipartFormData > formData) {
	    [formData appendPartWithFileData:imgData name:fileName fileName:fileName mimeType:@"image/png"];
	}];
	AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
	[operation setCompletionBlockWithSuccess: ^(AFHTTPRequestOperation *operation, id responseObject) {
	    NSString *result = [operation responseString];
	    NSLog(@"response: [%@]", result);
	} failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
	    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	    if ([operation.response statusCode] == 403) {
	        NSLog(@"Upload Failed");
	        return;
		}
	    NSLog(@"error: %@", [operation error]);
	}];
	[operation setUploadProgressBlock: ^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
	    NSLog(@"Sent %lld of %lld bytes", totalBytesWritten, totalBytesExpectedToWrite);
	    //float width = totalBytesWritten / totalBytesExpectedToWrite;
	}];
	[operation start];

//    [operation waitUntilFinished];

	NSString *result = [operation responseString];
	NSLog(@"response: [%@]", result);

	return result;
}

@end

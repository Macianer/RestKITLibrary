//
//  RKLIBRMProject.m
//  RestKit_Redmine_API_Example
//
//  Created by Ronny Meissner on 28.03.14.
//  Copyright (c) 2014 Ronny Meissner. All rights reserved.
//

#import "RKLIBRMProject.h"

@implementation RKLIBRMProject

- (instancetype)projectWithName:(NSString *)name
                 withIdentifier:(NSString *)identifier
                withDescription:(NSString *)description {
	//required
	NSParameterAssert(name);
	NSParameterAssert(identifier);

	RKLIBRMProject *project = [RKLIBRMProject new];
	if (project) {
		project.name = name;
		project.identifier = identifier;
		project.descriptionString = description;
	}
	return project;
}

@end

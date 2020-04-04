// NetmeraUser.h
//
// Created by Yavuz Nuzumlali
// Copyright (c) 2015 Netmera
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//   http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#import <Foundation/Foundation.h>
#import <Netmera/NetmeraBaseModel.h>

extern NSDate *NetmeraNullDate;

typedef NS_ENUM(NSUInteger, NetmeraProfileAttributeGender) {
  NetmeraProfileAttributeGenderFemale = 1,
  NetmeraProfileAttributeGenderMale = 0,
  NetmeraProfileAttributeGenderNotSpecified = 2
};

typedef NS_ENUM(NSUInteger, NetmeraProfileAttributeMaritalStatus) {
  NetmeraProfileAttributeMaritalStatusSingle = 0,
  NetmeraProfileAttributeMaritalStatusMarried = 1,
  NetmeraProfileAttributeMaritalStatusNotSpecified = 2
};

@interface NetmeraUser : NetmeraBaseModel

// Identifier
@property (nonatomic, copy) NSString *userId;

// Attributes
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *MSISDN;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *surname;
@property (nonatomic, copy) NSString *language;
@property (nonatomic, copy) NSDate *dateOfBirth;
@property (nonatomic, assign) NetmeraProfileAttributeGender gender;
@property (nonatomic, assign) NetmeraProfileAttributeMaritalStatus maritalStatus;
@property (nonatomic, assign) NSUInteger numberOfChildren;
@property (nonatomic, copy) NSString *country;
@property (nonatomic, copy) NSString *state;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *district;
@property (nonatomic, copy) NSString *occupation;
@property (nonatomic, copy) NSString *industry;
@property (nonatomic, copy) NSString *favouriteTeam;
@property (nonatomic, copy) NSArray<NSString *> *externalSegments;

@end

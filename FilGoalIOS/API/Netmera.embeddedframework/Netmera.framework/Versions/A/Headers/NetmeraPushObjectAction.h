//
//  NetmeraPushObjectAction.h
//
//
//  Created by Adilcan on 29.06.2017.
//
//

#import <Netmera/NetmeraBaseModel.h>

@interface NetmeraPushObjectAction : NetmeraBaseModel

@property (nonatomic, strong) NSURL *deeplinkURL;

- (instancetype)initWithValue:(id)value;

@end

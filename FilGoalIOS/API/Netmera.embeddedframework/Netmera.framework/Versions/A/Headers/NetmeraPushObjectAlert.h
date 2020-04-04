//
//  NetmeraPushObjectAlert.h
//  
//
//  Created by Yavuz Nuzumlali on 16/11/2016.
//
//

#import <Netmera/NetmeraBaseModel.h>

@interface NetmeraPushObjectAlert : NetmeraBaseModel

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSString *body;

- (instancetype)initWithValue:(id)value;

@end

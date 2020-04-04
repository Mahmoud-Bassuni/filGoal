//
//  NetmeraInAppPurchaseEvent.h
//  Pods
//
//  Created by Yavuz Nuzumlali on 03/09/15.
//
//

#import <Netmera/NetmeraEvent.h>

@interface NetmeraInAppPurchaseEvent : NetmeraEvent

@property (nonatomic, copy, readonly) NSString *productId;
@property (nonatomic, copy, readonly) NSString *productName;
@property (nonatomic, assign, readonly) double price;
@property (nonatomic, strong) NSArray<NSString *> *categoryIds;
@property (nonatomic, strong) NSArray<NSString *> *categoryNames;
@property (nonatomic, assign) NSUInteger count;
@property (nonatomic, strong) NSArray<NSString *> *keywords;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)eventWithId:(NSString *)productId name:(NSString *)productName price:(double)price;

@end

//
//  NetmeraCartAddProductEvent.h
//  Pods
//
//  Created by Yavuz Nuzumlali on 04/09/15.
//
//

#import <Netmera/NetmeraBaseProductEvent.h>

@interface NetmeraCartAddProductEvent : NetmeraBaseProductEvent

@property (nonatomic, assign, readonly) NSUInteger count;

+ (instancetype)eventWithProduct:(NetmeraProduct *)product count:(NSUInteger)productCount;

@end

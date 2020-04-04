/*
 * Copyright 2012 Inomera Research
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "NMNotificationServiceExtension.h"
#import <Netmera/Netmera.h>
NSString * const kNMDataContainerKey = @"_nm";
NSString * const kNMMediaAttachmentURLKey = @"mu";

@interface NMNotificationServiceExtension ()

@property (nonatomic, strong) void (^contentHandler)(UNNotificationContent *contentToDeliver);
@property (nonatomic, strong) UNMutableNotificationContent *bestAttemptContent;

@end

@implementation NMNotificationServiceExtension

- (NSURL *)cacheURL {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask] lastObject];
}

- (void)didReceiveNotificationRequest:(UNNotificationRequest *)request withContentHandler:(void (^)(UNNotificationContent * _Nonnull))contentHandler {
    self.contentHandler = contentHandler;
    self.bestAttemptContent = [request.content mutableCopy];
    NSURL *URL = [NSURL URLWithString:self.bestAttemptContent.userInfo[kNMDataContainerKey][kNMMediaAttachmentURLKey]];

  //  NMLogDebug(@"Start request with URL : %@", URL);
    [[[NSURLSession sharedSession] downloadTaskWithURL:URL completionHandler:^(NSURL *location,
                                                                               NSURLResponse *response,
                                                                               NSError *error) {
        if (error) {
           // NMLogError(@"Attachment download error : %@", [error debugDescription]);
            self.contentHandler(self.bestAttemptContent);
            return;
        }

        CFStringRef MIMETypeRef = (__bridge CFStringRef)[response MIMEType];
        CFStringRef UTIRef = UTTypeCreatePreferredIdentifierForTag(kUTTagClassMIMEType, MIMETypeRef, NULL);
        NSString *UTI = (__bridge_transfer NSString *)UTIRef;

      //  NMLogDebug(@"Response : %@", response);
        //NMLogDebug(@"MIME Type : %@", [response MIMEType]);
       // NMLogDebug(@"UTI : %@", UTI);

        NSURL *newLocation = [NSURL fileURLWithPath:location.lastPathComponent relativeToURL:[self cacheURL]];
        NSError *moveError;
        [[NSFileManager defaultManager] moveItemAtURL:location toURL:newLocation error:&moveError];
        if(moveError) {
           // NMLogError(@"Attachment move error: %@", [moveError debugDescription]);
            self.contentHandler(self.bestAttemptContent);
            return;
        }
        //NMLogDebug(@"URL : %@", newLocation);

        NSError *attachmentError;
        UNNotificationAttachment *attachment = [UNNotificationAttachment
                                                attachmentWithIdentifier:@"attachment"
                                                URL:newLocation
                                                options:@{UNNotificationAttachmentOptionsTypeHintKey : UTI}
                                                error:&attachmentError];
        if (attachmentError) {
          //  NMLogError(@"Attachment create error: %@", [attachmentError debugDescription]);
            self.contentHandler(self.bestAttemptContent);
            return;
        }
       // NMLogDebug(@"Present Attachment : %@", attachment);
        self.bestAttemptContent.attachments = @[attachment];
        self.contentHandler(self.bestAttemptContent);
    }] resume];
}

- (void)serviceExtensionTimeWillExpire {
  //  NMLogDebug(@"Timeout!!");
    self.contentHandler(self.bestAttemptContent);
}

@end

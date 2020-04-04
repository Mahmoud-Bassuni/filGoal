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

#import <Foundation/Foundation.h>
#import <Netmera/NMLogLevel.h>

#define __NetmeraLogWithLevel(level, format, ...) \
  do { \
    if(level > [NMLogger logLevel]) break; \
    NSString *log = [NSString stringWithFormat:format, ##__VA_ARGS__]; \
    NSString *sym; \
    if(level == NMLogLevelError) { \
      sym = @"❗"; \
    } else if(level == NMLogLevelDebug) { \
      sym = @"🐛"; \
    } \
    NSLog(@"\n\n%@ %s (%@:%d) %@\n%@\n\n", sym, __PRETTY_FUNCTION__, @(__FILE__).lastPathComponent, __LINE__, sym, log); \
} while(0)

#define NMLogError(format, ...) __NetmeraLogWithLevel(NMLogLevelError, format, ##__VA_ARGS__)
#define NMLogDebug(format, ...) __NetmeraLogWithLevel(NMLogLevelDebug, format, ##__VA_ARGS__)

@interface NMLogger : NSObject

+ (NMLogLevel)logLevel;
+ (void)setLogLevel:(NMLogLevel)level;

@end

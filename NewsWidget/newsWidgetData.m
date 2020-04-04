//
//  MatchesWidgetData.m
//  FilGoalIOS
//
//  Created by Yomna Ahmed on 11/2/14.
//  Copyright (c) 2014 MohamedMansour . All rights reserved.
//

#import "newSWidgetData.h"
#import "AsyncImageView.h"
@implementation newSWidgetData

+ (void)getWidgetNewsData: (NSURL *)widgetNewsUrl  success:(void (^)(NSArray* newsList))success failure:(void (^)(NSError *error))failure{

    NSError *error;
   NSString *stringFromFileAtURL = [[NSString alloc]
                                    initWithContentsOfURL:widgetNewsUrl
                                    encoding:NSUTF8StringEncoding
                                    error:&error];
 
    stringFromFileAtURL=[stringFromFileAtURL stringByReplacingOccurrencesOfString:@"null" withString:@"\"\""];
    
    if (stringFromFileAtURL == nil) {
      failure(error);
    }
   /* "articles": [
                 {
                     "id": "19205830",
                     "title": "بعد إعلان الترشح لمنصب العميد.. تعرف على الوكالة الجامعية للفرانكفونية",
                     "description": "اعلن المجلس الاعلي للجامعات فتح باب الترشح لمنصب \"عميد الوكاله الجامعيه للفرانكفونيه\"، والذي يعد المدير التنفيذي للمؤسسه، موضحًا انه يجب علي المترشح تقديم السيره الذاتيه الخاصه به، بالاضافه الي مشروع لتطوير عمل الوكاله للاربع اعوام المقبله.\\nوتعد الوكا...",
                     "photo": "http://assets2.akhbarak.net/photos/articles-photos/2015/7/7/19205830/19205830-v2_large.jpg?1436278144",
                     "thumbnail": "http://assets2.akhbarak.net/photos/articles-photos/2015/7/7/19205830/19205830-v2_medium.jpg?1436278144",
                     "sources": "الوطن",
                     "time_ago": "13 دقائق",
                     "published_at": "2015-07-07T16:08:57+02:00"
                 }‎*/
    else {
        NSData *jsonData = [stringFromFileAtURL dataUsingEncoding:NSUTF8StringEncoding];
        NSError *e;
        NSDictionary *newsDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&e];
         NSArray *newList=[newsDictionary objectForKey:@"articles"];
              // NSArray *newList;
        NSMutableArray *NewsModelList=[[NSMutableArray alloc]init];
        for (int i=0; i<newList.count; i++) {
            NewsWidgetModel *NWM=[[NewsWidgetModel alloc]init];
            NSDictionary *NWMDictionary =newList[i];
          NWM.article_id  =[NWMDictionary objectForKey:@"news_id"];
         NWM.article_title   =[NWMDictionary objectForKey:@"news_title"];
        //  NWM.img_url  =[NWMDictionary objectForKey:@"photo"];
           //NWM.thumbnail =[NWMDictionary objectForKey:@"thumbnail"];
            NWM.thumbnail =[NWMDictionary objectForKey:@"thumbnail"];
           // NWM.articleImage=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:NWM.thumbnail]]];
         // NWM.resources  =[NWMDictionary objectForKey:@"sources"];
         //  NWM.pubDate =[NWMDictionary objectForKey:@"time_ago"];
            [NewsModelList addObject:NWM];
        }
        
        success((NSArray*)NewsModelList);
    }
}
@end

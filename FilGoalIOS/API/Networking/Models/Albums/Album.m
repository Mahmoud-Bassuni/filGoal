//
//	Album.m
//
//	Create by Nada Gamal on 20/9/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "Album.h"
#import "NewsSectionId.h"
NSString *const kAlbumPicName = @"PicName";
NSString *const kAlbumPicsCount = @"PicsCount";
NSString *const kAlbumViews = @"Views";
NSString *const kAlbumAlbumDate = @"album_date";
NSString *const kAlbumAlbumId = @"album_id";
NSString *const kAlbumSectionId = @"album_section_id";
NSString *const kAlbumAlbumSourcedate = @"album_sourcedate";
NSString *const kAlbumAlbumSubtitle = @"album_subtitle";
NSString *const kAlbumAlbumTitle = @"album_title";
NSString *const kAlbumDescription = @"story";
NSString *const kAlbumByline = @"byline";
NSString *const kAlbumEditorId = @"editor_id";
NSString *const kAlbumPictures = @"pictures";
NSString *const kInfoRelatedAlbums = @"relatedAlbums";
NSString *const kAlbumClassRelatedData = @"related_data";

@interface Album ()
@end
@implementation Album




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kAlbumPicName] isKindOfClass:[NSNull class]]){
		self.picName = dictionary[kAlbumPicName];
	}	
	if(![dictionary[kAlbumPicsCount] isKindOfClass:[NSNull class]]){
		self.picsCount = [dictionary[kAlbumPicsCount] integerValue];
	}

	if(![dictionary[kAlbumViews] isKindOfClass:[NSNull class]]){
		self.views = [dictionary[kAlbumViews] integerValue];
	}

	if(![dictionary[kAlbumAlbumDate] isKindOfClass:[NSNull class]]){
		self.albumDate = dictionary[kAlbumAlbumDate];
//        int offset=2;
//        if ([Global getInstance].appInfo) {
//            offset=[[Global getInstance].appInfo.timeoff intValue];
//        }
        int offset = [[[NSUserDefaults standardUserDefaults]objectForKey:TIME_OFFSET]intValue];
//        NSDate *date = [NSDate dateWithTimeIntervalSince1970:(([self.albumDate doubleValue]+(1000*60*60*offset)) / 1000)];
//        NSDateFormatter *dtfrm = [[NSDateFormatter alloc] init];
//        [dtfrm setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
//        [dtfrm setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"ar"]];
//        [dtfrm setDateFormat:@"EEEE dd MMMM yyyy hh:mm"];
//        self.albumDate = [dtfrm stringFromDate:date];
//        
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:(([self.albumDate doubleValue]+(1000*60*60*offset)) / 1000)];
        NSDateFormatter *dtfrm = [[NSDateFormatter alloc] init];
        [dtfrm setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
        [dtfrm setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"ar"]];
        [dtfrm setDateFormat:@"EEEE dd MMMM yyyy hh:mm"];
        // [dtfrm setDateStyle:NSDateFormatterLongStyle];
        self.albumDate = [dtfrm stringFromDate:date];
        if(![dictionary[kAlbumClassRelatedData] isKindOfClass:[NSNull class]]){
            self.relatedData = [[RelatedData alloc] initWithDictionary:dictionary[kAlbumClassRelatedData]];
        }
        
	}
    if(![dictionary[kAlbumDescription] isKindOfClass:[NSNull class]]){
        self.albumDescription = dictionary[kAlbumDescription];
    }
    
	if(![dictionary[kAlbumAlbumId] isKindOfClass:[NSNull class]]){
		self.albumId = [dictionary[kAlbumAlbumId] integerValue];
	}
//    if(![dictionary[kAlbumSectionId] isKindOfClass:[NSNull class]]){
//        self.sectionId = [dictionary[kAlbumSectionId] integerValue];
//    }
    NSMutableArray *albumSectionIds = [NSMutableArray array];
    if ([dictionary[kAlbumSectionId] isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)dictionary[kAlbumSectionId]) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [albumSectionIds addObject:[NewsSectionId modelObjectWithDictionary:item]];
            }
        }
        self.sectionIds=albumSectionIds;
    }
    
	if(![dictionary[kAlbumAlbumSourcedate] isKindOfClass:[NSNull class]]){
		self.albumSourcedate = dictionary[kAlbumAlbumSourcedate];
	}	
	if(![dictionary[kAlbumAlbumSubtitle] isKindOfClass:[NSNull class]]){
		self.albumSubtitle = dictionary[kAlbumAlbumSubtitle];
	}	
	if(![dictionary[kAlbumAlbumTitle] isKindOfClass:[NSNull class]]){
		self.albumTitle = dictionary[kAlbumAlbumTitle];
	}	
	if(![dictionary[kAlbumByline] isKindOfClass:[NSNull class]]){
		self.byline = dictionary[kAlbumByline];
	}	
	if(![dictionary[kAlbumEditorId] isKindOfClass:[NSNull class]]){
		self.editorId = [dictionary[kAlbumEditorId] integerValue];
	}

	if(dictionary[kAlbumPictures] != nil && [dictionary[kAlbumPictures] isKindOfClass:[NSArray class]]){
		NSArray * picturesDictionaries = dictionary[kAlbumPictures];
		NSMutableArray * picturesItems = [NSMutableArray array];
		for(NSDictionary * picturesDictionary in picturesDictionaries){
			Picture * picturesItem = [[Picture alloc] initWithDictionary:picturesDictionary];
			[picturesItems addObject:picturesItem];
		}
		self.pictures = picturesItems;
	}
    if(dictionary[kInfoRelatedAlbums] != nil && [dictionary[kInfoRelatedAlbums] isKindOfClass:[NSArray class]]){
        NSArray * relatedAlbumsDictionaries = dictionary[kInfoRelatedAlbums];
        NSMutableArray * relatedAlbumsItems = [NSMutableArray array];
        for(NSDictionary * relatedAlbumsDictionary in relatedAlbumsDictionaries){
            Album * relatedAlbumsItem = [[Album alloc] initWithDictionary:relatedAlbumsDictionary];
            [relatedAlbumsItems addObject:relatedAlbumsItem];
        }
        self.relatedAlbums = relatedAlbumsItems;
    }
	return self;
}
- (BOOL)isEqual:(Album*)other {
    if (other == self)
        return YES;
    if (![super isEqual:other])
        return NO;
    return self.albumId==other.albumId; // class-specific
}
@end

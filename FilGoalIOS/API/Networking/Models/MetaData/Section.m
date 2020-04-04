
#import "Section.h"
#import "ChampId.h"
@interface Section ()
@end
@implementation Section




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(![dictionary[@"ChampId"] isKindOfClass:[NSNull class]]){
        self.champId = [dictionary[@"ChampId"] integerValue];
    }
    
    if(dictionary[@"ChampIds"] != nil && [dictionary[@"ChampIds"] isKindOfClass:[NSArray class]]){
        NSArray * champIdsDictionaries = dictionary[@"ChampIds"];
        NSMutableArray * champIdsItems = [NSMutableArray array];
        for(NSDictionary * champIdsDictionary in champIdsDictionaries){
            ChampId * champIdsItem = [[ChampId alloc] initWithDictionary:champIdsDictionary];
            [champIdsItems addObject:champIdsItem];
        }
        self.champIds = champIdsItems;
    }
    if(![dictionary[@"parent_id"] isKindOfClass:[NSNull class]]){
        self.parentId = [dictionary[@"parent_id"] integerValue];
    }
    
    if(![dictionary[@"section_id"] isKindOfClass:[NSNull class]]){
        self.sectionId = [dictionary[@"section_id"] integerValue];
    }
    
    if(![dictionary[@"section_name"] isKindOfClass:[NSNull class]]){
        self.sectionName = dictionary[@"section_name"];
    }
    return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    dictionary[@"ChampId"] = @(self.champId);
    if(self.champIds != nil){
        NSMutableArray * dictionaryElements = [NSMutableArray array];
        for(ChampId * champIdsElement in self.champIds){
            [dictionaryElements addObject:[champIdsElement toDictionary]];
        }
        dictionary[@"ChampIds"] = dictionaryElements;
    }
    dictionary[@"parent_id"] = @(self.parentId);
    dictionary[@"section_id"] = @(self.sectionId);
    if(self.sectionName != nil){
        dictionary[@"section_name"] = self.sectionName;
    }
    return dictionary;
    
}

/**
 * Implementation of NSCoding encoding method
 */
/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:@(self.champId) forKey:@"ChampId"];	if(self.champIds != nil){
        [aCoder encodeObject:self.champIds forKey:@"ChampIds"];
    }
    [aCoder encodeObject:@(self.parentId) forKey:@"parent_id"];	[aCoder encodeObject:@(self.sectionId) forKey:@"section_id"];	if(self.sectionName != nil){
        [aCoder encodeObject:self.sectionName forKey:@"section_name"];
    }
    
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.champId = [[aDecoder decodeObjectForKey:@"ChampId"] integerValue];
    self.champIds = [aDecoder decodeObjectForKey:@"ChampIds"];
    self.parentId = [[aDecoder decodeObjectForKey:@"parent_id"] integerValue];
    self.sectionId = [[aDecoder decodeObjectForKey:@"section_id"] integerValue];
    self.sectionName = [aDecoder decodeObjectForKey:@"section_name"];
    return self;
    
}
@end
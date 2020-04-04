//
//  Global.m

//
//

#import "Global.h"
#import "ActiveChampion.h"

@implementation Global

@synthesize metaData;



static Global * instance =nil;
- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        _viewsCount = 0;
    }
    
    return self;
}

+(Global *) getInstance
{
    @synchronized(self)
    {
        if(instance==nil)
        {
            
            instance= [Global new];
        }
    }
    return instance;
}
-(Champion*)getChampById:(int)champId{

    for (Champion *champ in self.metaData.champions) {
        if (champ.champId==champId) {
            return champ;
        }
    }
    return nil;
}
-(BOOL)isActiveChampion:(int)champId andRoundId:(int)roundId{
    
    for (ActiveChampion *champ in self.activePredictionchampions) {
        if (champ.champId==champId) {
            if(champ.roundIds>0){
                if([champ.roundIds containsObject:@(roundId)]){
                    return YES;
                }
                return YES;
            }
            return YES;
        }
    }
    return NO;
}
-(Section*)getSectionItemWithSectionID:(NSInteger)sectionID
{
    NSArray * sections = [Global getInstance].metaData.sections;
    for (int i=0; i<sections.count; i++) {
        if([(Section*)[sections objectAtIndex:i]sectionId]==sectionID)
        {
            return (Section*)[sections objectAtIndex:i];
        }
    }
    return [[Section alloc]init];
    
}

@end

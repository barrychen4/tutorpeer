// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TPConversation.h instead.

#import <CoreData/CoreData.h>
#import "TPSyncEntity.h"

@interface TPConversationID : TPSyncEntityID {}
@end

@interface _TPConversation : TPSyncEntity {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) TPConversationID* objectID;

@end

@interface _TPConversation (CoreDataGeneratedPrimitiveAccessors)

@end

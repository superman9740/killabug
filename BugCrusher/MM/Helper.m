//
//  Helper.m
//  Tapcraft
//
//  Created by Sanny on 1/2/13.
//
//

#import "Helper.h"
@interface Helper ()
@end
@implementation Helper

-(id) init
{
    self = [super init];
    if (self) {
        
                
    }
    return self;

}


-(void) saveDataToFile:(NSString*) filename forTitle:(NSString*)title what:(NSString*) this
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *docPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",filename]];
    NSMutableDictionary* updateVal=[[NSMutableDictionary alloc]initWithContentsOfFile:docPath];
    [updateVal setObject:this forKey:title];
    [updateVal writeToFile:docPath atomically:NO];


}
-(BOOL) copyThisFileToRoot:(NSString*) fileName
{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    
    
    NSString *path = [documentsDirectory stringByAppendingPathComponent:fileName];
    
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:path])
        
    {
        
        NSDictionary *temp = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"settings" ofType:@"plist"]];
        
        
        NSDictionary *glossary = [NSDictionary dictionaryWithDictionary:temp];
        if ([glossary writeToFile: path atomically: YES] == NO)
        {
            
            NSLog(@"Archiving Failed!");
            return NO;
            
        }
        
        } else
        {
        NSLog(@"File(s) Are Exist.");
        return YES;
        
    }
    
      
    NSLog(@"File Create successfully.");
    return YES;

}


-(BOOL) makeFileWithName:(NSString*)Filename andWriteToIt:(NSDictionary*) dic
{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    
    
    NSString *path = [documentsDirectory stringByAppendingPathComponent:Filename];
    
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:path])
        
    {
        NSDictionary *glossary = [NSDictionary dictionaryWithDictionary:dic];
        if ([glossary writeToFile: path atomically: YES] == NO)
        {

            NSLog(@"Archiving Failed!");
            return NO;

        }
        
    } else
    {
         NSLog(@"File(s) Are Exist.");
        
        return YES;
    }
    

       NSLog(@"File Create successfully.");

    return YES;
}

-(NSString*) getStringFromFile:(NSString*)filePath What:(NSString*) this
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    
    NSString *path = [documentsDirectory stringByAppendingPathComponent:filePath];
    
    
    NSDictionary *glossaryBack = [[NSDictionary alloc] init];
    glossaryBack = [NSDictionary dictionaryWithContentsOfFile: path];
    
    
    
    return [glossaryBack objectForKey: this];
}

-(NSDictionary*) settings
{
    NSDictionary *glossary = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"ON" ,@"sounds",
                              @"0" , @"scoreArcade",
                              @"0" , @"scoreZen",
                              @"0" , @"FR",
                              @"0" , @"Rated",
                              @"0" , @"PlayedTimes",
                              @"0" , @"ADS",


                  
                           nil];
    
    return glossary;
    
}





@end

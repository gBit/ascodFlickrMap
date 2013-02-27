//
//  MMViewController.m
//  ASCODMap
//
//  Created by James Donner on 2/25/13.
//  Copyright (c) 2013 jdsv650. All rights reserved.
//

#import "MMViewController.h"
#import "MMTableViewController.h"

@interface MMViewController ()
{
    NSDictionary *resultsAsDictionary;
    NSMutableArray *photosArray;
    NSMutableArray *photos;
    __weak IBOutlet UITextField *searchText;
}

- (IBAction)searchButton:(id)sender;


@end

@implementation MMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    photos = [[NSMutableArray alloc] init];
    
	// Do any additional setup after loading the view, typically from a nib.
}



-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    MMTableViewController *tvc = [segue destinationViewController];
    
    // return 20 items max
        for(int i=0; i < 20; i++)
         {
             if (i >= photosArray.count)
                 break;
             
             [photos insertObject:[photosArray objectAtIndex:i] atIndex:i];
        }

    tvc.photosArray = photos;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)searchButton:(id)sender
{
    double radius = 5.0;
   
    
    NSString *flickrCustomURLString = [NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=9752319060f3fd77e514166ab2771c72&tags=%@&format=json&nojsoncallback=1&lat=41.894032&lon=-87.634742&radius=%f", searchText.text, radius];
    
    NSURL *flickrURL = [NSURL URLWithString:flickrCustomURLString];
    NSURLRequest *flickrRequest = [NSURLRequest requestWithURL:flickrURL];
    
    [NSURLConnection sendAsynchronousRequest:flickrRequest
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *myData, NSError *error) {
                               if (error)
                               {
                                   NSLog(@"%@", error);
                               }
                               else
                               {
                                   NSError *jsonError;
                                   id genericResults = [NSJSONSerialization JSONObjectWithData:myData
                                                                                       options:NSJSONReadingAllowFragments
                                                                                         error:&jsonError];
                                   
                                   
                                   resultsAsDictionary = (NSDictionary *) genericResults;
                                   
                                   photosArray = [[resultsAsDictionary valueForKey:@"photos"] valueForKey:@"photo"];
                                   
                                 //  NSLog(@"%@", photosArray);
                                   
                                   [self performSegueWithIdentifier:@"tableViewSegue" sender:self];
                                   
                               }
                           } ];
}

@end

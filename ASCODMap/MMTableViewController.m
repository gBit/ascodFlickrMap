//
//  MMTableViewController.m
//  ASCODMap
//
//  Created by James Donner on 2/25/13.
//  Copyright (c) 2013 jdsv650. All rights reserved.
//

#import "MMTableViewController.h"
#import "MMMapViewController.h"

@interface MMTableViewController ()
{
    
    __weak IBOutlet UITableView *tableViewOutlet;
    NSDictionary *pictDict;
    UIImage *selectedImage;
}
@end

@implementation MMTableViewController

@synthesize photosArray;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if([segue.identifier isEqualToString:@"mapSegue"]) {
        MMMapViewController *mvc = [segue destinationViewController];
        mvc.pictDict = pictDict;
        mvc.selectedImage = selectedImage;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    // Return the number of rows in the section.
    return photosArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
        
    }
    
    NSDictionary *photoDict = [photosArray objectAtIndex:indexPath.row];
    NSString *farmString = [photoDict valueForKey:@"farm"];
    NSString *serverString = [photoDict valueForKey:@"server"];
    NSString *idString = [photoDict valueForKey:@"id"];
    NSString *secretString = [photoDict valueForKey:@"secret"];
    
    NSString *flickrURLString = [NSString stringWithFormat:@"http://farm%@.staticflickr.com/%@/%@_%@_q.jpg", farmString, serverString, idString, secretString];
    
    // NSLog(@"%@", flickrURLString);
    
    NSURL *flickrURL = [NSURL URLWithString:flickrURLString];
    NSData *flickrData = [NSData dataWithContentsOfURL:flickrURL];
    UIImage *myImage = [UIImage imageWithData:flickrData];
    
    cell.imageView.image = myImage;
    cell.textLabel.text = [photoDict valueForKey:@"ownername"];
    cell.detailTextLabel.text = [photoDict valueForKey:@"title"];
    cell.textLabel.textColor = [UIColor blueColor];
    
    // http://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}_m.jpg
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    pictDict = [photosArray objectAtIndex:indexPath.row];
    
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    selectedImage = selectedCell.imageView.image;
    
    [self performSegueWithIdentifier:@"mapSegue" sender:self];
    
}

@end

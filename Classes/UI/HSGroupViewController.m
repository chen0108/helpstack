//
//  HAZendDeskGroupViewController.m
//  HelpApp
//
//  Created by Tenmiles on 28/10/13.
//  Copyright (c) 2013 Anand. All rights reserved.
//

#import "HSGroupViewController.h"
#import "HSArticleDetailViewController.h"
#import "HSHelpStack.h"
#import "HSTableViewCell.h"

@interface HSGroupViewController ()

@end

@implementation HSGroupViewController

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
    
    [self.kbSource prepareKB:^{
        [self.tableView reloadData];
    } failure:^(NSError* e){
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Couldnt load articles" message:@"Error in loading articles. Please check your internet connection." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alertView show];

    }];
    self.title = self.selectedKB.title;
    
    HSAppearance* appearance = [[HSHelpStack instance] appearance];
    self.view.backgroundColor = [appearance getBackgroundColor];

    /* This dummy footer view is added to the table view to remove the separator lines between empty cells */
    self.tableView.tableFooterView = [UIView new];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return 1;
    }else{
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [self.kbSource kbCount:HAGearTableTypeSearch];
    }else{
        return [self.kbSource kbCount:HAGearTableTypeDefault];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        
        static NSString* resultCellId = @"Cell";
        HSTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:resultCellId];
        if (!cell) {
            cell = [[HSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:resultCellId];
        }
        
        HSKBItem* article = [self.kbSource table:HAGearTableTypeSearch kbAtPosition:indexPath.row];
        cell.textLabel.text = article.title;
        
        cell.accessoryType = UITableViewCellAccessoryNone;

        return cell;

    }else{
        static NSString *CellIdentifier = @"HelpCell";
        HSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[HSTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        HSKBItem* article = [self.kbSource table:HAGearTableTypeDefault kbAtPosition:indexPath.row];
        cell.textLabel.text = article.title;
        cell.accessoryType = UITableViewCellAccessoryNone;

        return cell;

    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        [self table:HAGearTableTypeSearch articleSelectedAtIndexPath:indexPath.row];
        
    }else{
        [self table:HAGearTableTypeDefault articleSelectedAtIndexPath:indexPath.row];
    }
}

-(void) table:(HAGearTableType)table articleSelectedAtIndexPath:(NSInteger) position {
    HSKBItem* selectedKB = [self.kbSource table:table kbAtPosition:position];
    HSKBItemType type = HSKBItemTypeArticle;
    type = selectedKB.itemType;
    if(type == HSKBItemTypeSection) {
        HSKBSource* newSource = [self.kbSource sourceForSection:selectedKB];
        HSGroupViewController* controller = [self.storyboard instantiateViewControllerWithIdentifier:@"HAGroupController"];
        controller.kbSource = newSource;
        controller.selectedKB = selectedKB;
        [self.navigationController pushViewController:controller animated:YES];
    }
    else {
        HSArticleDetailViewController* controller = [self.storyboard instantiateViewControllerWithIdentifier:@"HAArticleController"];
        controller.article = selectedKB;
        [self.navigationController pushViewController:controller animated:YES];
    }
    
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterArticlesforSearchString:searchString];
    return NO;
}

- (void)filterArticlesforSearchString:(NSString*)string
{
    [self.kbSource filterKBforSearchString:string success:^{
        [self.searchDisplayController.searchResultsTableView reloadData];
    } failure:^(NSError* e){
        
    }];
}

@end
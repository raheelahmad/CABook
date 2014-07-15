//
//  ListViewController.swift
//  CABook
//
//  Created by Raheel Ahmad on 7/5/14.
//  Copyright (c) 2014 Sakun Labs. All rights reserved.
//

import UIKit

struct List {
    static let chapters =
		[
            [chapterKey: "Chapter 3", exercisesKey: [ "Clock" ]],
            [chapterKey: "Chapter 4", exercisesKey: [ "Masks", "GroupOpacity" ]],
            [chapterKey: "Chapter 5", exercisesKey: [ "Perspective", "SublayerTransform", "Backview", "Flattening" ]],
        ]
	static let nameKey = "name"
	static let chapterKey = "chapterName"
	static let exercisesKey = "exercises"
	
    static let cellId = "Plain"
}

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
		title = "CA: Advanced Techniques"

        let frame = self.view.bounds
        let table = UITableView(frame: frame, style: .Plain)
        table.delegate = self
        table.dataSource = self
        table.registerClass(UITableViewCell.self, forCellReuseIdentifier: List.cellId)
        
        view.addSubview(table)
    }

}

extension ListViewController {
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if let exercise = exerciseForIndexPath(indexPath) {
            let viewControllerName = exercise + "ViewController"
            println(viewControllerName)
            let vcClass = NSClassFromString(viewControllerName) as NSObject.Type
            let vc = vcClass.self() as UIViewController
            self.navigationController.pushViewController(vc, animated: true)
        }
    }
}

extension ListViewController {
	func tableView(tableView: UITableView!, titleForHeaderInSection section: Int) -> String! {
		if let chapterInfo = chapterInfoForSection(section) {
			return chapterInfo[List.chapterKey] as String
		} else {
			return nil
		}
	}

    func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return List.chapters.count
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
		if let exercises = exercisesForSection(section) {
			return exercises.count
		} else {
			return 0
		}
    }
	
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell = tableView.dequeueReusableCellWithIdentifier(List.cellId, forIndexPath: indexPath) as UITableViewCell
		cell.accessoryType = .DisclosureIndicator
		if let exercise = exerciseForIndexPath(indexPath) {
			cell.textLabel.text = exercise
        }
        return cell
    }
}

extension ListViewController {
	
	func exerciseForIndexPath(indexPath: NSIndexPath) -> String? {
		if let exercises = exercisesForSection(indexPath.section) {
			if exercises.count > indexPath.row {
				return exercises[indexPath.row]
			}
		}
		return nil
	}
	
	func exercisesForSection(section: Int) -> [String]? {
		if let chapterInfo = chapterInfoForSection(section) {
			let exercises = chapterInfo[List.exercisesKey] as [String]
			return exercises
		} else {
			return nil
		}
	}
	
	func chapterInfoForSection(section: Int) -> NSDictionary? {
		if section < List.chapters.count {
			let sectionInfo = List.chapters[section] as Dictionary<String, Any>
			return sectionInfo
		} else {
			return nil
		}
	}
}

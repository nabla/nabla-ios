//
//  ViewController.swift
//  Playground
//
//  Created by Tanguy Helesbeux on 17/03/2022.
//

import NablaCore
import UIKit

public class ViewController: UIViewController {
    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        let label = UILabel()
        label.text = NablaCore().text
        label.numberOfLines = 0
        label.textAlignment = .center
        label.sizeToFit()
        view.addSubview(label)
        label.center = view.center
    }
}

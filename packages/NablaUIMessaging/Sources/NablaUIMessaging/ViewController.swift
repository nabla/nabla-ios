//
//  ViewController.swift
//  Playground
//
//  Created by Tanguy Helesbeux on 17/03/2022.
//

import NablaCore
import NablaUtils
import UIKit

public class ViewController: UIViewController {
    // MARK: Init

    public init() {
        // Temporary example, move elsewhere for "real" instances
        Resolver.shared.register(type: NablaUtils.self, NablaUtils())

        super.init(nibName: nil, bundle: nil)
    }

    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Life cycle

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

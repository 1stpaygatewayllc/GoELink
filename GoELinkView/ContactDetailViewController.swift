//
//  ImageDetailViewController.swift
//  GoELink
//
//  Created by Yoichi Tagaya on 8/24/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

import UIKit
import ReactiveCocoa
import GoELinkViewModel

public final class ContactDetailViewController: UIViewController {
    public var viewModel: ContactDetailViewModeling?
    
    @IBOutlet weak var objectIdLabel: UILabel!
    
    @IBOutlet weak var firstNameLabel: UILabel!
    
    @IBOutlet weak var lastNameLabel: UILabel!
    
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var submitButton: UIButton!
    
    var submitService: DummySubmitService!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.submitService = DummySubmitService()
        
        if let viewModel = viewModel {
            viewModel.objectId.producer
                .on(next: { self.objectIdLabel.text = $0 })
                .start()
            viewModel.firstNameText.producer
                .on(next: { self.firstNameTextField.text = $0 })
                .start()
            viewModel.lastNameText.producer
                .on(next: { self.lastNameTextField.text = $0 })
                .start()
//            viewModel.tagText.producer
//                .on(next: { self.tagLabel.text = $0 })
//                .start()
//            viewModel.usernameText.producer
//                .on(next: { self.usernameLabel.text = $0 })
//                .start()
//            viewModel.pageImageSizeText.producer
//                .on(next: { self.imageSizeLabel.text = $0 })
//                .start()
//            viewModel.viewCountText.producer
//                .on(next: { self.viewCountLabel.text = $0 })
//                .start()
//            viewModel.downloadCountText.producer
//                .on(next: { self.downloadCountLabel.text = $0 })
//                .start()
//            viewModel.likeCountText.producer
//                .on(next: { self.likeCountLabel.text = $0 })
//                .start()
            
            let validFirstNameSignal = self.firstNameTextField.rac_textSignal().toSignalProducer()
                .map { self.isValidFirstName($0 as! String) }
            
            let validLastNameSignal = self.lastNameTextField.rac_textSignal().toSignalProducer()
                .map { self.isValidLastName($0 as! String) }
            
            validFirstNameSignal.map { $0 ? UIColor.clearColor() : UIColor.yellowColor() }
                .startWithNext { self.firstNameTextField.backgroundColor = $0 }
            
            validLastNameSignal.map { $0 ? UIColor.clearColor() : UIColor.yellowColor() }
                .startWithNext { self.lastNameTextField.backgroundColor = $0 }
            
            
            let submitActiveSignal = combineLatest(validFirstNameSignal, validLastNameSignal).map { $0 && $1 }
            submitActiveSignal.startWithNext { self.submitButton.enabled = $0 }
            
            
            self.submitButton.rac_signalForControlEvents(.TouchUpInside).toSignalProducer()
                .on(next: { _ in
                    self.submitButton.enabled = false
//                    self.submitFailureText.hidden = true

                })
                .flatMap(FlattenStrategy.Merge, transform: { _ in self.submitSignal() })
                .startWithNext { success in
                    self.submitButton.enabled = true
//                    self.signInFailureText.hidden = success
                    if (success) {
//                        self.performSegueWithIdentifier("submitSuccess", sender: self)
                        print("Success on submit!!")
                    }
            }
            
        }
    }
    
    func submitSignal() -> SignalProducer<Bool, NSError> {
        return SignalProducer { (o: Observer<Bool, NSError>, _) -> () in
            self.submitService.signInWithUsername(self.firstNameTextField.text!, lastname: self.lastNameTextField.text!, complete: { (success) -> () in
                o.sendNext(success)
                o.sendCompleted()
            })
        }
    }
    
    func isValidLastName(lastname: String) -> Bool {
        return lastname.characters.count > 3;
    }
    
    func isValidFirstName(firstname: String) -> Bool {
        return firstname.characters.count > 3;
    }
    



    
    
//    @IBOutlet weak var imageView: UIImageView!
//    @IBOutlet weak var tagLabel: UILabel!
//    @IBOutlet weak var usernameLabel: UILabel!
//    @IBOutlet weak var imageSizeLabel: UILabel!
//    @IBOutlet weak var viewCountLabel: UILabel!
//    @IBOutlet weak var downloadCountLabel: UILabel!
//    @IBOutlet weak var likeCountLabel: UILabel!
    
//    @IBAction func openImagePage(sender: UIBarButtonItem) {
//        let actionText = LocalizedString("ContactDetailViewController_ActionSheetViewInSafari", comment: "Action sheet button text.")
//        let cancelText = LocalizedString("ContactDetailViewController_ActionSheetCancel", comment: "Action sheet button text.")
//        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
//        alertController.addAction(UIAlertAction(title: actionText, style: UIAlertActionStyle.Default) { _ in
////            viewModel?.openImagePage()
//        })
//        alertController.addAction(UIAlertAction(title: cancelText, style: .Cancel, handler: nil))
//        self.presentViewController(alertController, animated: true, completion: nil)
//    }
}


class DummySubmitService {
    func signInWithUsername(firstname: String, lastname: String, complete completeBlock:(Bool) -> ()) {
        let delayInSeconds: Double = 1.0
        
        let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delayInSeconds * Double(NSEC_PER_SEC)))
        dispatch_after(popTime, dispatch_get_main_queue(), {
            let success = firstname != "" && lastname != ""
            completeBlock(success)
        })
    }
}

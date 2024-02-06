//
//  notificationDetailViewController.swift
//  Rich_Push_Notifications
//
//  Created by Vishal on 06/02/24.
//

import UIKit

class notificationDetailViewController: UIViewController {
    
    @IBOutlet var imageContainerView: UIView!
    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var searchView: UIView!
    @IBOutlet var searchTxtField: UITextField!
    @IBOutlet var searchBtn: UIButton!
    
    // detail Outlets
    @IBOutlet var detailContainerView: UIView!
    @IBOutlet var notificationTitle: UILabel!
    @IBOutlet var notificationSubTitle: UILabel!
    @IBOutlet var notificationPriceView: UIView!
    @IBOutlet var notificationDetailTextView: UITextView!
    
    @IBOutlet var orderNowBtn: UIButton!
    
    // Strings
    var ntfTitle: String?
    var ntfSubtitle: String?
    var ntfDetailTextView: String?
    var ntfImage:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        notificationPriceView.layer.cornerRadius = 10
        notificationPriceView.clipsToBounds = true
        
        searchView.layer.cornerRadius = 15
        searchView.clipsToBounds = true
        
        notificationPriceView.layer.borderWidth = 1
        notificationPriceView.layer.borderColor = UIColor.red.cgColor
        notificationPriceView.layer.cornerRadius = 15
        notificationPriceView.clipsToBounds = true
        
        orderNowBtn.layer.cornerRadius = 15
        
        imageContainerView.layer.cornerRadius = 50
        imageContainerView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        imageContainerView.clipsToBounds = true
        
        notificationTitle.text = ntfTitle
        notificationSubTitle.text = ntfSubtitle
        notificationDetailTextView.text = ntfDetailTextView
        productImageView.image = ntfImage
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension notificationDetailViewController : UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.backgroundColor = UIColor.lightGray
        textView.isEditable = false
        textView.isUserInteractionEnabled = true
        textView.isScrollEnabled = true
    }
}

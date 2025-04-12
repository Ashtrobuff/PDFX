//
//  ViewModelFactory.swift
//  pdfApp
//
//  Created by Ashish on 04/04/25.
//

import Foundation

class ViewModelFactory:ObservableObject
{
    func makeMergVm()->MergeViewModel
    {
        return MergeViewModel()
    }
}

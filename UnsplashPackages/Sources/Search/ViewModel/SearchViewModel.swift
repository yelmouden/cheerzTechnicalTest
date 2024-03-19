//
//  File.swift
//  
//
//  Created by Yassin El Mouden on 19/03/2024.
//

import Foundation
import Dependencies
import Observation
import SharedModels
import Utils

@Observable
final class SearchViewModel {

    // MARK: Dependencies

    @ObservationIgnored
    @Dependency(\.seachRepository) var searchRepository

    // MARK: Public Properties

    var state: LoadingState<[Photo]> = .idle

    // MARK: Private Properties
    private var searchedText: String = ""
    private var currentPage = 1
    
    // total pages for last seach
    private var totalPages: Int = 1

    private var photos: [Photo] = []

    private var taskPagnition: Task<Void, Never>?

    // MARK: Public Methods

    @MainActor
    func search(text: String, shouldLoadNextPage: Bool = false) async {
        let previousSearch = searchedText
        self.searchedText = text

        if text.isEmpty {
            self.state = .idle
            return
        }

        if previousSearch == text && !shouldLoadNextPage {
            return
        }

        // cancel the previous request for pagination
        if !shouldLoadNextPage {
            taskPagnition?.cancel()
            taskPagnition = nil
        }

        do {
            
            try await Task.sleep(for: .milliseconds(200))

            // new request, reset photos array and current page
            if !shouldLoadNextPage {
                state = .loading
                photos.removeAll()
                currentPage = 1
            }

            let result = try await searchRepository.search(text, currentPage)

            totalPages = result.totalPages


            photos.append(contentsOf: result.photos)
            state = .loaded(photos)

            taskPagnition = nil

        } catch {
            if !(error is CancellationError), !shouldLoadNextPage {
                state = .error
            }
        }
    }

    func loadNextPage() {
        guard currentPage + 1 <= totalPages, taskPagnition == nil else { return }

        currentPage += 1

        self.taskPagnition = Task {
            await search(text: searchedText, shouldLoadNextPage: true)
        }
    }
}

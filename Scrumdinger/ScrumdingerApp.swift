//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by Junjie Yang on 2022-04-23.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    @StateObject private var store = ScrumStore()
    @State private var errorWrapper: ErrorWrapper?
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ScrumsView(scrums: $store.scrums) {
                    ScrumStore.save(scrums: store.scrums) {result in
                        Task {
                            do {
                                try await ScrumStore.save(scrums: store.scrums)
                            } catch {
                                errorWrapper = ErrorWrapper(error: error, guidance: "try again later")
                            }
                        }
                    }
                }
                .task {
                    do {
                        store.scrums = try await ScrumStore.load()
                    } catch {
                        errorWrapper = ErrorWrapper(error: error, guidance: "try again later")
                    }
                }
                .sheet(item: $errorWrapper, onDismiss:  {
                    store.scrums = DailyScrum.sampleData
                }) {
                    wrapper in
                    ErrorView(errorWrapper: wrapper)
                }
            }
        }
    }
}

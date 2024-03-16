//
//  NetworkingTests.swift
//  
//
//  Created by Yassin El Mouden on 16/03/2024.
//

import Dependencies
import Nimble
import XCTest

@testable import Networking

final class NetworkingTests: XCTestCase {

    var tested: Networking { Networking(apiEndPoint: "www.apple.com") }

    func testNetworking_shouldReturnCorrectData_whenRequestSucceeded() async {
        let networking = withDependencies {
            let data = try! JSONEncoder().encode(MockItem(title: "title", description: "Description"))
            $0.requester = AnyRequester(requester: MockRequester(result: .success(data)))
        } operation: {
            tested
        }

        do {
            let result: MockItem = try await networking.request(service: MockService.mock)
            expect(result) == MockItem(title: "title", description: "Description")
        } catch {
            XCTFail("this test should return the correct data")
        }
    }

    func testNetworking_shouldThrowError_whenRequestFailed() async {
        let networking = withDependencies {
            $0.requester = AnyRequester(requester: MockRequester(result: .failure(URLError.init(URLError.Code.badServerResponse))))
        } operation: {
            tested
        }

        do {
            let _: MockItem = try await networking.request(service: MockService.mock)
            XCTFail("request call did not throw an error")
        } catch {}
    }

    func testNetworking_shouldThrowError_whenDecodingFailed() async {
        let networking = withDependencies {
            let data = try! JSONEncoder().encode(["title": "test"])
            $0.requester = AnyRequester(requester: MockRequester(result: .success(data)))
        } operation: {
            tested
        }

        do {
            let _: MockItem = try await networking.request(service: MockService.mock)
            XCTFail("request call did not throw an error")
        } catch {
            expect(error as? DecodingError).notTo(beNil())
        }
    }

}

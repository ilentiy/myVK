// GetDataOperation.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire

/// Операция по получению данных
final class GetDataOperation: AsyncOperation {
    // MARK: - Private Properties

    private var request: DataRequest

    // MARK: - Public Properties

    var data: Data?

    // MARK: - Init

    init(request: DataRequest) {
        self.request = request
    }

    // MARK: - Public Methods

    override func main() {
        request.responseData(queue: DispatchQueue.global()) { [weak self] response in
            guard let self = self else { return }
            self.data = response.data
            self.state = .finished
        }
    }
}

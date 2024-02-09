import SwiftUI

//{
//  "fact": "Cats are one of, if not the most, popular pet in the world.",
//  "length": 56
//}

struct CatFact: Codable {
    let fact: String
    let length: Int
}

struct CatFactIterator: AsyncIteratorProtocol {
    private var count: Int
    private let url = URL(string: "https://catfact.ninja/fact")!

    init(count: Int) {
        self.count = count
    }

    mutating func next() async throws -> CatFact? {
        guard count > 0 else {
            return nil
        }

        count -= 1

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let catFact = try JSONDecoder().decode(CatFact.self, from: data)
            return catFact
        } catch {
            throw error
        }
    }
}

struct CatFactSequence: AsyncSequence {
    typealias Element = CatFact
    let count: Int

    func makeAsyncIterator() -> CatFactIterator {
        CatFactIterator(count: count)
    }
}

func fetchCatFacts(count: Int) async throws {
    let sequence = CatFactSequence(count: count)

    for try await catFact in sequence {
        print(catFact.fact)
    }
}

Task {
    do {
        try await fetchCatFacts(count: 5)
    } catch {
        print("Error fetching cat facts: \(error)")
    }
}

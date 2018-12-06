import ReSwift

let loggingMiddleware: Middleware<Any> = { _, _ in { next in
    return { action in
        // perform middleware logic
        print(action)

        // call next middleware
        return next(action)
    }
}
}

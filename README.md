inspired by http://sapandiwakar.in/refresh-oauth-tokens-using-moya-rxswift/

Usage:

```swift
DataAPIProvider.rx
            .request(.something)
            .filterSuccessfulStatusCodes()
            .retryWithAuthIfNeeded()
```


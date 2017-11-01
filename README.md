inspired by http://sapandiwakar.in/refresh-oauth-tokens-using-moya-rxswift/

Usage:

```swift
DateProvider.rx
            .request(.something)
            .filterSuccessfulStatusCodes()
            .retryWithAuthIfNeeded()
```


public protocol Icon {
  var id: String { get }
}

public enum DefaultIcons: String, Icon, CaseIterable {
  
     case addCircle = "add-circle"
     case addContact = "add-contact"
     case allCategories = "all-categories"
     case analyze = "analyze"
     case applePay = "apple-pay"
     case atmPin = "atm-pin"
     case atm = "atm"
     case attach = "attach"
     case battery = "battery"
     case bitcoin = "bitcoin"
     case calculator = "calculator"
     case calendar = "calendar"
     case camera = "camera"
     case cardFill = "card-fill"
     case card = "card"
     case cashOut = "cash-out"
     case cedears = "cedears"
     case challengeFill = "challenge-fill"
     case challenge = "challenge"
     case chat = "chat"
     case checkCircleEmpty = "check-circle-empty"
     case checkCircleFill = "check-circle-fill"
     case checkCircle = "check-circle"
     case check = "check"
     case clock = "clock"
     case close = "close"
     case comment = "comment"
     case commision = "commision"
     case copy = "copy"
     case deniedCircleFill = "denied-circle-fill"
     case deniedCircle = "denied-circle"
     case dollarMep = "dollar-mep"
     case dollar = "dollar"
     case down = "down"
     case download = "download"
     case due = "due"
     case edit = "edit"
     case education = "education"
     case electricity = "electricity"
     case erase = "erase"
     case externalLink = "external-link"
     case faceId = "face-id"
     case filter = "filter"
     case fingerPrint = "finger-print"
     case freeze = "freeze"
     case gallery = "gallery"
     case gift = "gift"
     case helpCircleFill = "help-circle-fill"
     case helpCircle = "help-circle"
     case hidePassword = "hide-password"
     case homeFill = "home-fill"
     case home = "home"
     case income = "income"
     case infoCircleFill = "info-circle-fill"
     case infoCircle = "info-circle"
     case insurance = "insurance"
     case internationalMoney = "international-money"
     case investment = "investment"
     case leftDouble = "left-double"
     case left = "left"
     case less = "less"
     case link = "link"
     case loans = "loans"
     case logOut = "log-out"
     case loyaltyFill = "loyalty-fill"
     case loyalty = "loyalty"
     case mail = "mail"
     case maps = "maps"
     case market = "market"
     case medicalCenter = "medical-center"
     case menu = "menu"
     case mobile = "mobile"
     case moneyCircle = "money-circle"
     case moreFill = "more-fill"
     case moreOptions = "more-options"
     case more = "more"
     case mpos = "mpos"
     case notepad = "notepad"
     case notification = "notification"
     case outcome = "outcome"
     case password = "password"
     case paymentFill = "payment-fill"
     case payment = "payment"
     case phone = "phone"
     case pinRecover = "pin-recover"
     case pin = "pin"
     case plus = "plus"
     case products = "products"
     case qrFill = "qr-fill"
     case qr = "qr"
     case recharge = "recharge"
     case `repeat` = "repeat"
     case rightDouble = "right-double"
     case right = "right"
     case saleFill = "sale-fill"
     case sale = "sale"
     case savings = "savings"
     case scanBarcode = "scan-barcode"
     case search = "search"
     case security = "security"
     case share = "share"
     case shipping = "shipping"
     case showPassword = "show-password"
     case standbyCircleFill = "standby-circle-fill"
     case standbyCircle = "standby-circle"
     case storesFill = "stores-fill"
     case stores = "stores"
     case time = "time"
     case transferFill = "transfer-fill"
     case transfer = "transfer"
     case transport = "transport"
     case travel = "travel"
     case trophy = "trophy"
     case up = "up"
     case user = "user"
     case wallet = "wallet"
     case warningCircleFill = "warning-circle-fill"
     case warningCircle = "warning-circle"
  
  public var id: String {
      return self.rawValue
  }
}

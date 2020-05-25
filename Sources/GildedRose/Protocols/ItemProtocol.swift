protocol ItemProtocol {
    var item: Item { get }
    func update()
}

extension ItemProtocol {
    
    // Default sellIn decrement
    func decrementSellIn() {
        item.sellIn -= 1
    }
    
    // Default quality difference
    func qualityDifference() -> Int {
        return item.sellIn >= 0 ? 1 : 2
    }
}

struct BackstagePassItem: ItemProtocol {
    let item: Item
    
    func update() {
        decrementSellIn()
        let quality = item.quality + qualityDifference()
        if item.sellIn < 0 {
            item.quality = 0
        } else {
            item.quality = quality < 50 ? quality : 50
        }
    }
    
    func qualityDifference() -> Int {
        if item.sellIn < 0 {
            return 0
        } else if item.sellIn < 5 {
            return 3
        } else if item.sellIn < 10 {
            return 2
        } else {
            return 1
        }
    }
}

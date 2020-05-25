struct AgedBrieItem: ItemProtocol {
    let item: Item
    
    func update() {
        decrementSellIn()
        let quality = item.quality + qualityDifference()
        item.quality = quality < 50 ? quality : 50
    }
}

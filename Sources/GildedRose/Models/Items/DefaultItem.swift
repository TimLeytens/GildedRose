struct DefaultItem: ItemProtocol {
    let item: Item
    
    func update() {
        decrementSellIn()
        let quality = item.quality - qualityDifference()
        item.quality = quality > 0 ? quality : 0
    }
}

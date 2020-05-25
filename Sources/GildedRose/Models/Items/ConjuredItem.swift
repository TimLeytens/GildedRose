struct ConjuredItem: ItemProtocol {
    let item: Item
    
    func update() {
        decrementSellIn()
        let quality = item.quality - (qualityDifference() * 2)
        item.quality = quality > 0 ? quality : 0
    }
}

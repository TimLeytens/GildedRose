struct ItemFactory {
    
    let item: Item

    private let agedBrie = "Aged Brie"
    private let sulfuras = "Sulfuras, Hand of Ragnaros"
    private let backstagePasses = "Backstage passes to a TAFKAL80ETC concert"
    private let conjured = "Conjured Mana Cake"

    func make() -> ItemProtocol {
        switch item.name {
        case agedBrie:
            return AgedBrieItem(item: item)
        case sulfuras:
            return SulfurasItem(item: item)
        case backstagePasses:
            return BackstagePassItem(item: item)
        case conjured:
            return ConjuredItem(item: item)
        default:
            return DefaultItem(item: item)
        }
    }
}

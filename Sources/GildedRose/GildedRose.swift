public class GildedRose {
    
    let items: [Item]
    
    required public init(items: [Item]) {
        self.items = items
    }
    
    public func updateQuality() {
        items
            .map { ItemFactory(item: $0).make() }
            .forEach { $0.update() }
    }
}
